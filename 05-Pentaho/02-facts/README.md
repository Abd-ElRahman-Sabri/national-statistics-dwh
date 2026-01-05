# Pentaho Fact Transformations

This folder contains Pentaho transformations responsible for loading
fact tables into the Data Warehouse.

Each transformation follows the same standardized pattern:
- Read clean data from the staging layer
- Lookup surrogate keys from dimension tables
- Aggregate data to the target grain
- Load data into the corresponding fact table

---

## Transformations Overview

### 1. load_fact_population.ktr
**Source:** staging.population_clean  
**Target:** dwh.fact_population  

**Grain:**
- One row per governorate per year

**Lookups:**
- dim_governorate → governorate_sk
- dim_date → date_sk

**Measures:**
- total_population
- male_population
- female_population

---

### 2. load_fact_education.ktr
**Source:** staging.education_clean  
**Target:** dwh.fact_education  

**Grain:**
- One row per governorate per year

**Lookups:**
- dim_governorate
- dim_date

**Measures:**
- literacy_rate
- school_enrollment_rate

---

### 3. load_fact_health.ktr
**Source:** staging.health_clean  
**Target:** dwh.fact_health  

**Grain:**
- One row per governorate per year

**Lookups:**
- dim_governorate
- dim_date

**Measures:**
- hospitals_count
- mortality_rate

---

### 4. load_fact_economic.ktr
**Source:** staging.economic_clean  
**Target:** dwh.fact_economic  

**Grain:**
- One row per country per year

**Lookups:**
- dim_country
- dim_date

**Measures:**
- gdp
- unemployment_rate
- inflation_rate

---

## Notes
- All transformations are designed for **full reload** execution.
- No incremental logic is applied at this stage.
- Truncation of target fact tables is handled at the job level.

