# Portuguese Housing Market Analysis

## Project Overview
This project analyzes the evolution of housing prices in Portugal, examining both sales and rental markets across different regions. The analysis aims to understand price trends, regional differences, and housing affordability by comparing housing costs with wage data. The project integrates listing price data from Idealista with official transaction data from INE (Instituto Nacional de Estatística) to provide a comprehensive view of the Portuguese housing market.

## Data Sources

### Housing Price Data:
- **Listing Prices**: 
  - Sales prices: [Idealista Sales Reports](https://www.idealista.pt/media/relatorios-preco-habitacao/venda/historico/)
  - Rental prices: [Idealista Rental Reports](https://www.idealista.pt/media/relatorios-preco-habitacao/arrendamento/historico/)
  - Last updated: May 1, 2025

- **Transaction Data**:
  - Official housing transaction values and volumes: [INE Housing Statistics](https://www.ine.pt/xportal/xmain?xpid=INE&xpgid=ine_destaques&DESTAQUESdest_boui=706274632&DESTAQUESmodo=2)
  - Quarterly data from Q1 2009 to Q1 2025
  - Source: Instituto Nacional de Estatística (INE)

### Additional Data Sources (planned):
- Wage data (minimum and average wages)
- Economic indicators (interest rates, inflation)
- Migration statistics

## Project Structure
```
/data/
  raw/                    # Original unmodified data
    - idealista_venda.xlsx
    - idealista_arrendamento.xlsx
    - Quadros PT.xlsx      # INE transaction data
  processed/              # Cleaned and transformed data
    - idealista_prices_clean.csv
    - ine_transaction_data.csv
    
/scripts/
  - clean_idealista_data.R     # Idealista data cleaning and preparation
  - clean_INES_Q2_data.R        # INE transaction data cleaning
  
/outputs/
  figures/                # Generated visualizations
  tables/                 # Summary statistics and results
  
/docs/                    # Documentation and reports
```

## Analysis Goals
- Track the evolution of housing prices across Portugal over time
- Compare regional differences in housing markets
- Analyze the relationship between sales and rental markets
- **Compare listing prices (Idealista) with actual transaction values (INE)**
- **Examine transaction volume trends and their relationship with price changes**
- Assess housing affordability by comparing prices with wage data
- Identify potential impacts of economic events (e.g., 2008 crisis, Euro introduction, COVID-19 pandemic)

## Key Findings (Updated)

### Idealista Listing Price Analysis:
- **Sale prices** have shown steady linear growth since 2015, increasing by approximately 150% (2.5× the 2015 average)
- **Rental prices** have demonstrated more aggressive growth, reaching 220% increase (3.2× the 2015 average) with particular acceleration post-2022
- **Regional divergence**: Rental markets show strong correlation across regions, while sale prices exhibit more localized behavior
- **COVID-19 impact**: Temporary deceleration in rental price increases around 2020, followed by sharp acceleration from late 2022

### INE Transaction Data Integration:
- Successfully integrated official transaction data covering Q1 2009 to Q1 2025
- Enables comparison between listing prices and actual transaction values
- Provides transaction volume data to understand market activity patterns

## Tools & Technologies
- **R/RStudio** for data cleaning, analysis, and visualization
- **Key packages**: dplyr, tidyr, ggplot2, lubridate, readxl, readr
- **Data sources**: Idealista API reports, INE official statistics

## Methodology
1. **Data Collection**: Automated extraction from Idealista reports and manual collection from INE
2. **Data Cleaning**: Standardization of date formats, currency conversion, regional consolidation
3. **Index Calculation**: Normalization to 2015 average = 100 for comparative analysis
4. **Visualization**: Time series analysis, regional comparisons, correlation studies

## Results
*This section will be updated as analysis progresses*

- Comprehensive time series analysis of Portuguese housing market (2015-2025)
- Regional correlation analysis revealing market fragmentation in sales vs. rental unity
- Integration of listing vs. transaction price comparison (in progress)

## Links
- **Kaggle Dataset**: [Portugal Housing Affordability and Market Factors](https://www.kaggle.com/marquesigor/portugal-housing-affordability-and-market-factors)
- **Kaggle Project**: [Portuguese Housing Market (Capstone Project)]https://www.kaggle.com/code/marquesigor/portuguese-housing-market-capstone-project
- **Data Sources**: 
  - [Idealista Reports](https://www.idealista.pt/media/relatorios-preco-habitacao/)
  - [INE Housing Statistics](https://www.ine.pt/xportal/xmain?xpid=INE&xpgid=ine_destaques&DESTAQUESdest_boui=706274632&DESTAQUESmodo=2)

## About
This project is part of the **Google Data Analytics Professional Certificate capstone project (Track B)**. The analysis combines multiple authoritative data sources to provide insights into Portuguese housing market dynamics and affordability trends.

---
*Note: This project was developed with assistance from AI tools (ChatGPT and Manus.IM) for data processing and analysis guidance.*

