# Load required libraries
library(readxl)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(readr) # For write_csv function

# Set working directory to your project folder
setwd("C:/Dropbox/google_ds/github/portugal-housing-market-capstone")

# Read the INE Excel file, specifically sheet 'Q2', skipping the header rows
ine_data <- read_excel("data/raw/Quadros PT.xlsx", sheet = "Q2", skip = 5)

# Clean column names - focusing on national totals (first 3 columns: Period, Valor, Nº)
# Based on the image, these correspond to columns A, B, and C
colnames(ine_data)[1] <- "period"
colnames(ine_data)[2] <- "transaction_value_thousands"
colnames(ine_data)[3] <- "transaction_count"

# Select only the relevant columns and clean up the data
ine_cleaned <- ine_data %>%
  select(period, transaction_value_thousands, transaction_count) %>%
  # Filter out any rows where the 'period' column is NA (e.g., empty rows)
  filter(!is.na(period)) %>%
  # Convert columns to numeric, handling any non-numeric entries by coercing to NA
  # Then filter out rows where this conversion resulted in NA
  mutate(
    transaction_value_thousands = as.numeric(as.character(transaction_value_thousands)),
    transaction_count = as.numeric(as.character(transaction_count))
  ) %>%
  filter(!is.na(transaction_value_thousands), !is.na(transaction_count)) %>%
  # Extract year and quarter from the 'period' column (e.g., "1T2009" -> year=2009, quarter=1)
  mutate(
    year = as.numeric(substr(period, 3, 6)), # Adjusting to extract year from 

    quarter = as.numeric(substr(period, 1, 1)) # Extract quarter from first character
  ) %>%
  # Filter out rows where year/quarter extraction failed
  filter(!is.na(year), !is.na(quarter)) %>%
  # Create a proper date column using the first day of each quarter
  mutate(
    date = make_date(year, quarter * 3 - 2, 1), # Q1->Jan, Q2->Apr, Q3->Jul, Q4->Oct
    # Calculate average transaction value per property
    avg_transaction_value = transaction_value_thousands * 1000 / transaction_count
  )

# Create indices with 2015 average = 100 (to match your Idealista analysis)
ine_indexed <- ine_cleaned %>%
  # Calculate the 2015 average values for indexing
  mutate(
    avg_2015_transaction_value = mean(avg_transaction_value[year == 2015], na.rm = TRUE),
    avg_2015_transaction_count = mean(transaction_count[year == 2015], na.rm = TRUE),
    # Create indices (2015 average = 100)
    value_index = avg_transaction_value / avg_2015_transaction_value * 100,
    volume_index = transaction_count / avg_2015_transaction_count * 100
  )

# Create the processed data directory if it doesn't exist
if (!dir.exists("data/processed")) {
  dir.create("data/processed", recursive = TRUE)
}

# Save the cleaned data
write_csv(ine_indexed, "data/processed/ine_transaction_data.csv")

# Preview the cleaned data
print("First few rows of cleaned INE data:")
print(head(ine_indexed))

# Check data summary
print("\nData summary:")
print(paste("Number of rows:", nrow(ine_indexed)))
print(paste("Date range:", min(ine_indexed$date), "to", max(ine_indexed$date)))
print(paste("Years covered:", min(ine_indexed$year), "to", max(ine_indexed$year)))

# Check for any remaining issues
print("\nData quality check:")
print(paste("Missing values in value_index:", sum(is.na(ine_indexed$value_index))))
print(paste("Missing values in volume_index:", sum(is.na(ine_indexed$volume_index))))

# Display the structure of the final dataset
print("\nDataset structure:")
str(ine_indexed)

