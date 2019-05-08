library(tidyverse)
library(jsonlite)
library(geojsonio)

# source: http://www.worldportsource.com/ports/GBR.php
ports = jsonlite::read_json("C:\\Users\\040026704\\Documents\\Data science\\Data\\Brexit\\ports.json", simplifyVector = T)

# keep only medium and large ports
ports %>% 
  filter(size %in% c("3", "4")) %>% 
  select(name, stateName, authority, location, size, lat, lng) %>% 
  write_csv("C:\\Users\\040026704\\Documents\\Data science\\Data\\Brexit\\ports.csv")

cc_json = geojson_json(ports)

# save as geoJSON
geojson_write(cc_json, file = "C:\\Users\\040026704\\Documents\\Data science\\Data\\Brexit\\ports.geojson")
