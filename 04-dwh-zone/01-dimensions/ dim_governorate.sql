-- =========================
-- Dimension: Governorate
-- =========================

DROP TABLE IF EXISTS dwh.dim_governorate;

CREATE TABLE dwh.dim_governorate (
    governorate_sk SERIAL PRIMARY KEY,
    governorate_name TEXT NOT NULL UNIQUE
);

INSERT INTO dwh.dim_governorate (governorate_name)
SELECT DISTINCT standard_name
FROM staging.governorate_mapping
ORDER BY standard_name;

