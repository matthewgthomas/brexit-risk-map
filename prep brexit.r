##
## Prepare Brexit (ha)
##
library(tidyverse)
library(jsonlite)
library(geojsonio)

source("init.r")


#############################################################################################
## Hospitals/trusts
##
nhs = read_csv("data/nhs.csv")


#############################################################################################
## Blood donation centres
##
blood = read_csv("data/blood-donation-centres.csv")


#############################################################################################
## Ports
##
# source: http://www.worldportsource.com/ports/GBR.php
ports = jsonlite::read_json("data/ports.json", simplifyVector = T)

# keep only medium and large ports
ports = ports %>% 
  filter(size %in% c("3", "4") | name %in% c("Holyhead Harbour", "Port of Fishguard")) %>% 
  mutate(lat = as.numeric(lat),
         lng = as.numeric(lng)) %>% 
  select(name, stateName, authority, location, size, lat, lng)


#############################################################################################
## Airports
##
airports = geojson_read("data/airports.geojson", what = "sp")

airports = spTransform(airports, map_proj)


#############################################################################################
## M20
## source: https://www.ordnancesurvey.co.uk/business-and-government/products/os-open-roads.html
##
m20 = geojson_read("data/m20.geojson", what = "sp")
a55 = geojson_read("data/a55.geojson", what = "sp")


#############################################################################################
## Sundry locations 
##
other_points = geojson_read("data/other.geojson", what = "sp")
