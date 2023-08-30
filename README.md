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

## Technologies Used

- Language: R
- Visualization Tools: Tableau
- Integrated Development Environment (IDE): R Studio

## Dataset Information

After preprocessing, the dataset contains 70,031 rows and 7 columns, combining information from both export and import files.

## Code Examples

Below is an example of how the data can be visualized using R and Tableau:

```R
# Load required libraries
library(ggplot2)
library(dplyr)

# Read the CSV files
export_data <- read.csv("2018-2010_export.csv")
import_data <- read.csv("2018-2010_import.csv")

# Perform data manipulation and visualization
# Example: Create a bar plot of export values by year
export_plot <- export_data %>%
  group_by(year) %>%
  summarize(total_export = sum(value)) %>%
  ggplot(aes(x = year, y = total_export)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Total Export Values by Year", x = "Year", y = "Total Export Value")

# Display the plot
print(export_plot)
