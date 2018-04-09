#########################################################################################
# Epidemiological Week Data ####
#########################################################################################

# load_data.R script
source('~/GitHub/PAHO_dengue/load_data.R')

glimpse(d_epiwk)

# change names where all white space is replaced with underscore
names(d_epiwk) <- gsub("\\s","_",names(d_epiwk))

# select relevant columns/variables
epiwk <- d_epiwk %>% #select columns of interest
  select(EW,Year, #dates
         Country,PAHO_Code,PAHO_Code_Num,ISO3166Alpha2,ISO3166Alpha3,Iso3166,Region, #locations
         Deaths,Lab_Confirm,Severe_Dengue,Suspected,Serotype,Type) %>% #case info
  arrange(Year,EW) #arrange by Year and EW

epiwk %>% count(Year,PAHO_Code) %>% arrange(desc(n))

epiwk %>% filter(PAHO_Code == "BRA")

ggplot(data = epiwk %>% filter(PAHO_Code == "BRA")) +
  geom_jitter(aes(x=Year,y=Suspected,col=EW))

ggplot(data = epiwk %>% filter(PAHO_Code == "BRA")) +
  geom_jitter(aes(x=EW,y=Severe_Dengue,col=as.factor(Year)))

  # add variable that corresponds with epi week per year
table(d_epiwk$Year)
table(d_epiwk$EW)

paste0(d_epiwk$EW,",",d_epiwk$Year)

# Arrange the data so it is chronological
d_epiwk %>% arrange(EW,Year)

epiwk %>% mutate(date_wk = paste0(EW,"-",Year)) %>% 
  select(EW,Year,date_wk) %>% sample_n(10) %>% arrange(date_wk)

d_epiwk 