//Merge our data sets and load it into STATA (t=2021)
do construct-data.do

capture log close
log using analysis_log.txt, replace text

/*

NAME: Sam Lee

Data Assignment #3

This file will preform regression to estimate the effect of whether 2020 COVID-19 mortality had an effect on 2021 Housing Prices

************************************
*/

//For convenience
rename hpi2021 hpi

//Allocating a fixed effect for each state (-1)
//Alabama is base state
xi i.state

//Regression (see Log/analysis_log.txt for regression output)
reg hpi mortality_rate hpi20* _Istate_*

log close
