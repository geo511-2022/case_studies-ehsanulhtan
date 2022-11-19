library(tidyverse)

library(viridis)

dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
#To generate the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")


temp = read.table(dataurl,
                  skip=3,
                  na="999.90",
                  col.names = c("YEAR", "JAN" , "FEB" , "MAR" ,
                                "APR", "MAY" , "JUN" , "JUL" , 
                                "AUG" , "SEP" , "OCT" , "NOV" ,
                                "DEC" , "DJF" , "MAM" , "JJA" ,
                                "SON" , "metANN"))

summary(temp)

ggplot(temp, mapping=aes(x= YEAR, y= JJA))+
  geom_line()+
  geom_smooth(method = 'loess', formula='y ~ x',color="red")+
  labs(title= "Mean Summer Temperatures in Buffalo,NY", 
       subtitle = "  Summer includes June, July and August 
  Data from the Global Historical Network
  Red line is a LOESS smooth", 
       y= "Mean Summer Temperatures(C)",
       x= "YEAR")

png("Case02.png",
    width=300, height= 500)

dev.off()