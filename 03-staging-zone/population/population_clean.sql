CREATE TABLE staging.population_clean (
    source_record_id   BIGINT,
    year               INT,
    governorate_name   TEXT,
    total_population   BIGINT,
    male_population    BIGINT,
    female_population  BIGINT,
    source_file        TEXT,
    load_date          TIMESTAMP
);



INSERT INTO staging.population_clean (
    source_record_id,
    year,
    governorate_name,
    total_population,
    male_population,
    female_population,
    load_date
)
SELECT
    r.record_id,
    r.year,
    gm.standard_name,
    r.total_population,
    r.male_population,
    r.female_population,
    r.load_date
FROM landing.population_raw r
JOIN (
    SELECT DISTINCT
        LOWER(raw_name) AS raw_name_norm,
        standard_name
    FROM staging.governorate_mapping
) gm
    ON LOWER(r.governorate_name) = gm.raw_name_norm
WHERE NOT EXISTS (
    SELECT 1
    FROM staging.population_errors e
    WHERE e.source_record_id = r.record_id
);

