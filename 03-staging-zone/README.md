STAGING LAYER

Purpose:
Prepare raw data for the Data Warehouse by validating, cleaning, and standardizing records before loading.

What we do:
- Separate valid records (clean) from invalid ones (errors)
- Enforce basic data quality rules (NULLs, invalid values, duplicates)
- Standardize governorate names using a single global mapping table
- Keep source_record_id for traceability to landing data
- Handle different data granularities (governorate-level vs country-level)

Key rules:
- Population / Education / Health:
  - Governorate-level data
  - year and governorate_name must not be NULL
  - Non-numeric or invalid values go to errors
  - One clean record per year and governorate

- Economic:
  - Country-level data
  - No governorate dimension
  - NULL values allowed for unemployment and inflation
  - One clean record per year (latest API response)

Challenges faced:
- Inconsistent governorate naming across sources
- Duplicate records after standardization
- Non-numeric values in numeric fields (e.g. "not_available")
- Different data granularity between sources

Outcome:
A clean, consistent staging layer ready for reliable DWH modeling.

