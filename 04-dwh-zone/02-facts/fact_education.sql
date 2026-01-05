CREATE TABLE dwh.fact_education (
    governorate_sk INT NOT NULL,
    date_sk        INT NOT NULL,

    literacy_rate           NUMERIC,
    school_enrollment_rate  NUMERIC,

    CONSTRAINT pk_fact_education
        PRIMARY KEY (governorate_sk, date_sk),

    CONSTRAINT fk_education_governorate
        FOREIGN KEY (governorate_sk)
        REFERENCES dwh.dim_governorate (governorate_sk),

    CONSTRAINT fk_education_date
        FOREIGN KEY (date_sk)
        REFERENCES dwh.dim_date (date_sk)
);

INSERT INTO dwh.fact_education (
    governorate_sk,
    date_sk,
    literacy_rate,
    school_enrollment_rate
)
SELECT
    g.governorate_sk,
    d.date_sk,
    MAX(e.literacy_rate)          AS literacy_rate,
    MAX(e.enrollment_rate) AS school_enrollment_rate
FROM staging.education_clean e
JOIN dwh.dim_governorate g
  ON e.governorate_name = g.governorate_name
JOIN dwh.dim_date d
  ON e.year = d.year
GROUP BY
    g.governorate_sk,
    d.date_sk;


