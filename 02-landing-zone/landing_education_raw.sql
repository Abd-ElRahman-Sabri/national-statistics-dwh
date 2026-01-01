-- =====================================================
-- Table: landing.education_raw
-- Purpose: Store raw education statistics from CSV files
-- Layer: Landing (Raw, no transformations)
-- =====================================================

CREATE TABLE IF NOT EXISTS landing.education_raw (
    record_id              BIGSERIAL PRIMARY KEY,
    year                   INTEGER,
    governorate_name       TEXT,
    literacy_rate          NUMERIC,
    school_enrollment_rate NUMERIC,
    source_file            TEXT,
    load_date              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

