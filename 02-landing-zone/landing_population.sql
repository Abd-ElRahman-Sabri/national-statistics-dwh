-- =====================================================
-- Table: landing.population_raw
-- Purpose: Store raw population data from CSV files
-- =====================================================

CREATE TABLE IF NOT EXISTS landing.population_raw (
    record_id          BIGSERIAL PRIMARY KEY,
    year               INTEGER,
    governorate_name   TEXT,
    total_population   BIGINT,
    male_population    BIGINT,
    female_population  BIGINT,
    source_file        TEXT,
    load_date          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

