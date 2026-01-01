-- =====================================================
-- Table: landing.economic_api_raw
-- Purpose: Store raw economic data received from API (JSON)
-- =====================================================

CREATE TABLE IF NOT EXISTS landing.economic_api_raw (
    record_id           BIGSERIAL PRIMARY KEY,
    year                INTEGER,
    governorate_name    TEXT,
    gdp                 NUMERIC,
    unemployment_rate   NUMERIC,
    inflation_rate      NUMERIC,
    raw_response        TEXT,
    api_status          TEXT,
    load_date           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
