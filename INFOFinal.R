#Downloading MODIS GPP data 
library (MODIStsp)
MODIStsp()

# load necessary packages

library(raster)
library(sp)
library(rgdal)
library(xlsx)
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

##MarshSR means "Marsh surface reflectance", read the data from my csv file into 'MarshSR'.
MarshSR<-read.csv("modis500m_gulfcoast_processed.csv")
#Create a new column 'EVI' and Calculate its value for each row in MarshSR dataset.
MarshSR$EVI1 <- 2.5*((MarshSR$band2-MarshSR$band1)/(1+MarshSR$band2+(6*MarshSR$band1)-7.5*MarshSR$band3))
#Filter the data in my MarshSR dataset where pixel equals 'NE' and site equals 'GB', and copy these data to a new variable
GBNEEVI<-subset(MarshSR, pixel == "NE" & site == "GB")
#Adding new column to A data frame and make it equals to EVI1
GBNEEVI["EVI"]<- GBNEEVI$EVI1
#Exporting data to a new table
write.xlsx(GBNEEVI,getwd())
