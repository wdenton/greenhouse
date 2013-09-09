Greenhouse gas emissions data.

## 2011 Canada Greenhouse Gas Emissions

One file is available: a GeoJSON representaion of the 2011 data: [2011_canada_ghg_emissions.geojson].  This shows all sites in Canada that emitted more than 50,000 metric tonnes of CO2 equivalent gases in 2011.

Source: [Greenhouse gas emissions from large facilities, Canada, 2011](http://maps-cartes.ec.gc.ca/indicators-indicateurs/TableView.aspx?ID=1)

The [Interactive Indicator Map](http://maps-cartes.ec.gc.ca/indicators-indicateurs/Default.aspx?) is a decent view with much supplementary information, but I wanted to get the data out into a format I find more reusable.

Example of supplementary information: [York University's Keele Campus](http://maps-cartes.ec.gc.ca/indicators-indicateurs/detailPage.aspx?lang=en&type=ghg&objectid=503) detail page shows historical data (in this case, just two years).

> Note: Unlike the National Inventory Report, which compiles GHG data at a national level and is developed from national and provincial statistics, the federal Facility GHG Emissions Reporting Program applies only to the largest GHG emitters in Canada (e.g. industrial and other types of facilities). In the Facility GHG Emissions Reporting Program, all facilities that emit the equivalent of 50,000 tonnes (50 kt) of CO2 equivalent of GHG per year are required to submit a report."
> Emissions data for all the reporting facilities are available for download from the data page. Some facilities are not mapped because of unreported geographic coordinates and/or the non-point source nature of the facility (such as pipelines).

Conversion:

1. Download raw data from [http://maps-cartes.ec.gc.ca//CESI_Services/DataService/1/en], save as `Greenhouse_Gas_Emissions.tsv`
1. `ec-ghg-to-geojson.rb > 2011_canada_ghg_emissions.geojson`
1. Test JSON with `jsonlint 2011_canada_ghg_emissions.geojson`

(Note to self: `curl` doesn't download the whole file for me; stops with exit code 18 ("Partial file") ... why?)

<!--
See info link at http://www.ene.gov.on.ca/environment/en/resources/collection/data_downloads/index.htm#GHG

[Metadata DetailPage](http://files.ontariogovernment.ca/moe_mapping/downloads/1Air/GHG_by_year/GHG2011.html) for 2011 data.

[Metadata Detail Page for 2010 data](http://files.ontariogovernment.ca/moe_mapping/downloads/1Air/GHG_by_year/GHG2010.html)

-->

## NPRI (National Pollutatnt Release Inventory) data

Two files are available:

1. [Simplified GeoJSON representation](npri/1993-2011_NPRI_GEO_2013_02_19.geojson])
1. [SQLite3 database with all data](npri/1993-2011_NPRI_GEO_2013_02_19.sqlite3])

NPRI ID numbers are used in reports about greenhouse gases and other pollutants. This data set is especially useful because it gives latitude and longitude for each NPRI site, which doesn't appear in some other reports.  (NPRI data will make a good simple web service.)

Source: [National Pollutant Release Inventory Facility Location Table](http://www.ec.gc.ca/inrp-npri/default.asp?lang=En&n=20DE1DC2-1)

Conversion:

1. Download raw data from http://www.ec.gc.ca/inrp-npri/20DE1DC2-B2CB-4EFE-AAAB-3F24B836A460/1993-2011_NPRI_GEO_2013_02_19.xls]
1. Convert to CSV (here it's [npri/1993-2011_NPRI_GEO_2013_02_19.csv])
1. `./npri_location_table.rb > 1993-2011_NPRI_GEO_2013_02_19.geojson` (confusingly dumps STDOUT to a file but silently creates a SQLite3 database)

<!-- Interactive map:

http://maps-cartes.ec.gc.ca/indicators-indicateurs/default.aspx?id=1&Xmin=-15307263.2217053&Ymin=4878962.72110015&xmax=-5718983.26419751&ymax=11140696.5709012&lang=en.

--> 

<!-- Source: Environment Canada (2013) Overview of the Reported 2011 Greenhouse Gas Emissions.

Facility Greenhouse Gas Reporting
http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=040E378D-1


Reported Facility Greenhouse Gas Data
http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=8044859A-1

Facility Data Search
http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?lang=En

which leads to a full 2011 view:
http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?do=results&lang=en&year=2011&gas=all&fac_name=&prov=all&city=&naics=all&submit=Submit

which can be downloaded in XLS
http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?do=results_excel&excel=true&lang=en&year=2011&gas=all&fac_name=&prov=all&city=&naics=all&x=Submit


Canada's Greenhouse Gas Inventory
http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=83A34A7A-1

Link to NIR and CRF data at the UNFCCC (which would be great data to play with)
(also look for geolocated US data)



Look for Downloadable Emissions Data (Excel but it's not)


http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?do=results_excel&excel=true&lang=en&year=2011&gas=all&fac_name=&prov=all&city=&naics=all&x=Submit

--> 



