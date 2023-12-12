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