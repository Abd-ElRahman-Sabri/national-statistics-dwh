CREATE TABLE staging.economic_clean (
    source_record_id BIGINT,
    year INT NOT NULL,
    gdp NUMERIC,
    unemployment_rate NUMERIC,
    inflation_rate NUMERIC,
    api_status TEXT,
    load_date TIMESTAMP
);

INSERT INTO staging.economic_clean
SELECT
    record_id,
    year,
    gdp,
    unemployment_rate,
    inflation_rate,
    api_status,
    load_date
FROM (
    SELECT
        r.*,
        ROW_NUMBER() OVER (
            PARTITION BY year
            ORDER BY load_date DESC
        ) AS rn
    FROM landing.economic_api_raw r
    WHERE api_status = 'SUCCESS'
) x
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1
      FROM staging.economic_errors e
      WHERE e.source_record_id = x.record_id
  );

