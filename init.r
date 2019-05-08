library(tidyverse)
library(rgdal)

map_proj = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")  # use this projection for all boundaries
