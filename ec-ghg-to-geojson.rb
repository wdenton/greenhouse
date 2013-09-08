#!/usr/bin/env ruby

require 'csv'

ghg_data = File.open("Greenhouse_Gas_Emissions.tsv", "r:ISO-8859-1").read

csv = CSV.parse(ghg_data, {:col_sep => "\t", :headers => true, :header_converters => :symbol})

# Columns in the file
#
#   Facility ID
#   Organisation Name
#   Facility Name
#   Province
#   City
#   Address Postal Code
#   NPRI ID
#   2011 GHG Emissions (kilotonnes of carbon dioxide equivalent)
#   Facility GHG Data Link
#   NAICS Name
#   NAICS Data Link
#   Latitude
#   Longitude
#
# Columns as parsed here (seen with csv.headers)
#   facility_id
#   organisation_name
#   facility_name
#   province
#   city
#   address
#   postal_code
#   npri_id
#   2011_ghg_emissions_kilotonnes_of_carbon_dioxide_equivalent
#   facility_ghg_data_link
#   naics_name
#   naics_data_link
#   latitude
#   longitude


# Dump fresh, clean CSV to STDOUT, with new headers
puts csv.headers.to_csv
csv.each do |row|
  puts row.to_csv
end

exit

