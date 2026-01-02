CREATE TABLE staging.governorate_mapping (
    raw_name        TEXT,
    standard_name   TEXT
);

INSERT INTO staging.governorate_mapping (raw_name, standard_name)
SELECT DISTINCT
    governorate_name,
    governorate_name
FROM landing.population_raw
WHERE governorate_name IS NOT NULL;

SELECT * FROM staging.governorate_mapping ORDER BY raw_name;


UPDATE staging.governorate_mapping
SET standard_name = 'Cairo'
WHERE raw_name in ('Cairoo','cairo');

UPDATE staging.governorate_mapping
SET standard_name = 'Alexandria'
WHERE raw_name IN ('Alex', 'ALX');

UPDATE staging.governorate_mapping
SET standard_name = 'Giza'
WHERE raw_name = 'Gizaa';

UPDATE staging.governorate_mapping
SET standard_name = 'Aswan'
WHERE raw_name = 'ASWAN';
