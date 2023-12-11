apture log close
log using analysis_log.txt, replace text
clear

/*

NAME: Sam Lee

Data Assignment #3

This file will preform regression to answer to research question at hand


************************************
*/

//Merge our data sets and load it into STATA
do construct-data.do

log close
