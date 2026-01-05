-- =========================
-- Fact: Population
-- Grain: one row per governorate per year
-- =========================


CREATE TABLE dwh.fact_population (
    governorate_sk INT NOT NULL,
    date_sk INT NOT NULL,

    total_population BIGINT,
    male_population  BIGINT,
    female_population BIGINT,

    -- يفرض الـ Grain ويمنع التكرار
    CONSTRAINT pk_fact_population
        PRIMARY KEY (governorate_sk, date_sk),

    -- يضمن إن المحافظة موجودة فعلاً
    CONSTRAINT fk_population_governorate
        FOREIGN KEY (governorate_sk)
        REFERENCES dwh.dim_governorate (governorate_sk),

    -- يضمن إن السنة موجودة فعلاً
    CONSTRAINT fk_population_date
        FOREIGN KEY (date_sk)
        REFERENCES dwh.dim_date (date_sk)
);


INSERT INTO dwh.fact_population (
    governorate_sk,
    date_sk,
    total_population,
    male_population,
    female_population
)
SELECT
    g.governorate_sk,
    d.date_sk,
    MAX(p.total_population),
    MAX(p.male_population),
    MAX(p.female_population)
FROM staging.population_clean p
JOIN dwh.dim_governorate g
  ON p.governorate_name = g.governorate_name
JOIN dwh.dim_date d
  ON p.year = d.year
GROUP BY
    g.governorate_sk,
    d.date_sk;

