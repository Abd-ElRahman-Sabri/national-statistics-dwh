-- =========================
-- Dimension: Country
-- =========================

DROP TABLE IF EXISTS dwh.dim_country;

CREATE TABLE dwh.dim_country (
    country_sk SERIAL PRIMARY KEY,
    country_name TEXT NOT NULL UNIQUE
);

INSERT INTO dwh.dim_country (country_name)
VALUES ('Egypt');

