# Facts Layer

This folder contains all fact tables for the National Statistics Data Warehouse.
Each fact table represents a specific business process or subject area, modeled
at a clear and fixed grain.

All fact tables are populated from the staging layer after data cleaning,
validation, and deduplication.

---

## General Design Principles

- Facts store **measures only** (numeric values).
- Dimensions are referenced using **surrogate keys**.
- Each fact table has a **well-defined grain**.
- Duplicate records from source systems are handled in the staging layer.
- Facts represent the final, trusted analytical layer.

---

## Fact Tables Overview

### 1. `fact_population`

**Grain:**  
One row per **governorate per year**

**Measures:**
- `total_population`
- `male_population`
- `female_population`

**Source:**
- `staging.population_clean`

**Dimensions:**
- `dim_governorate`
- `dim_date`

---

### 2. `fact_education`

**Grain:**  
One row per **governorate per year**

**Measures:**
- `literacy_rate`
- `school_enrollment_rate`

**Source:**
- `staging.education_clean`

**Dimensions:**
- `dim_governorate`
- `dim_date`

---

### 3. `fact_health`

**Grain:**  
One row per **governorate per year**

**Measures:**
- `hospitals_count`
- `mortality_rate`

**Source:**
- `staging.health_clean`

**Dimensions:**
- `dim_governorate`
- `dim_date`

---

### 4. `fact_economic`

**Grain:**  
One row per **country per year**

**Measures:**
- `gdp`
- `unemployment_rate`
- `inflation_rate`

**Source:**
- `staging.economic_clean`

**Dimensions:**
- `dim_country`
- `dim_date`

---

## Notes

- Fact tables do not store source metadata such as source files or load timestamps.
- All lineage and error tracking is handled in the landing and staging layers.
- These tables are optimized for analytical queries and reporting.


