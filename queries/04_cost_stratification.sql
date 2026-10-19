-- =============================================================================
-- QUERY 04: Patient Expenditure Stratification (Top 20% High Utilizers)
-- =============================================================================
-- CLINICAL OBJECTIVE:
-- Segment patients into financial expenditure quintiles based on their total 
-- cumulative healthcare spend across all visits. Isolate high utilizers (Top 20% 
-- quintile) for enrolment into intensive care coordination programs aimed at 
-- improving outcomes while controlling hospital resource consumption.
--
-- TARGET OUTPUT:
-- Patient ID, Age, Gender, County, Total Visits, Cumulative Cost (USD), 
-- Expenditure Quintile (1 = Top 20%), and Utilizer Tier Label.
--
-- SQL PATTERN:
-- CTE summarizing patient-level spending, combined with NTILE(5) OVER () 
-- window function ordered by cumulative spend descending.
-- =============================================================================

WITH PatientTotalSpend AS (
    SELECT 
        p.patient_id,
        p.age,
        p.gender,
        p.county,
        COUNT(v.visit_id) AS total_encounters,
        SUM(v.total_cost_usd) AS cumulative_cost_usd
    FROM patients p
    JOIN visits v ON p.patient_id = v.patient_id
    GROUP BY 
        p.patient_id, 
        p.age, 
        p.gender, 
        p.county
),
SpendQuintiles AS (
    SELECT 
        patient_id,
        age,
        gender,
        county,
        total_encounters,
        cumulative_cost_usd,
        -- Divide population into 5 equal buckets (1 = Highest Spend, 5 = Lowest Spend)
        NTILE(5) OVER (
            ORDER BY cumulative_cost_usd DESC
        ) AS spend_quintile
    FROM PatientTotalSpend
)
SELECT 
    patient_id,
    age,
    gender,
    county,
    total_encounters,
    cumulative_cost_usd,
    spend_quintile,
    CASE 
        WHEN spend_quintile = 1 THEN 'Top 20% High Utilizer'
        WHEN spend_quintile = 2 THEN 'Upper-Middle Cost Tier'
        WHEN spend_quintile = 3 THEN 'Mid-Tier Cost'
        WHEN spend_quintile = 4 THEN 'Lower-Middle Cost Tier'
        ELSE 'Low Utilizer'
    END AS cost_stratification_label
FROM SpendQuintiles
ORDER BY cumulative_cost_usd DESC;
