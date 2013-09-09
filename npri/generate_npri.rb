#!/usr/bin/env ruby

require 'csv'
require 'json'
require 'sqlite3'

npri_data = File.open("1993-2011_NPRI_GEO_2013_02_19.csv").read
# npri_data = File.open("test.csv").read

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

db = SQLite3::Database.new("1993-2011_NPRI_GEO_2013_02_19.sqlite3")

db.execute("drop table if exists npri")

db.execute <<-SQL
create table npri (
  lastreport text,
  npri_id    integer primary_key,
  comp_name  text,
  faci_name  text,
  address1   text,
  address2   text,
  landsurvey text,
  city       text,
  province   text,
  postal_zip text,
  lati_dec   text,
  long_dec   text,
  datum      text,
  csduid     text,
  csdname    text,
  cmauid     text,
  cmaname    text,
  cduid      text,
  cdname     text,
  eruid      text,
  ername     text,
  fsa        text,
  ecozone_id text,
  ecozone_e  text,
  ecozone_f  text,
  wscmda_id  text,
  wscmda_en  text,
  wscmda_fr  text,
  soma       text,
  onpema     text,
  qcpema     text,
  qc_windsor text
)
SQL

insert = db.prepare <<-SQL
   insert into 'npri'
   (lastreport,
    npri_id,    
    comp_name,  
    faci_name,  
    address1,   
    address2,   
    landsurvey, 
    city,       
    province,   
    postal_zip, 
    datum,      
    csduid,     
    csdname,    
    cmauid,    
    cmaname,    
    cduid,      
    cdname,     
    eruid,      
    ername,     
    fsa,        
    ecozone_id, 
    ecozone_e,  
    ecozone_f,  
    wscmda_id,  
    wscmda_en,  
    wscmda_fr,  
    soma,       
    onpema,     
    qcpema,     
    qc_windsor)
values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
SQL

csv.each do |row|

  STDERR.puts row[:npri_id]

  properties = {
#    "lastreport" => row[:lastreport],
    "npri_id"    => row[:npri_id],
    "comp_name"  => row[:comp_name],
    "faci_name"  => row[:faci_name],
#    "address1"   => row[:address1],
#    "address2"   => row[:address2],
#    "landsurvey" => row[:landsurvey],
    "city"       => row[:city],
    "province"   => row[:province],
#    "postal_zip" => row[:postal_zip],
#    "datum"      => row[:datum],
#    "csduid"     => row[:csduid],
#    "csdname"    => row[:csdname],
#    "cmauid"     => row[:cmauid],
#    "cmaname"    => row[:cmaname],
#    "cduid"      => row[:cduid],
#    "cdname"     => row[:cdname],
#    "eruid"      => row[:eruid],
#    "ername"     => row[:ername],
#    "fsa"        => row[:fsa],
#    "ecozone_id" => row[:ecozone_id],
#    "ecozone_e"  => row[:ecozone_e],
#    "ecozone_f"  => row[:ecozone_f],
#    "wscmda_id"  => row[:wscmda_id],
#    "wscmda_en"  => row[:wscmda_en],
#    "wscmda_fr"  => row[:wscmda_fr],
#    "soma"       => row[:soma],
#    "onpema"     => row[:onpema],
#    "qcpema"     => row[:qcpema],
#    "qc_windsor" => row[:qc_windsor],
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

  insert.execute("#{row[:lastreport]}",
    "#{row[:npri_id]}",   
    "#{row[:comp_name]}", 
    "#{row[:faci_name]}", 
    "#{row[:address1]}",  
    "#{row[:address2]}",  
    "#{row[:landsurvey]}",
    "#{row[:city]}",      
    "#{row[:province]}",  
    "#{row[:postal_zip]}",
    "#{row[:datum]}",     
    "#{row[:csduid]}",    
    "#{row[:csdname]}",   
    "#{row[:cmauid]}",    
    "#{row[:cmaname]}",   
    "#{row[:cduid]}",     
    "#{row[:cdname]}",    
    "#{row[:eruid]}",     
    "#{row[:ername]}",    
    "#{row[:fsa]}",       
    "#{row[:ecozone_id]}",
    "#{row[:ecozone_e]}", 
    "#{row[:ecozone_f]}", 
    "#{row[:wscmda_id]}", 
    "#{row[:wscmda_en]}", 
    "#{row[:wscmda_fr]}", 
    "#{row[:soma]}",      
    "#{row[:onpema]}",    
    "#{row[:qcpema]}",    
    "#{row[:qc_windsor]}"
  )

end

insert.close
db.close

output = { 
  "type"     => "FeatureCollection",
  "features" => features
}

puts output.to_json




