-- =========================
-- Dimension: Date (Year-based)
-- =========================

DROP TABLE IF EXISTS dwh.dim_date;

CREATE TABLE dwh.dim_date (
    date_sk SERIAL PRIMARY KEY,
    year INT NOT NULL UNIQUE,
    decade INT NOT NULL
);

INSERT INTO dwh.dim_date (year, decade)
SELECT
    year,
    (year / 10) * 10 AS decade
FROM (
    SELECT DISTINCT year FROM staging.population_clean
    UNION
    SELECT DISTINCT year FROM staging.education_clean
    UNION
    SELECT DISTINCT year FROM staging.health_clean
    UNION
    SELECT DISTINCT year FROM staging.economic_clean
) y
ORDER BY year;

