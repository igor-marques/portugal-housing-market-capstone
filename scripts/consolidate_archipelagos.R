# Archipelago Consolidation Script for Portuguese Housing Market Analysis
# Created: July 8, 2025
# Description: Consolidates individual islands into archipelagos (Azores and Madeira)
# Input: Cleaned housing price data
# Output: Consolidated data with archipelagos grouped, in both long and wide formats

# Load required packages
library(dplyr)
library(readr)
library(tidyr)
library(stringr)

# Set working directory to your project folder
setwd("C:/Dropbox/google_ds/github/portugal-housing-market-capstone")

# Load cleaned long format data
data <- read_csv("data/processed/idealista_prices_clean.csv")

# Define archipelago groups
azores_islands <- c("corvo-ilha", "faial-ilha", "flores-ilha", "graciosa-ilha",
                   "pico-ilha", "santa-maria-ilha", "sao-jorge-ilha", 
                   "sao-miguel-ilha", "terceira-ilha")

madeira_islands <- c("madeira-ilha", "porto-santo-ilha")

# Assign archipelago label using case_when (cleaner approach from ChatGPT's script)
data <- data %>%
  mutate(region_grouped = case_when(
    region %in% azores_islands ~ "azores",
    region %in% madeira_islands ~ "madeira",
    TRUE ~ region
  ))

# Aggregate by date, region_grouped, and price_type
# Include count of regions that contributed to each average (from my script)
consolidated_data <- data %>%
  group_by(date, region = region_grouped, price_type) %>%
  summarise(
    price_per_sqm = mean(price_per_sqm, na.rm = TRUE),
    n_regions = n(),
    .groups = "drop"
  )

# Create output directory if it doesn't exist
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

# Save long format result
write_csv(consolidated_data, "data/processed/idealista_prices_consolidated.csv")
saveRDS(consolidated_data, "data/processed/idealista_prices_consolidated.rds")

# Create wide format (from my script)
wide_data <- consolidated_data %>%
  select(-n_regions) %>%  # Remove the count column for the wide format
  pivot_wider(
    id_cols = date,
    names_from = c(region, price_type),
    names_sep = "_",
    values_from = price_per_sqm
  )

# Save wide format
write_csv(wide_data, "data/processed/idealista_prices_consolidated_wide.csv")
saveRDS(wide_data, "data/processed/idealista_prices_consolidated_wide.rds")

# Print summary
cat("✅ Archipelago consolidation complete!\n")
cat("Original regions:", length(unique(data$region)), "\n")
cat("Consolidated regions:", length(unique(consolidated_data$region)), "\n")
cat("Files saved to data/processed/ directory\n")

# Display first few rows of the consolidated data
head(consolidated_data)
