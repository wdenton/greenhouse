#!/usr/bin/env ruby

require 'csv'
require 'json'

npri_data = File.open("1993-2011_NPRI_GEO_2013_02_19.csv").read

csv = CSV.parse(npri_data, {:headers => true, :header_converters => :symbol})

# Columns in the file
# 
# | Original   | Parsed     |
# | LASTREPORT | lastreport |
# | NPRI_ID    | npri_id    |
# | COMP_NAME  | comp_name  |
# | FACI_NAME  | faci_name  |
# | ADDRESS1   | address1   |
# | ADDRESS2   | address2   |
# | LANDSURVEY | landsurvey |
# | CITY       | city       |
# | PROVINCE   | province   |
# | POSTAL_ZIP | postal_zip |
# | LATI_DEC   | lati_dec   |
# | LONG_DEC   | long_dec   |
# | DATUM      | datum      |
# | CSDUID     | csduid     |
# | CSDNAME    | csdname    |
# | CMAUID     | cmauid     |
# | CMANAME    | cmaname    |
# | CDUID      | cduid      |
# | CDNAME     | cdname     |
# | ERUID      | eruid      |
# | ERNAME     | ername     |
# | FSA        | fsa        |
# | ECOZONE_ID | ecozone_id |
# | ECOZONE_E  | ecozone_e  |
# | ECOZONE_F  | ecozone_f  |
# | WSCMDA_ID  | wscmda_id  |
# | WSCMDA_EN  | wscmda_en  |
# | WSCMDA_FR  | wscmda_fr  |
# | SOMA       | soma       |
# | ONPEMA     | onpema     |
# | QCPEMA     | qcpema     |
# | QC_Windsor | qc_windsor |

# Dump fresh, clean CSV to STDOUT, with new headers
# puts csv.headers.to_csv
# csv.each do |row|
#   puts row.to_csv
# end

features = []

csv.each do |row|

  properties = {
    "lastreport" => row[:lastreport],
    "npri_id"    => row[:npri_id],
    "comp_name"  => row[:comp_name],
    "faci_name"  => row[:faci_name],
    "address1"   => row[:address1],
    "address2"   => row[:address2],
    "landsurvey" => row[:landsurvey],
    "city"       => row[:city],
    "province"   => row[:province],
    "postal_zip" => row[:postal_zip],
    "datum"      => row[:datum],
    "csduid"     => row[:csduid],
    "csdname"    => row[:csdname],
    "cmauid"     => row[:cmauid],
    "cmaname"    => row[:cmaname],
    "cduid"      => row[:cduid],
    "cdname"     => row[:cdname],
    "eruid"      => row[:eruid],
    "ername"     => row[:ername],
    "fsa"        => row[:fsa],
    "ecozone_id" => row[:ecozone_id],
    "ecozone_e"  => row[:ecozone_e],
    "ecozone_f"  => row[:ecozone_f],
    "wscmda_id"  => row[:wscmda_id],
    "wscmda_en"  => row[:wscmda_en],
    "wscmda_fr"  => row[:wscmda_fr],
    "soma"       => row[:soma],
    "onpema"     => row[:onpema],
    "qcpema"     => row[:qcpema],
    "qc_windsor" => row[:qc_windsor],
  }

  geometry = {
    "type"        => "Point",
    "coordinates" => [row[:long_dec].to_f, row[:lati_dec].to_f],
  }

  feature = {
    "type"       => "Feature",
    "properties" => properties,
    "geometry"   => geometry
  }

  features << feature

end

output = { 
  "type"     => "FeatureCollection",
  "features" => features
}

puts output.to_json

