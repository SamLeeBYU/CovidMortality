capture log close
log using construct_data_log.txt, replace text
clear

/*

NAME: Sam Lee

Data Assignment #3

This STATA code will merge in all the data sets and create a single file for data analysis.


************************************
*/

//NYT COVID-19 Mortality Data Set (2020)
import delimited "../Data/us-counties-2020.csv", varnames(1) clear

//Each county's total mortality over 2020
collapse (sum) deaths, by(fips county state)

sort state county
save "../Data/county-deaths.dta", replace

//Load in U.S. Census Data
import excel "../Data/co-est2022-pop.xlsx", cellrange(A5:E3149) clear

rename A county_state
rename B est_2020
rename C pop_2020
rename D est_2021
rename E est_2022
drop est_*

//Drop the US Population
drop in 1

//Extract state from the county_state
gen state = substr(county_state, index(county_state, ",") + 2, .)

//Extract County
gen county_temp = subinstr(subinstr(county_state, ".", "", 1), " County, " + state, "", 1)

// Extract county from the modified county_state
gen county_temp2 = regexs(1) if regexm(county_temp, "^(.*), " + state + "$")

gen county = ""
replace county = county_temp if missing(county_temp2)
replace county = county_temp2 if ~missing(county_temp2)

drop county_*

//Specific cases that failed to merge that need to be remedied
replace county = "Anchorage" if county == "Anchorage Municipality"
replace county = "Yakutat plus Hoonah-Angoon" if county =="Yakutat City and Borough"
replace county = "Bristol Bay plus Lake and Peninsula" if county == "Bristol Bay Borough"
replace county = "DoÃ±a Ana" if county == "Doña Ana"
//For Louisiana Counties
replace county = subinstr(county, " Parish", "", .)

//Create 2020 COVID-19 Mortality by Merging in NYT County Mortality and merging it with the U.S. Census Data

sort state county
merge 1:1 county state using "../Data/county-deaths.dta"

sort state county
keep if _merge == 3
drop _merge

//Deaths per 1000 
gen mortality_rate = deaths/(pop_2020/1000)

save "../Data/mortality.dta", replace

//Load in the Housing Price Data
import excel "../Data/HPI_AT_BDL_ZIP3.xlsx", firstrow clear
drop G
drop in 1/5

rename HPIforThreeDigitZIPCodesA zip
rename B year
rename C pct_change
rename D hpi
rename E hpi_1990_base
rename F hpi_2000_base

drop in 1
drop pct_change hpi hpi_1990_base
rename hpi_2000_base hpi

//Convert to numeric
destring hpi, replace

export delimited using "../Data/housing_prices_full.csv", replace

destring year, replace
//Only keep the lag variables in the model
keep if year >= 2015 & year <= 2021

//Reshape the data so we can to a m:1 merge later with zip-county crosswalk
//We need to have each lagged HPI variable as its own column vector
sort zip year
reshape wide hpi, i(zip) j(year)

save "../Data/housing_prices.dta", replace

//Load in ZIP-County Crosswalk
import delimited "../Data/zip-county.csv", varnames(1) clear
rename geoid fips
gen zip3 = substr(string(zip), 1, 3)

//Keep quarter 4 since it is the end of the year
keep if quarter == 4
drop quarter
drop zip
rename zip3 zip

//Merge ZIP-County Crosswalk and 2021 Housing Price Data
merge m:1 zip using "../Data/housing_prices.dta"
sort state city
keep if _merge == 3
drop _merge

//This will be merged in with with the more descriptive state name from mortality.dta
drop state

//Transform HPI into the mean of the HPI from each county (as an average of the HPIs from each zip code)
collapse (mean) hpi*, by(fips)

//Merge it with 2020 COVID-19 Mortality Data
merge m:1 fips using "../Data/mortality.dta"
keep if _merge == 3
drop _merge
sort state county

//Save the final data set for analysis
save "../Data/covid_housing.dta", replace
export delimited using "../Data/covid_housing.csv", replace

log close