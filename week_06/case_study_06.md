Case Study 06
================
Ehsan Ul Hoque Tanim
October 11, 2022

## Load Library

``` r
library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(ncdf4)
```

## Load ‘world’ data from spData package

``` r
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","crudata.nc",method = "curl")
tmean = raster("crudata.nc")

nc = nc_open("crudata.nc")

world_sp <- world %>% 
  filter(name_long != "Antarctica") %>%
  as("Spatial")

plot(tmean)
```

![](case_study_06_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
names(tmean) <- "tmax"

tmax_country <- tmean %>%
  raster::extract(y=world_sp, fun=max, na.rm=T, small=T, sp=T)%>% st_as_sf()

ggplot(tmax_country,aes(fill=tmax))+
  geom_sf()+
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+
  theme(legend.position = 'bottom')
```

![](case_study_06_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

``` r
hottest_country=tmax_country %>% 
group_by(continent) %>% 
  top_n(tmax,n=1) %>% 
select(name_long,continent,tmax) %>% 
  arrange(desc(tmax)) %>% 
  st_set_geometry(NULL)

hottest_country
```

    ## # A tibble: 7 × 3
    ## # Groups:   continent [7]
    ##   name_long                           continent                tmax
    ## * <chr>                               <chr>                   <dbl>
    ## 1 Australia                           Oceania                  32  
    ## 2 Somalia                             Africa                   27.7
    ## 3 Paraguay                            South America            27.7
    ## 4 Timor-Leste                         Asia                     27.6
    ## 5 Costa Rica                          North America            26.1
    ## 6 Albania                             Europe                   12.5
    ## 7 French Southern and Antarctic Lands Seven seas (open ocean)   7.1
