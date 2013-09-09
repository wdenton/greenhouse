Greenhouse gas emissions data.

## 2011 Canada Greenhouse Gas Emissions

One file is available: a GeoJSON representaion of the 2011 data: [2011_canada_ghg_emissions.geojson](greenhouse-gases-2011/2011_canada_ghg_emissions.geojson).  This shows all sites in Canada that emitted more than 50,000 metric tonnes of CO2 equivalent gases in 2011.

Source: [Greenhouse gas emissions from large facilities, Canada, 2011](http://maps-cartes.ec.gc.ca/indicators-indicateurs/TableView.aspx?ID=1)

The [Interactive Indicator Map](http://maps-cartes.ec.gc.ca/indicators-indicateurs/Default.aspx?) is a decent view with much supplementary information, but I wanted to get the data out into a format I find more reusable.

Example of supplementary information: [York University's Keele Campus](http://maps-cartes.ec.gc.ca/indicators-indicateurs/detailPage.aspx?lang=en&type=ghg&objectid=503) detail page shows historical data (in this case, just two years).

Note about the data, from the map page:

> Note: Unlike the National Inventory Report, which compiles GHG data at a national level and is developed from national and provincial statistics, the federal Facility GHG Emissions Reporting Program applies only to the largest GHG emitters in Canada (e.g. industrial and other types of facilities). In the Facility GHG Emissions Reporting Program, all facilities that emit the equivalent of 50,000 tonnes (50 kt) of CO2 equivalent of GHG per year are required to submit a report."
>
> Emissions data for all the reporting facilities are available for download from the data page. Some facilities are not mapped because of unreported geographic coordinates and/or the non-point source nature of the facility (such as pipelines).

Conversion:

1. Download raw data from http://maps-cartes.ec.gc.ca//CESI_Services/DataService/1/en, save as `Greenhouse_Gas_Emissions.tsv`
1. `./ec-ghg-to-geojson.rb > 2011_canada_ghg_emissions.geojson`
1. Test JSON with `jsonlint 2011_canada_ghg_emissions.geojson`

(Note to self: `curl` doesn't download the whole file for me; stops with exit code 18 ("Partial file") ... why?)

<!--
See info link at http://www.ene.gov.on.ca/environment/en/resources/collection/data_downloads/index.htm#GHG

[Metadata DetailPage](http://files.ontariogovernment.ca/moe_mapping/downloads/1Air/GHG_by_year/GHG2011.html) for 2011 data.

[Metadata Detail Page for 2010 data](http://files.ontariogovernment.ca/moe_mapping/downloads/1Air/GHG_by_year/GHG2010.html)

-->

### More data

The data above has the total of CO2e, but [Reported Facility Greenhouse Gas Data](http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=8044859A-1) has detailed breakdowns of emissions by gas for years 2004--2011.  A [Facility Data Search](http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?lang=En) leads to a [full view of 2011 data](http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?do=results&lang=en&year=2011&gas=all&fac_name=&prov=all&city=&naics=all&submit=Submit) which can be downloaded in XLS.  (Is it useful to convert that into a more usable format?)

The National Inventory Report is mentioned above.  [Canada's Greenhouse Gas Inventory](http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=83A34A7A-1) explains:

> The NIR, along with the Common Reporting Format (CRF) tables, comprise [Canada’s inventory submission to the United Nations Framework Convention on Climate Change](http://unfccc.int/national_reports/annex_i_ghg_inventories/national_inventories_submissions/items/7383.php) and are prepared in accordance with the UNFCCC Reporting Guidelines on annual inventories, [Decision 14/CP 11](http://unfccc.int/documentation/documents/advanced_search/items/6911.php?priref=600003988), and other relevant decisions.

The UNFCCC is the United Nations Framework Convention on Climate Change, and its [National Inventory Submissions 2013](http://unfccc.int/national_reports/annex_i_ghg_inventories/national_inventories_submissions/items/7383.php) is a massive store of aggregate data, country by country, about greenhouse gas emissions.  (It's broken up into per-year Excel spreadsheets; perhaps the data can be made more reusable, or perhaps it already has.)

## NPRI (National Pollutant Release Inventory) data

Two files are available:

1. [Simplified GeoJSON representation](npri/1993-2011_NPRI_GEO_2013_02_19.geojson)
1. [SQLite3 database with all data](npri/1993-2011_NPRI_GEO_2013_02_19.sqlite3)

NPRI ID numbers are used in reports about greenhouse gases and other pollutants. This data set is especially useful because it gives latitude and longitude for each NPRI site, which doesn't appear in some other reports.

The GeoJSON file only contains a few of the fields in the SQLite3 database: enough to see what the location is but not much more.  The database has far more informtion.  See the source site for details on what's what.

Source: [National Pollutant Release Inventory Facility Location Table](http://www.ec.gc.ca/inrp-npri/default.asp?lang=En&n=20DE1DC2-1)

Conversion:

1. Download raw data from http://www.ec.gc.ca/inrp-npri/20DE1DC2-B2CB-4EFE-AAAB-3F24B836A460/1993-2011_NPRI_GEO_2013_02_19.xls
1. Convert to CSV (here it's [npri/1993-2011_NPRI_GEO_2013_02_19.csv](1993-2011_NPRI_GEO_2013_02_19.csv))
1. `./generate_npri.rb > 1993-2011_NPRI_GEO_2013_02_19.geojson` (confusingly dumps STDOUT to a file but silently creates a SQLite3 database)

TODO: NPRI data will make a good simple web service.

<!--

Canada's Greenhouse Gas Inventory
http://www.ec.gc.ca/ges-ghg/default.asp?lang=En&n=83A34A7A-1

Link to NIR and CRF data at the UNFCCC (which would be great data to play with)
(also look for geolocated US data)



Look for Downloadable Emissions Data (Excel but it's not)


http://www.ec.gc.ca/ges-ghg/donnees-data/index.cfm?do=results_excel&excel=true&lang=en&year=2011&gas=all&fac_name=&prov=all&city=&naics=all&x=Submit

--> 


## Copyright and license information

This data is reformatted and reshaped from sources provided by the Government of Canada. Environment Canada's [Copyright/Permission to Reproduce](http://www.ec.gc.ca/default.asp?lang=En&xml=5830C36B-1773-4E3E-AF8C-B21F54633E0A) notice says:

> Information on this website has been posted with the intent that it be readily available for personal or public non-commercial use and may be reproduced, in part or in whole, and by any means, without charge or further permission, unless otherwise specified.
>
> Users are required to:
>
>    Exercise due diligence in ensuring the accuracy of the materials reproduced;
>    Indicate both the complete title of the materials reproduced, as well as the author organization; and
>    Indicate that the reproduction is a copy of an official work that is published by the Government of Canada and that the reproduction has not been produced in affiliation with or with the endorsement of the Government of Canada.
>
> Unless otherwise specified, this authorization is also applicable to all published information regardless of its format.

All of this work is done with those restrictions in mind, and also [with the hopes that the Canadian government will release its data under a CC0 license](http://wiki.creativecommons.org/CC0_use_for_data).



