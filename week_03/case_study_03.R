library(ggplot2)
library(gapminder)
library(dplyr)

#remove Kuwait from data set
ExKuwait_gapminder <- filter(gapminder, country!= "Kuwait")

#Now plot GDP Per Capita vs Life Expectency
f1 <- ggplot(ExKuwait_gapminder, aes(lifeExp, gdpPercap, color = continent, size = pop/100000))+
  geom_point()+
  facet_wrap(~year, nrow= 1)+
  scale_y_continuous(trans = "sqrt")+
  theme_bw()+
  labs(title= "Wealth and life expectancy through time", 
       y= "GDP Per Capita",
       x= "Life Expectancy",
       size= "Population(100k)",
       color = "Continent")
f1

ggsave("f1.png", width= 15 ,units= "in")


#prepare data for plot2
gapminder_continent<- ExKuwait_gapminder %>% 
  group_by(continent, year) %>%
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop)
            ,pop = sum(as.numeric(pop)))

#Now plot GDP per capita vs year
f2 <- ggplot(data= ExKuwait_gapminder, aes(year,gdpPercap))+
  geom_line(aes(color=continent, group= country))+ 
  geom_point(aes(color=continent, group= country))+
  geom_line(data= gapminder_continent, aes(year,gdpPercapweighted))+
  geom_point(data= gapminder_continent,aes(year,gdpPercapweighted, size = pop/100000))+
  facet_wrap(~continent, nrow= 1)+
  theme_bw()+
  labs(y= "GDP Per Capita",
       x= "Year",
       size= "Population(100k)",
       color="Continent")
f2
ggsave("f2.png", width= 15 ,units= "in")