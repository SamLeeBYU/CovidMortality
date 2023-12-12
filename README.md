---
Author: Sam Lee
Date: 12/12/2023
---

## Introduction

In this analysis I seek to estimate the causal effect that 2020 COVID-19 mortality rates had on per-county housing prices in the United States in 2021. According to elementary economic theory, all else equal, when consumers of a good leave a market, demand decreases. This implies that prices decrease at every quantity demanded (Law of Demand). This theory may be grimly applied when we analyze COVID-19 mortality deaths from 2020. According to the Law of Demand, all else equal, we would assume that on average, housing prices would decrease given the decrease in the number of consumers in the housing market per county. Not only can this be empirically tested using econometric methods, but additionally, this could provide compelling evidence for why providing early care for COVID-related illnesses may have real economic benefits and impacts in external markets.

---

The conclusions and methodology for this analysis can be read [here](memo.pdf)

## Reproduce the Results:
1) Clone the repository
2) Run [Scripts/analysis.do](Scripts/analysis.do).
- This will simultaneously call [construct_data.do](Scripts/construct-data.do), which will merge the four necessary [data files](#data-sources). The analysis.do script will then run the regression and output the results to a log file called [analysis_log.txt](Log/analysis_log.txt).

NOTE: [zip-county.csv](Data/zip-county.csv) is a file created by calling the python script, [zip-county.py](Scripts/zip-county.py). This uses HUD's ZIP-County Crosswalk [API](https://www.huduser.gov/portal/dataset/uspszip-api.html).

Alternatively the final output file created by [construct_data.do](Scripts/construct-data.do) is [covid_housing.csv](Data/covid_housing.csv). Results can also be duplicated by manually running a regression using the variables defined in that file.

## Scripts

#### [construct-data.do](Scripts/construct-data.do)

This STATA script takes the four raw data sets ([us-counties-2020.csv](Data/us-counties-2020.csv), [co-est2022-pop.xlsx](Data/co-est2022-pop.xlsx), [HPI_AT_BDL_ZIP3.xlsx](Data/HPI_AT_BDL_ZIP3.xlsx), [zip-county.csv](Data/zip-county.csv)) and merges it into the final data set that will be used for the final econometric analysis.

#### [analysis.do](Scripts/analysis.do)

This STATA script runs the appropriate regression to estimate the effect that COVID-19 mortality rates had on per county housing rates.

#### [zip-county.py](Scripts/zip-county.py)

This script accesses the ZIP-County Crosswalk database using HUD's API and creates [zip-county.csv](Data/zip-county.csv).

## Data Sources

#### Per-County COVID-19 Mortality Rates ([us-counties-2020.csv](Data/us-counties-2020.csv))

This data set consists of the 2020 per-county COVID-19 mortality rates from the publicly updated repository maintained by the New York Times: [https://github.com/nytimes/covid-19-data](https://github.com/nytimes/covid-19-data).

#### County Population Totals ([co-est2022-pop.xlsx](Data/co-est2022-pop.xlsx))

County population totals and estimates for the year 2020 was obtained through the U.S. Census Bureau: [https://www.census.gov/data/tables/time-series/demo/popest/2020s-counties-total.html](https://www.census.gov/data/tables/time-series/demo/popest/2020s-counties-total.html).

#### Zip-Level Housing Prices ([HPI_AT_BDL_ZIP3.xlsx](Data/HPI_AT_BDL_ZIP3.xlsx))

Housing price indices at the 3-digit ZIP level for 2021 was obtained through data maintained by the Federal Finance Housing Agency (FHFA): [https://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index-Datasets.aspx](https://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index-Datasets.aspx).

#### ZIP-County Crosswalk ([zip-county.csv](Data/zip-county.csv))

The data that matches which ZIP codes belong appropriately in which counties for 2021 was obtained through the U.S. Department of Housing and Urban Development's database: [https://www.huduser.gov/portal/datasets/usps_crosswalk.html](https://www.huduser.gov/portal/datasets/usps_crosswalk.html).

---

All other files in the **Data** directory are intermediate files that come as a result of running [construct-data.do](Scripts/construct-data.do) or [zip-county.py](Scripts/zip-county.py).