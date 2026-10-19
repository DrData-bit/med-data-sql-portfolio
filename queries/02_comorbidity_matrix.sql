-- =============================================================================
-- QUERY 02: Multi-Morbidity Cohort Identification (Cardiovascular & Endocrine)
-- =============================================================================
-- CLINICAL OBJECTIVE:
-- Identify complex patients presenting with multi-morbidity—specifically those 
-- diagnosed with both Cardiovascular and Endocrine chronic conditions across 
-- any of their hospital admissions. 
--
-- Patients with multi-morbidity require multidisciplinary management, suffer 
-- higher rates of adverse drug events, and represent a primary focus for 
-- integrated care coordination programs.
--
-- TARGET OUTPUT:
-- Patient ID, Age, Gender, Location (County), Total Hospital Visits, and 
-- Number of Distinct Target Disease Categories (Must equal 2).
--
-- SQL PATTERN:
-- Conditional Aggregation using GROUP BY, COUNT(DISTINCT ...), and HAVING.
-- =============================================================================

SELECT 
	p.patient_id,
    p.age,
    p.gender,
    p.county,
    COUNT(DISTINCT d.category) AS distinct_disease_category
FROM patients P 
INNER JOIN visits v
	ON p.patient_id = v.patient_id
INNER JOIN diagnoses d
	ON v.visit_id = d.visit_id
WHERE d.category IN ('Cardiovascular', 'Endocrine')
GROUP BY p.patient_id, p.age, p.gender, p.county
HAVING COUNT(DISTINCT d.category) = 2;