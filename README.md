Greenhouse gas emissions data.

## 2011 Canada Greenhouse Gas Emissions

Source: http://maps-cartes.ec.gc.ca/indicators-indicateurs/TableView.aspx?ID=1

Raw: [Greenhouse\_Gas\_Emissions.tsv] (it downloads incorrectly as .xls)

GeoJSON: [2011_canada_ghg_emissions.geojson]

Conversion:

1. Download raw data from [http://maps-cartes.ec.gc.ca//CESI_Services/DataService/1/en]
1. `ec-ghg-to-geojson.rb > 2011_canada_ghg_emissions.geojson`
1. Test JSON with `jsonlint 2011_canada_ghg_emissions.geojson`

(Note to self: `curl` doesn't download the whole file for me; stops with exit code 18 ("Partial file") ... why?)

