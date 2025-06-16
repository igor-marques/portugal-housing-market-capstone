# Portuguese Housing Market Analysis

## Project Overview
This project analyzes the evolution of housing prices in Portugal, examining both sales and rental markets across different regions. The analysis aims to understand price trends, regional differences, and housing affordability by comparing housing costs with wage data.

## Data Sources
- **Housing Price Data**:
  - Sales prices: [Idealista Sales Reports](https://www.idealista.pt/media/relatorios-preco-habitacao/venda/historico/ )
  - Rental prices: [Idealista Rental Reports](https://www.idealista.pt/media/relatorios-preco-habitacao/arrendamento/historico/ )
  - Last updated: May 1, 2025

- **Additional Data Sources** (to be added):
  - Wage data
  - Economic indicators

## Project Structure
/data/
raw/ # Original unmodified data
idealista_venda.xlsx
idealista_arrendamento.xlsx
processed/ # Cleaned and transformed data
idealista_venda_clean.csv
idealista_arrendamento_clean.csv
/scripts/
clean_idealista_data.R # Data cleaning and preparation
analysis.R # Main analysis script
visualization.R # Visualization functions
/outputs/
figures/ # Generated visualizations
tables/ # Summary statistics and results
/docs/                      # Documentation and reports

## Analysis Goals
- Track the evolution of housing prices across Portugal over time
- Compare regional differences in housing markets
- Analyze the relationship between sales and rental markets
- Assess housing affordability by comparing prices with wage data
- Identify potential impacts of economic events (e.g., 2008 crisis, Euro introduction)

## Tools & Technologies
- R/RStudio for data cleaning, analysis, and visualization
- Key packages: dplyr, tidyr, ggplot2, etc.

## Results
*This section will be updated as analysis progresses*

## About
This project is part of the Google Analytics Professional Certificate capstone project (Track B).