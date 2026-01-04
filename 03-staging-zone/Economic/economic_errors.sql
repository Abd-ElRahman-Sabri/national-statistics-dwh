CREATE TABLE staging.economic_errors (
    source_record_id BIGINT,
    year INT,
    gdp NUMERIC,
    unemployment_rate NUMERIC,
    inflation_rate NUMERIC,
    api_status TEXT,
    load_date TIMESTAMP,
    error_reason TEXT
);

INSERT INTO staging.economic_errors
SELECT
    record_id,
    year,
    gdp,
    unemployment_rate,
    inflation_rate,
    api_status,
    load_date,
    CASE
        WHEN api_status <> 'SUCCESS' THEN 'api failed'
        WHEN year IS NULL THEN 'year is null'
        WHEN year < 1900 OR year > EXTRACT(YEAR FROM CURRENT_DATE) THEN 'invalid year'
        WHEN gdp IS NULL
         AND unemployment_rate IS NULL
         AND inflation_rate IS NULL THEN 'all indicators null'
    END
FROM landing.economic_api_raw
WHERE
       api_status <> 'SUCCESS'
    OR year IS NULL
    OR year < 1900
    OR year > EXTRACT(YEAR FROM CURRENT_DATE)
    OR (gdp IS NULL AND unemployment_rate IS NULL AND inflation_rate IS NULL);

