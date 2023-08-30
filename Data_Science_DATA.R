library(dplyr)

#importing our datasets
import_data = read.csv("/Users/HP/Desktop/2018-2010_import.csv",header = TRUE)
export_data = read.csv("/Users/HP/Desktop/2018-2010_export.csv",header = TRUE)
View(import_data)
View(export_data)

#Streamlining column names
colnames(import_data)[2] = ("commodity")
colnames(export_data)[2] = ("commodity")
colnames(import_data)[3] = ("import_value")
colnames(export_data)[3] = ("export_value")


# Replacing the names of large commodities with smaller ones for better visualization
import_data <- import_data %>% 
  mutate(commodity = recode(commodity, 'PRODUCTS OF ANIMAL ORIGIN, NOT ELSEWHERE SPECIFIED OR INCLUDED.' = 'ANIMAL PRODUCTS.' ,
                            'NUCLEAR REACTORS, BOILERS, MACHINERY AND MECHANICAL APPLIANCES; PARTS THEREOF.' = 'NUCLEAR EQUIPMENT.' ,
                            'OPTICAL, PHOTOGRAPHIC CINEMATOGRAPHIC MEASURING, CHECKING PRECISION, MEDICAL OR SURGICAL INST. AND APPARATUS PARTS AND ACCESSORIES THEREOF;' = 'OPTICAL INSTRUMENTS.' ,
                            'FURNITURE; BEDDING, MATTRESSES, MATTRESS SUPPORTS, CUSHIONS AND SIMILAR STUFFED FURNISHING; LAMPS AND LIGHTING FITTINGS NOT ELSEWHERE SPECIFIED OR INC.' = 'FURNITURE.' ,
                            'ELECTRICAL MACHINERY AND EQUIPMENT AND PARTS THEREOF; SOUND RECORDERS AND REPRODUCERS, TELEVISION IMAGE AND SOUND RECORDERS AND REPRODUCERS,AND PARTS.' = 'ELECTRICAL MACHINERY' ,
                            'RAILWAY OR TRAMWAY LOCOMOTIVES, ROLLING-STOCK AND PARTS THEREOF; RAILWAY OR TRAMWAY TRACK FIXTURES AND FITTINGS AND PARTS THEREOF; MECHANICAL' = 'RAILWAY MACHINERY' , 
                            'TANNING OR DYEING EXTRACTS; TANNINS AND THEIR DERI. DYES, PIGMENTS AND OTHER COLOURING MATTER; PAINTS AND VER; PUTTY AND OTHER MASTICS; INKS.' = 'TANNING  EXTRACTS' , 
                            'PREPARATIONS OF MEAT, OF FISH OR OF CRUSTACEANS, MOLLUSCS OR OTHER AQUATIC INVERTEBRATES' = 'PREPARATIONS OF NONVEG FOOD' , 
                            'EXPLOSIVES; PYROTECHNIC PRODUCTS; MATCHES; PYROPHORIC ALLOYS; CERTAIN COMBUSTIBLE PREPARATIONS.' = 'EXPLOSIVES' ,
                            'VEGETABLE PLAITING MATERIALS; VEGETABLE PRODUCTS NOT ELSEWHERE SPECIFIED OR INCLUDED.' = 'VEGETABLE PLAITING MATERIALS' ,
                            'ARTICLES OF APPAREL AND CLOTHING ACCESSORIES, NOT KNITTED OR CROCHETED.' = 'CLOTHING' , 
                            'OTHER MADE UP TEXTILE ARTICLES; SETS; WORN CLOTHING AND WORN TEXTILE ARTICLES; RAGS' = 'TEXTILES' , 
                            'VEHICLES OTHER THAN RAILWAY OR TRAMWAY ROLLING STOCK, AND PARTS AND ACCESSORIES THEREOF.' = 'SPARE PARTS'))

export_data <- export_data %>% 
  mutate(commodity = recode(commodity, 'PRODUCTS OF ANIMAL ORIGIN, NOT ELSEWHERE SPECIFIED OR INCLUDED.' = 'ANIMAL PRODUCTS.' ,
                            'NUCLEAR REACTORS, BOILERS, MACHINERY AND MECHANICAL APPLIANCES; PARTS THEREOF.' = 'NUCLEAR EQUIPMENT.' ,
                            'OPTICAL, PHOTOGRAPHIC CINEMATOGRAPHIC MEASURING, CHECKING PRECISION, MEDICAL OR SURGICAL INST. AND APPARATUS PARTS AND ACCESSORIES THEREOF;' = 'OPTICAL INSTRUMENTS.' ,
                            'FURNITURE; BEDDING, MATTRESSES, MATTRESS SUPPORTS, CUSHIONS AND SIMILAR STUFFED FURNISHING; LAMPS AND LIGHTING FITTINGS NOT ELSEWHERE SPECIFIED OR INC.' = 'FURNITURE.' ,
                            'ELECTRICAL MACHINERY AND EQUIPMENT AND PARTS THEREOF; SOUND RECORDERS AND REPRODUCERS, TELEVISION IMAGE AND SOUND RECORDERS AND REPRODUCERS,AND PARTS.' = 'ELECTRICAL MACHINERY' ,
                            'RAILWAY OR TRAMWAY LOCOMOTIVES, ROLLING-STOCK AND PARTS THEREOF; RAILWAY OR TRAMWAY TRACK FIXTURES AND FITTINGS AND PARTS THEREOF; MECHANICAL' = 'RAILWAY MACHINERY' , 
                            'TANNING OR DYEING EXTRACTS; TANNINS AND THEIR DERI. DYES, PIGMENTS AND OTHER COLOURING MATTER; PAINTS AND VER; PUTTY AND OTHER MASTICS; INKS.' = 'TANNING  EXTRACTS' , 
                            'PREPARATIONS OF MEAT, OF FISH OR OF CRUSTACEANS, MOLLUSCS OR OTHER AQUATIC INVERTEBRATES' = 'PREPARATIONS OF NONVEG FOOD' , 
                            'EXPLOSIVES; PYROTECHNIC PRODUCTS; MATCHES; PYROPHORIC ALLOYS; CERTAIN COMBUSTIBLE PREPARATIONS.' = 'EXPLOSIVES' ,
                            'VEGETABLE PLAITING MATERIALS; VEGETABLE PRODUCTS NOT ELSEWHERE SPECIFIED OR INCLUDED.' = 'VEGETABLE PLAITING MATERIALS' ,
                            'ARTICLES OF APPAREL AND CLOTHING ACCESSORIES, NOT KNITTED OR CROCHETED.' = 'CLOTHING' , 
                            'OTHER MADE UP TEXTILE ARTICLES; SETS; WORN CLOTHING AND WORN TEXTILE ARTICLES; RAGS' = 'TEXTILES' , 
                            'VEHICLES OTHER THAN RAILWAY OR TRAMWAY ROLLING STOCK, AND PARTS AND ACCESSORIES THEREOF.' = 'SPARE PARTS'))


# Fixing Some Country Names
import_data <- import_data %>% 
  mutate(country = recode(country, 'U K' = 'UK',
                            'U S A' = 'USA',
                            'AFGHANISTAN TIS' = 'AFGHANISTAN',
                            'BAHARAIN IS' = 'BAHARAIN',
                            'BANGLADESH PR' = 'BANGLADESH',
                            'BOSNIA-HRZGOVIN' = 'BOSNIA',
                            'BURKINA FASO' = 'BURKINA',
                            'CHINA P RP' = 'CHINA'))

export_data <- export_data %>% 
  mutate(country = recode(country, 'U K' = 'UK',
                          'U S A' = 'USA',
                          'AFGHANISTAN TIS' = 'AFGHANISTAN',
                          'BAHARAIN IS' = 'BAHARAIN',
                          'BANGLADESH PR' = 'BANGLADESH',
                          'BOSNIA-HRZGOVIN' = 'BOSNIA',
                          'BURKINA FASO' = 'BURKINA',
                          'CHINA P RP' = 'CHINA'))

#replacing NULL values with 0
for(i in 2:ncol(import_data))
  {
    import_data[ ,i][is.na(import_data[ , i])] = 0
  }
for(i in 2:ncol(export_data))
  {
    export_data[ ,i][is.na(export_data[ , i])] = 0
  }

#Merging the import and export data
total_data = merge.data.frame(import_data,export_data,by=c("HSCode","country","year"))
head(total_data)
View(total_data)

#Dropping redundant columns in total_data
if(all(total_data$commodity.x == total_data$commodity.y))
{
  total_data = total_data[ , -6]
}

#Streamlining column names in total_data
colnames(total_data)[4] = ("commodity")

#calculating trade deficit in total data
total_data <- total_data %>%
  mutate(trade_deficit = (import_value - export_value))

                                                          #Queries
#Trade Details by Country
total_data %>% group_by(country) %>%
              summarise(Export = sum(export_value) , Imports = sum(import_value) , Deficit = sum(trade_deficit))

total_data <- total_data %>%
  mutate(total_trade = (import_value + export_value))

#Import/Export over the years
total_data %>% group_by(year) %>%
  summarise(Export = sum(export_value) , Imports = sum(import_value) , Deficit = sum(trade_deficit))

#Top commodities Exported by India
total_data %>% group_by(commodity) %>%
  summarise(Top_export = sum(export_value)) %>%
    arrange(desc(Top_export))

#Top commodities Imported by India
total_data %>% group_by(commodity) %>%
  summarise(Top_import = sum(import_value)) %>%
    arrange(desc(Top_import))

#Major trade partners by commodities traded
total_data %>% group_by(country , commodity) %>%
  summarise(Total_Trade = sum(total_trade)) %>%
    arrange(desc(Total_Trade))

#largest trade deficit
total_data %>%  group_by(country) %>%
  summarise(Total_Deficit = sum(trade_deficit)) %>%
    arrange(desc(Total_Deficit))

#Major trade partners by Value of trade
total_data %>%  group_by(country) %>%
  summarise(Top_by_value = sum(total_trade)) %>%
  arrange(desc(Top_by_value))


#exporting processed data
write.csv(total_data ,"/Users/HP/Desktop\\Total_Trade_Data_2010-2018.csv", row.names = FALSE)
