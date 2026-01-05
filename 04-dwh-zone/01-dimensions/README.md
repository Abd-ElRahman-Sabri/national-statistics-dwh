## DWH Dimensions

This folder contains the core dimension tables for the National Statistics Data Warehouse.

### Dimensions Included
- **dim_date**: Year-based date dimension derived directly from staging data.
- **dim_governorate**: Standardized governorate dimension built from a global mapping table.
- **dim_country**: Country dimension used for national-level economic indicators.

### Design Principles
- Dimensions are derived from actual data, not artificially generated.
- Only attributes with real analytical value are included.
- The design reflects the true grain of each dataset.

