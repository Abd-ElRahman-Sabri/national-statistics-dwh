CREATE TABLE staging.population_errors (
	record_id		   INT,
    year               INT,
    governorate_name   TEXT,
    total_population   BIGINT,
    male_population    BIGINT,
    female_population  BIGINT,
    source_file        TEXT,
    load_date          TIMESTAMP,
    error_reason       TEXT
);


INSERT INTO staging.population_errors (
    record_id,
    governorate_name,
    year,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date,
    error_reason
)
SELECT
    record_id AS source_id,
    governorate_name,
    year,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date,
    CASE
        WHEN governorate_name IS NULL THEN 'NULL_GOVERNORATE'
        WHEN year IS NULL THEN 'NULL_YEAR'
        WHEN total_population IS NULL THEN 'NULL_TOTAL'
        WHEN male_population IS NULL THEN 'NULL_MALE'
        WHEN female_population IS NULL THEN 'NULL_FEMALE'
        WHEN male_population + female_population <> total_population
             THEN 'TOTAL_MISMATCH'
        ELSE 'UNKNOWN'
    END AS error_reason
FROM landing.population_raw
WHERE
    governorate_name IS NULL
    OR year IS NULL
    OR total_population IS NULL
    OR male_population IS NULL
    OR female_population IS NULL
    OR male_population + female_population <> total_population;



		
		
		
		
		

