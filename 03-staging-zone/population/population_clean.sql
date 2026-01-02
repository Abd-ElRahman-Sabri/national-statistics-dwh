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
    source_file,
    load_date
)
SELECT
    p.record_id,
    p.year,
    COALESCE(m.standard_name, p.governorate_name),
    p.total_population,
    p.male_population,
    p.female_population,
    p.source_file,
    p.load_date
FROM landing.population_raw p
LEFT JOIN staging.governorate_mapping m
    ON LOWER(p.governorate_name) = LOWER(m.raw_name)
WHERE NOT (
       p.year IS NULL
    OR p.year < 1900
    OR p.year > EXTRACT(YEAR FROM CURRENT_DATE)
    OR p.governorate_name IS NULL
    OR p.total_population IS NULL
    OR p.male_population IS NULL
    OR p.female_population IS NULL
    OR p.male_population < 0
    OR p.female_population < 0
    OR p.total_population < (p.male_population + p.female_population)
);


