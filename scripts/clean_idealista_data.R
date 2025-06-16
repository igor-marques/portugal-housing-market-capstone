# Data Cleaning Script for Portuguese Housing Market Analysis
# Created: June 16, 2025
# Author: Igor Marques
# Description: Imports, cleans, and transforms Idealista housing price data
# Input: Raw Excel files with housing prices by region
# Output: Clean CSV files in both long and wide formats

# Load required packages
library(readxl)     # For reading Excel files
library(dplyr)      # For data manipulation
library(tidyr)      # For reshaping data
library(stringr)    # For string manipulation
library(lubridate)  # For date handling
library(purrr)      # For functional iteration
library(readr)      # For number parsing with locale

# Set working directory to your project folder
setwd("C:/Dropbox/google_ds/github/portugal-housing-market-capstone")

# Define paths to raw data files
sales_file <- "data/raw/idealista_venda.xlsx"
rental_file <- "data/raw/idealista_arrendamento.xlsx"

# Define function to clean a single sheet
clean_idealista_sheet <- function(sheet_name, file_path, price_type) {
  # Skip the sources sheet
  if (sheet_name == "sources") {
    return(NULL)
  }
  
  # Extract region name from sheet name
  region <- str_replace(sheet_name, "^(arrendamento|venda)_", "")
  
  # Read and clean the sheet
  read_excel(file_path, sheet = sheet_name) %>%
    select(month = 1, price_per_sqm = 2) %>%
    # Convert text "N/A" to actual NA values before filtering
    mutate(price_per_sqm = na_if(price_per_sqm, "N/A")) %>%
    filter(!is.na(price_per_sqm)) %>%
    mutate(
      # Clean price - handle comma as decimal separator and remove €/m2
      price_per_sqm = readr::parse_number(as.character(price_per_sqm), locale = locale(decimal_mark = ",")),
      
      # Clean month string
      month = str_squish(month),
      
      # Extract year and month
      year = as.numeric(str_extract(month, "\\d{4}")),
      month_name = str_remove(month, "\\s*\\d{4}"),
      
      # Convert Portuguese month names to month numbers
      month_num = case_when(
        str_detect(month_name, "^Janeiro") ~ 1,
        str_detect(month_name, "^Fevereiro") ~ 2,
        str_detect(month_name, "^Março") ~ 3,
        str_detect(month_name, "^Abril") ~ 4,
        str_detect(month_name, "^Maio") ~ 5,
        str_detect(month_name, "^Junho") ~ 6,
        str_detect(month_name, "^Julho") ~ 7,
        str_detect(month_name, "^Agosto") ~ 8,
        str_detect(month_name, "^Setembro") ~ 9,
        str_detect(month_name, "^Outubro") ~ 10,
        str_detect(month_name, "^Novembro") ~ 11,
        str_detect(month_name, "^Dezembro") ~ 12,
        TRUE ~ NA_real_
      ),
      
      # Create proper date (first day of month)
      date = make_date(year, month_num, 1),
      
      # Add metadata
      region = region,
      price_type = price_type
    ) %>%
    
    # Select only the columns we need
    select(date, region, price_type, price_per_sqm)
}

# Get list of sheet names
sales_sheets <- excel_sheets(sales_file)
rental_sheets <- excel_sheets(rental_file)

# Process all sheets and combine into one dataframe
sales_data <- map_dfr(sales_sheets, clean_idealista_sheet, 
                      file_path = sales_file, price_type = "sale")

rental_data <- map_dfr(rental_sheets, clean_idealista_sheet, 
                       file_path = rental_file, price_type = "rental")

# Combine sales and rental data
all_data <- bind_rows(sales_data, rental_data)

# Create output directory if it doesn't exist
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

# Save the cleaned long-format data (CSV and RDS)
write_csv(all_data, "data/processed/idealista_prices_clean.csv")
saveRDS(all_data, "data/processed/idealista_prices_clean.rds")

# Create a wide format version
wide_data <- all_data %>%
  pivot_wider(
    id_cols = date,
    names_from = c(region, price_type),
    names_sep = "_",
    values_from = price_per_sqm
  )

# Save the wide format data (CSV and RDS)
write_csv(wide_data, "data/processed/idealista_prices_wide.csv")
saveRDS(wide_data, "data/processed/idealista_prices_wide.rds")

# Print summary
cat("Data cleaning complete!\n")
cat("Total observations:", nrow(all_data), "\n")
cat("Date range:", min(all_data$date), "to", max(all_data$date), "\n")
cat("Number of regions:", length(unique(all_data$region)), "\n")
cat("Files saved to data/processed/ directory\n")

# Display first few rows of the data
head(all_data)