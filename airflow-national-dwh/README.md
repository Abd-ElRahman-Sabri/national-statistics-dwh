# 📊 National Statistics Data Warehouse (ETL Pipeline)

An end-to-end Data Warehouse project that demonstrates how to build and orchestrate
an ETL pipeline using Pentaho Data Integration (PDI) and Apache Airflow.

The project transforms raw national statistics data into structured fact tables
inside a PostgreSQL Data Warehouse.

## 🏗️ Architecture
- Orchestration: Apache Airflow (Docker / Astro CLI)
- ETL Engine: Pentaho Data Integration (Kitchen.sh)
- Database: PostgreSQL
- Environment: Linux / Docker

## ⚙️ Technologies
- PostgreSQL
- Pentaho Data Integration (PDI)
- Apache Airflow
- Docker

## 🧠 Design Overview
- Raw data is ingested into landing tables
- Data is cleaned and standardized in staging tables
- Fact tables are loaded using Pentaho transformations
- A single Pentaho job orchestrates all fact loads
- Airflow triggers the Pentaho job and manages execution

## ▶️ How to Run (High Level)
1. Start Airflow using Astro CLI
2. Open Airflow UI
3. Trigger the DAG: national_statistics_dwh
4. Verify data in DWH fact tables

> Note: Environment-specific configurations (database host, credentials)
> are intentionally excluded from this public documentation.

## 📂 Project Structure
national-statistics-dwh/
├── dags/
├── include/pentaho/
├── Dockerfile
├── packages.txt
├── requirements.txt
└── README.md

## 🎯 Purpose
This project is built for learning, portfolio demonstration,
and showcasing real-world Data Engineering practices.

Created by: Abd El Rahman Sabri

