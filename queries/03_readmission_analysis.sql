-- =============================================================================
-- QUERY 03: 30-Day Hospital Readmission Tracker
-- =============================================================================
-- CLINICAL OBJECTIVE:
-- Identify patients who experienced an unplanned hospital readmission within 
-- 30 days of a prior encounter. Unplanned 30-day readmissions are key quality 
-- indicators used to evaluate discharge planning, inpatient care delivery, and 
-- post-discharge community support.
--
-- TARGET OUTPUT:
-- Patient ID, Current Visit ID, Current Visit Date, Department, 
-- Previous Visit Date, Days Between Visits, and 30-Day Readmission Flag.
--
-- SQL PATTERN:
-- CTE utilizing the LAG() window function partitioned by patient_id and ordered 
-- chronologically by visit_date, followed by DATEDIFF() interval calculation.
-- =============================================================================

WITH PatientEncounterSequence AS (
    SELECT 
        p.patient_id,
        p.age,
        p.gender,
        v.visit_id,
        v.visit_date AS current_visit_date,
        v.department AS current_department,
        v.admission_type,
        -- Fetch the visit_date of the patient's immediately preceding encounter
        LAG(v.visit_date) OVER (
            PARTITION BY p.patient_id 
            ORDER BY v.visit_date ASC
        ) AS previous_visit_date
    FROM patients p
    JOIN visits v ON p.patient_id = v.patient_id
)
SELECT 
    patient_id,
    age,
    gender,
    visit_id AS current_visit_id,
    current_department,
    admission_type,
    previous_visit_date,
    current_visit_date,
    DATEDIFF(current_visit_date, previous_visit_date) AS days_since_last_visit,
    CASE 
        WHEN DATEDIFF(current_visit_date, previous_visit_date) <= 30 THEN '30-Day Readmission'
        ELSE 'Elective / Delayed Return (> 30 Days)'
    END AS readmission_category
FROM PatientEncounterSequence
WHERE previous_visit_date IS NOT NULL               -- Exclude initial visits
  AND DATEDIFF(current_visit_date, previous_visit_date) <= 30
ORDER BY patient_id, current_visit_date;
