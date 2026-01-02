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
    year,
    governorate_name,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date,
    error_reason
)
SELECT
    record_id,
    year,
    governorate_name,
    total_population,
    male_population,
    female_population,
    source_file,
    load_date,
    CASE
        WHEN year IS NULL THEN 'year is null'
        WHEN year < 1900 OR year > EXTRACT(YEAR FROM CURRENT_DATE) THEN 'invalid year'
        WHEN governorate_name IS NULL THEN 'governorate is null'
        WHEN total_population IS NULL THEN 'total_population is null'
        WHEN male_population IS NULL OR female_population IS NULL THEN 'gender population is null'
        WHEN male_population < 0 OR female_population < 0 THEN 'negative gender population'
        WHEN total_population < (male_population + female_population)
             THEN 'total less than male + female'
    END
FROM landing.population_raw
WHERE
    year IS NULL
 OR year < 1900
 OR year > EXTRACT(YEAR FROM CURRENT_DATE)
 OR governorate_name IS NULL
 OR total_population IS NULL
 OR male_population IS NULL
 OR female_population IS NULL
 OR male_population < 0
 OR female_population < 0
 OR total_population < (male_population + female_population);




		
		
		
		
		

