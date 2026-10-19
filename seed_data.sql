-- Patients
INSERT INTO patients (patient_id, age, gender, county, registration_date) VALUES
(101, 45, 'Female', 'Nairobi', '2025-01-15'),
(102, 62, 'Male', 'Kiambu', '2025-02-01'),
(103, 29, 'Female', 'Nakuru', '2025-02-10'),
(104, 71, 'Male', 'Nairobi', '2025-03-05'),
(105, 38, 'Female', 'Mombasa', '2025-03-20'),
(106, 54, 'Male', 'Turkana', '2025-04-02'),
(107, 23, 'Female', 'Nairobi', '2025-04-18');

-- Visits
INSERT INTO visits (visit_id, patient_id, visit_date, department, admission_type, length_of_stay_days, total_cost_usd) VALUES
(1001, 101, '2026-01-10', 'Cardiology', 'Outpatient', 0, 150.00),
(1002, 102, '2026-01-12', 'Internal Medicine', 'Inpatient', 5, 1250.50),
(1003, 103, '2026-01-15', 'Obstetrics', 'Outpatient', 0, 80.00),
(1004, 104, '2026-01-20', 'Cardiology', 'Inpatient', 7, 2100.00),
(1005, 101, '2026-02-01', 'Cardiology', 'Outpatient', 0, 120.00),
(1006, 105, '2026-02-10', 'Emergency', 'Emergency', 1, 450.00),
(1007, 106, '2026-02-15', 'Internal Medicine', 'Inpatient', 12, 3400.00),
(1008, 102, '2026-03-01', 'Internal Medicine', 'Outpatient', 0, 95.00),
(1009, 107, '2026-03-05', 'Pediatrics', 'Outpatient', 0, 60.00),
(1010, 104, '2026-03-12', 'Emergency', 'Emergency', 2, 890.00);

-- Diagnoses
INSERT INTO diagnoses (diagnosis_id, visit_id, icd10_code, diagnosis_name, category) VALUES
(1, 1001, 'I10', 'Essential Hypertension', 'Cardiovascular'),
(2, 1002, 'E11', 'Type 2 Diabetes Mellitus', 'Endocrine'),
(3, 1003, 'Z34.0', 'Normal Pregnancy Encounter', 'Obstetrics'),
(4, 1004, 'I21.9', 'Acute Myocardial Infarction', 'Cardiovascular'),
(5, 1005, 'I10', 'Essential Hypertension', 'Cardiovascular'),
(6, 1006, 'J45.909', 'Unspecified Asthma', 'Respiratory'),
(7, 1007, 'E11', 'Type 2 Diabetes Mellitus', 'Endocrine'),
(8, 1007, 'I10', 'Essential Hypertension', 'Cardiovascular'),
(9, 1008, 'E11', 'Type 2 Diabetes Mellitus', 'Endocrine'),
(10, 1010, 'I50.9', 'Heart Failure, Unspecified', 'Cardiovascular');

-- Lab Results
INSERT INTO lab_results (lab_id, visit_id, test_name, result_value, unit, is_abnormal) VALUES
(501, 1001, 'HbA1c', 5.6, '%', FALSE),
(502, 1002, 'HbA1c', 8.9, '%', TRUE),
(503, 1002, 'Fasting Blood Glucose', 11.2, 'mmol/L', TRUE),
(504, 1004, 'Troponin I', 2.40, 'ng/mL', TRUE),
(505, 1005, 'HbA1c', 5.8, '%', FALSE),
(506, 1007, 'HbA1c', 9.4, '%', TRUE),
(507, 1007, 'Serum Creatinine', 145.0, 'umol/L', TRUE),
(508, 1008, 'Fasting Blood Glucose', 7.1, 'mmol/L', TRUE),
(509, 1010, 'BNP', 680.0, 'pg/mL', TRUE);
