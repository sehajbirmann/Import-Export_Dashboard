# Indian Export and Import Data Visualization

This repository contains scripts and data for visualizing Indian export and import data using various graphs. The dataset used for this project includes two CSV files: `2018-2010_export.csv` and `2018-2010_import.csv`. These files contain export and import data from the years 2010 to 2018, respectively.

## Features

### HSCode
The Harmonized System (HSCode) is a standardized numerical method used to classify traded products. It is globally recognized by customs authorities for identifying products during duties and taxes assessment and for statistical purposes.

### Commodity
Commodity refers to the name of the product as per the HS2 classification.

### Value
The 'value' column represents the monetary value of the export or import transactions based on the data frames.

### Country
The 'country' column specifies the country involved in the export or import transactions as per the data frames.

### Year
The 'year' column indicates the year of the export or import transactions.

## Methodology

To visualize the Indian export and import data, we utilize the R programming language and Tableau for generating insightful graphs and charts. The methodology involves loading and preprocessing the provided CSV files, performing data aggregation and manipulation, and creating graphical representations to showcase trends and patterns in the data.

## Description

This project aims to provide a visual representation of Indian export and import data to help stakeholders and analysts understand trade trends over the specified period. By using a combination of R's data manipulation capabilities and Tableau's interactive visualizations, we present a comprehensive view of the trade dynamics.

## Input / Output

- **Input**: The input data consists of two CSV files: `2018-2010_export.csv` and `2018-2010_import.csv`. These files contain trade data including HSCode, commodity, value, country, and year.
- **Output**: The output includes various types of graphs and charts generated from the input data, showcasing trends and insights related to Indian export and import activities.

## Live Link

For a live demonstration of the visualizations created from the Indian export and import data, you can visit the following link: [Live Visualization](https://public.tableau.com/app/profile/sehajbir.singh.mann/viz/DataScience_Project-1_Sehajbir_102003478/IndiasTradeOverYears?publish=yes)

## Screenshot of the Interface

[Dashboard_DS](https://github.com/sehajbirmann/Import-Export_Dashboard/assets/72991473/bb4abc88-9fe9-421e-9067-3d69578b239f)

## Technologies Used

- Language: R
- Visualization Tools: Tableau
- Integrated Development Environment (IDE): R Studio

## Dataset Information

After preprocessing, the dataset contains 70,031 rows and 7 columns, combining information from both export and import files.

## Code Examples

Below is an example of how the data is processed using R in R Studio. You can see ![Data_Science_DATA.R](Data_Science_DATA.R) file for further details:

```R
# Load required libraries
library(ggplot2)
library(dplyr)

# Read the CSV files
import_data = read.csv("/Users/HP/Desktop/2018-2010_import.csv",header = TRUE)
export_data = read.csv("/Users/HP/Desktop/2018-2010_export.csv",header = TRUE)

# Perform data manipulation
#Merging the import and export data
total_data = merge.data.frame(import_data,export_data,by=c("HSCode","country","year"))
View(total_data)

#calculating trade deficit in total data
total_data <- total_data %>%
  mutate(trade_deficit = (import_value - export_value))


