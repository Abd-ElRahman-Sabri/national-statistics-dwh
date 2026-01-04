CREATE TABLE staging.education_clean (
    source_record_id BIGINT,
    year INT NOT NULL,
    governorate_name TEXT NOT NULL,
    education_metric NUMERIC,
    load_date TIMESTAMP
);

INSERT INTO staging.education_clean
SELECT
    r.record_id,
    r.year,
    gm.standard_name,
    r.education_metric,
    r.load_date
FROM landing.education_raw r
JOIN staging.governorate_mapping gm
    ON LOWER(r.governorate_name) = LOWER(gm.raw_name)
WHERE NOT EXISTS (
    SELECT 1
    FROM staging.education_errors e
    WHERE e.source_record_id = r.record_id
);

