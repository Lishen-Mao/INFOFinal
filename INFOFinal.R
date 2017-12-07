#Downloading MODIS GPP data 
library (MODIStsp)
MODIStsp()

# load necessary packages

library(raster)
library(sp)
library(rgdal)
#
setwd('C:/Users/Lishen Mao/Documents/INFO 8000 Assignment 3/Final_INFO/INFOFinal/Gross_PP_8Days_1Km_v5/GPP/')
# boundary shapefile for flux tower at grand bay
GrandBay <- readOGR(dsn = ".", "Flux_tower_repro")
#go through all tif flies and save to GBM1000_2015_GB_forGPP
getwd()
GBM1000_2015_GB_forGPP <- list.files(pattern="*.tif")
#create a raster stack for all tif files
GBM1000_2015_GB_stack <- lapply(GBM1000_2015_GB_forGPP, raster)
#extract GPP value for flux tower pixel.
GBM1000_2015_GB_extract <- lapply(GBM1000_2015_GB_stack, extract, GrandBay)
#switch to arcgis to extract values to flux tower pixel
