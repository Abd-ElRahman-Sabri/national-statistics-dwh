# Population Staging – Data Cleaning & Standardization

This staging step prepares population data for the Data Warehouse by
handling data quality issues and standardizing governorate names.

## Source
- Source table: landing.population_raw
- Data issues observed:
  - Invalid or missing values
  - Negative population values
  - Inconsistent governorate naming (e.g. Alex, Alexandria, ALX)

## Staging Design

### 1. Governorate Mapping
A reference table is used to standardize governorate names.

Instead of manually listing governorates, the mapping table is:
- Automatically seeded from source data
- Manually adjusted only for incorrect spellings

This ensures scalability and avoids hard-coding reference data.

### 2. Population Clean Table
Only valid records are inserted into the clean table.
Validation rules include:
- Year must be valid
- Governorate name must not be NULL
- Population values must be non-negative
- Total population must be greater than or equal to male + female

Governorate names are standardized using the mapping table.

### 3. Population Errors Table
Invalid records are stored separately for auditing and data quality analysis.

Each error record keeps the original source record ID to allow traceability.

## Outcome
- Clean, standardized population data ready for DWH loading
- Full traceability to raw source data
- Reusable and maintainable staging logic

