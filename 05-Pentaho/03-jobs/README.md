# Pentaho Job – Run All Facts

This folder contains the Pentaho job responsible for orchestrating
the execution of all fact-loading transformations.

---

## Job: run_all_facts.kjb

### Purpose
- Execute a full reload of all Data Warehouse fact tables
- Ensure correct execution order
- Centralize orchestration logic

---

## Execution Flow

1. Truncate fact_population  
2. Load fact_population  

3. Truncate fact_education  
4. Load fact_education  

5. Truncate fact_health  
6. Load fact_health  

7. Truncate fact_economic  
8. Load fact_economic  

Each step executes only if the previous one succeeds.

---

## Design Decisions

- Truncation is handled at the job level, not inside transformations
- Transformations focus only on ETL logic
- Job is designed for scheduled execution via Airflow

---

## Usage

The job can be executed:
- Manually via Pentaho Spoon
- Automatically via Airflow using `kitchen.sh`

