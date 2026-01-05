CREATE TABLE dwh.fact_economic (
    country_sk INT NOT NULL,
    date_sk    INT NOT NULL,

    gdp               NUMERIC,
    unemployment_rate NUMERIC,
    inflation_rate    NUMERIC,

    CONSTRAINT pk_fact_economic
        PRIMARY KEY (country_sk, date_sk),

    CONSTRAINT fk_economic_country
        FOREIGN KEY (country_sk)
        REFERENCES dwh.dim_country (country_sk),

    CONSTRAINT fk_economic_date
        FOREIGN KEY (date_sk)
        REFERENCES dwh.dim_date (date_sk)
);

INSERT INTO dwh.fact_economic (
    country_sk,
    date_sk,
    gdp,
    unemployment_rate,
    inflation_rate
)
SELECT
    c.country_sk,
    d.date_sk,
    MAX(e.gdp)               AS gdp,
    MAX(e.unemployment_rate) AS unemployment_rate,
    MAX(e.inflation_rate)    AS inflation_rate
FROM staging.economic_clean e
JOIN dwh.dim_country c
  ON c.country_name = 'Egypt'
JOIN dwh.dim_date d
  ON e.year = d.year
GROUP BY
    c.country_sk,
    d.date_sk;

