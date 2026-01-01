-- =====================================================
-- Table: landing.health_raw
-- Purpose: Store raw health statistics from CSV files
-- Layer: Landing (Raw, no transformations)
-- =====================================================

CREATE TABLE IF NOT EXISTS landing.health_raw (
    record_id            BIGSERIAL PRIMARY KEY,
    year                 INTEGER,
    governorate_name     TEXT,
    hospitals_count      INTEGER,
    mortality_rate       NUMERIC,
    source_file          TEXT,
    load_date            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
