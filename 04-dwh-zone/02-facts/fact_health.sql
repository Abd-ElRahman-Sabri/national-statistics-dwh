DROP TABLE IF EXISTS dwh.fact_health;

CREATE TABLE dwh.fact_health (
    governorate_sk INT NOT NULL,
    date_sk        INT NOT NULL,

    hospitals_count INT,
    mortality_rate  NUMERIC,

    CONSTRAINT pk_fact_health
        PRIMARY KEY (governorate_sk, date_sk),

    CONSTRAINT fk_health_governorate
        FOREIGN KEY (governorate_sk)
        REFERENCES dwh.dim_governorate (governorate_sk),

    CONSTRAINT fk_health_date
        FOREIGN KEY (date_sk)
        REFERENCES dwh.dim_date (date_sk)
);


INSERT INTO dwh.fact_health (
    governorate_sk,
    date_sk,
    hospitals_count,
    mortality_rate
)
SELECT
    g.governorate_sk,
    d.date_sk,
    MAX(h.hospitals_count) AS hospitals_count,
    MAX(h.mortality_rate)  AS mortality_rate
FROM staging.health_clean h
JOIN dwh.dim_governorate g
  ON h.governorate_name = g.governorate_name
JOIN dwh.dim_date d
  ON h.year = d.year
GROUP BY
    g.governorate_sk,
    d.date_sk;

