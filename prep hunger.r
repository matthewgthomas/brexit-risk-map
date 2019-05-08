##
## Prepare England hunger risk index data for mapping
##
library(tidyverse)
library(readxl)
library(rgdal)
library(rmapshaper)
library(spdplyr)

source("init.r")


#############################################################################################
## Load boundaries
##
# Middle Layer Super Output Areas (using super generalised clipped because they're the smallest file size)
# source: http://geoportal.statistics.gov.uk/datasets/middle-layer-super-output-areas-december-2011-super-generalised-clipped-boundaries-in-england-and-wales
# I manually removed all Wales MSOAs using QGIS
msoa_bounds = readOGR(dsn = "data",  # change this to 
                      layer = "MSOA_England",
                      verbose = F)

# transform to WGS84 - web Mercator
msoa_bounds = spTransform(msoa_bounds, map_proj)

# simplify the boundaries
msoa_bounds = ms_simplify(msoa_bounds)

# get rid of columns we don't need
msoa_bounds = msoa_bounds %>% select(msoa11cd, msoa11nm)


#############################################################################################
## Load hunger index
## - from Smith et al. (2018) Identifying populations and areas at greatest risk of household food insecurity in England: https://www.sciencedirect.com/science/article/abs/pii/S0143622817301340
##
hunger = read_excel("data/hunger.xlsx")

# merge the hunger risk rate quintiles into the map data
msoa_bounds@data = msoa_bounds@data %>% 
  left_join(hunger %>% select(MSOAcode, RiskRateQ), by = c("msoa11cd" = "MSOAcode"))
