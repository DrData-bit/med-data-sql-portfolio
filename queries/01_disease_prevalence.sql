-- =============================================================================
-- QUERY 01: Uncontrolled Type 2 Diabetes Cohort Identification
-- =============================================================================
-- CLINICAL OBJECTIVE:
-- Identify patients diagnosed with Type 2 Diabetes (ICD-10: E11) whose most 
-- recent HbA1c test exceeds the uncontrolled threshold (> 8.0%). 
-- Uncontrolled glycemic levels significantly increase long-term risks of 
-- microvascular and macrovascular complications (e.g., neuropathy, nephropathy).
--
-- TARGET OUTPUT:
-- Patient ID, Age, Gender, Location (County), Latest HbA1c Value, and Visit Date.
--
-- SQL PATTERN:
-- CTE with ROW_NUMBER() window function to isolate the most recent lab result 
-- per patient, joined with clinical diagnosis data.
-- =============================================================================

WITH RankedDiabetesLabs AS (
    SELECT 
        p.patient_id,
        p.age,
        p.gender,
        p.county,
        v.visit_id,
        v.visit_date,
        d.diagnosis_name,
        d.icd10_code,
        l.test_name,
        l.result_value AS hba1c_value,
        l.unit,
        -- Rank visits by date descending to get the most recent test result
        ROW_NUMBER() OVER (
            PARTITION BY p.patient_id 
            ORDER BY v.visit_date DESC
        ) AS recency_rank
    FROM patients p
    JOIN visits v ON p.patient_id = v.patient_id
    JOIN diagnoses d ON v.visit_id = d.visit_id
    JOIN lab_results l ON v.visit_id = l.visit_id
    WHERE d.icd10_code = 'E11'            -- Type 2 Diabetes Mellitus
      AND l.test_name = 'HbA1c'           -- Glycated Hemoglobin
)
SELECT 
    patient_id,
    age,
    gender,
    county,
    visit_date AS latest_test_date,
    hba1c_value,
    unit,
    CASE 
        WHEN hba1c_value >= 9.0 THEN 'Severe Risk (>= 9.0%)'
        WHEN hba1c_value > 8.0  THEN 'Moderate High Risk (8.1% - 8.9%)'
        ELSE 'Controlled (<= 8.0%)'
    END AS clinical_risk_tier
FROM RankedDiabetesLabs
WHERE recency_rank = 1               -- Keep only the latest record
  AND hba1c_value > 8.0              -- Filter for uncontrolled status
ORDER BY hba1c_value DESC;