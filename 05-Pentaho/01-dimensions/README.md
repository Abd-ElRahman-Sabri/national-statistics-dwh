# Dimensions (Pentaho)

Dimension tables in this project are created and populated using SQL scripts.

At the current stage:
- Dimensions are static
- No Slowly Changing Dimensions (SCD) are applied
- No incremental loading is required

Pentaho transformations for dimensions are intentionally omitted to keep
the pipeline simple and focused on fact table loading.

This folder is reserved for future enhancements where dimension ETL
may be required.

