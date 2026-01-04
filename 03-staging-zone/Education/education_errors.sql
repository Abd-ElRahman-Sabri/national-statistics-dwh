CREATE TABLE staging.education_errors (
    source_record_id BIGINT,
    year INT,
    governorate_name TEXT,
    education_metric NUMERIC,
    load_date TIMESTAMP,
    error_reason TEXT
);


INSERT INTO staging.education_errors
SELECT
    record_id,
    year,
    governorate_name,
    education_metric,
    load_date,
    CASE
        WHEN year IS NULL THEN 'year is null'
        WHEN governorate_name IS NULL THEN 'governorate is null'
        WHEN education_metric IS NULL THEN 'education metric is null'
        WHEN education_metric < 0 THEN 'invalid metric value'
    END
FROM landing.education_raw
WHERE
       year IS NULL
    OR governorate_name IS NULL
    OR education_metric IS NULL
    OR education_metric < 0;

