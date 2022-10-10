Case Study 06
================
Ehsan Ul Hoque Tanim
October 11, 2022

\##Load Library

``` r
library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
```

\##Load ‘world’ data from spData package

``` r
data_without_antarctica <- world %>%
  filter(continent != "Antarctica")

world_sp <- as(world, "Spatial")
```
