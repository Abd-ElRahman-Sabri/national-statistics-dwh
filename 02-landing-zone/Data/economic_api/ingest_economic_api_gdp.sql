-- =====================================================
-- Script: ingest_economic_api_gdp.sql
-- Source: World Bank API
-- Endpoint:
-- https://api.worldbank.org/v2/country/EGY/indicator/NY.GDP.MKTP.CD?format=json
--
-- Description:
-- Ingest GDP data for Egypt from World Bank API.
-- Each API record (year) is inserted as a separate row.
-- Raw JSON response is stored for audit and reprocessing.
-- =====================================================

WITH payload AS (
    SELECT
        'PASTE_JSON_HERE'::jsonb AS j
)
INSERT INTO landing.economic_api_raw (
    year,
    gdp,
    raw_response,
    api_status
)
SELECT
    (rec->>'date')::int,
    (rec->>'value')::numeric,
    payload.j::text,
    'SUCCESS'
FROM payload
CROSS JOIN LATERAL jsonb_array_elements(payload.j->1) AS rec
WHERE rec->>'value' IS NOT NULL;

