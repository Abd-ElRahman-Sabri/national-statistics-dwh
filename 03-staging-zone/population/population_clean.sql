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
    governorate_name,
    year,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date
)
SELECT
    record_id        AS source_id,
    governorate_name,
    year,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date
FROM (
    SELECT
        record_id,
        governorate_name,
        year,
        total_population,
        male_population,
        female_population,
        source_file,
        load_date,
        ROW_NUMBER() OVER (
            PARTITION BY governorate_name, year
            ORDER BY record_id
        ) AS rn
    FROM landing.population_raw
    WHERE
        governorate_name IS NOT NULL
        AND year IS NOT NULL
        AND total_population IS NOT NULL
        AND male_population IS NOT NULL
        AND female_population IS NOT NULL
        AND male_population + female_population = total_population
) t
WHERE rn = 1;






