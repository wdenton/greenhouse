#!/usr/bin/env ruby

require 'csv'
require 'json'

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
# puts csv.headers.to_csv
# csv.each do |row|
#   puts row.to_csv
# end

features = []

csv.each do |row|

  properties = {
    "facility_id" => row[:facility_id],
    "organisation_name" => row[:organisation_name],
    "facility_name" => row[:facility_name],
    "province" => row[:province],
    "city" => row[:city],
    "address" => row[:address],
    "postal_code" => row[:postal_code],
    "npri_id" => row[:npri_id],
    "2011_ghg_emissions_kilotonnes_of_carbon_dioxide_equivalent" => row[:'2011_ghg_emissions_kilotonnes_of_carbon_dioxide_equivalent'].to_f,
    "facility_ghg_data_link" => row[:facility_ghg_data_link],
    "naics_name" => row[:naics_name],
    "naics_data_link" => row[:naics_data_link],
  }
  geometry = {
    "type" => "Point",
    "coordinates" => [row[:longitude].to_f, row[:latitude].to_f],
  }
  feature = {
    "type" => "Feature",
    "properties" => properties,
    "geometry" => geometry
  }
  features << feature
end

output = { 
  "type" => "FeatureCollection",
  "features" => features
}

puts output.to_json

