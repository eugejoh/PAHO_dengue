#########################################################################################
# Epidemiological Week Data ####
#########################################################################################

# load_data.R script
# source('~/GitHub/PAHO_dengue/load_data.R')

glimpse(d_epiwk)

# change names where all white space is replaced with underscore
names(d_epiwk) <- gsub("\\s","_",names(d_epiwk))

# select relevant columns/variables
epiwk <- d_epiwk %>% #select columns of interest
  select(EW,Year, #dates
         Country,PAHO_Code,PAHO_Code_Num,ISO3166Alpha2,ISO3166Alpha3,Iso3166,Region, #locations
         Deaths,Lab_Confirm,Severe_Dengue,Suspected,Serotype,Type) %>% #case info
  arrange(Year,EW) #arrange by Year and EW

# remove all rows with 2018 (incomplete data)
epiwk <- epiwk %>% filter(Year != 2018)

epiwk %>% count(Year,PAHO_Code) %>% arrange(desc(n))

epiwk %>% filter(PAHO_Code == "BRA")

lapply(epiwk, function(x) sum(is.na(x))) %>% 
  unlist() %>% data.frame(missing_values = .) %>% 
  mutate(name = rownames(.)) %>% 
  mutate(percent_missing = round(missing_values/nrow(.),1)) %>%
  select(name,missing_values,percent_missing)

purrr::map_df(epiwk,~sum(is.na(.))) %>% gather(key = name,value = missing_values) %>%
  mutate(percent_missing = round(missing_values/nrow(.),1))

unique(epiwk$Country)
length(unique(epiwk$Country))
epiwk_count <- epiwk %>% group_by(Year,EW) %>% count() %>%
  mutate(missing_country = n/length(unique(epiwk$Country))) %>% data.frame

ggplot(epiwk_count, aes(x=EW,y=missing_country,col=as.factor(Year))) +
  geom_path() + geom_point(stroke = 0.5) +
  labs(title = "Dengue Reporting to PAHO by Year",
       subtitle = "2014-2017",
       y = "Reporting Proportion (non-missing)", x = "Epidemiological Week Number") +
  scale_colour_brewer(guide_legend(title = "Year"), type = "seq", palette = 1,direction = 1) +
  theme_dark()

epiwk %>% group_by(Country,Year,EW) %>% count() %>% mutate(error = if_else(n != 1, "not 1", "okay")) %>% 
  filter(error == "not 1") %>% data.frame

ggplot(data = epiwk %>% filter(PAHO_Code == "BRA")) +
  geom_jitter(aes(x=Year,y=Suspected,col=EW))

ggplot(data = epiwk %>% filter(PAHO_Code == "BRA"),
       aes(x=EW,y=Severe_Dengue,col=(Year))) +
  geom_point()

  # add variable that corresponds with epi week per year
table(d_epiwk$Year)
table(d_epiwk$EW)

paste0(d_epiwk$EW,",",d_epiwk$Year)

# Arrange the data so it is chronological
d_epiwk %>% arrange(EW,Year)

epiwk %>% mutate(date_wk = paste0(EW,"-",Year)) %>% 
  select(EW,Year,date_wk) %>% sample_n(10) %>% arrange(date_wk)

d_epiwk 