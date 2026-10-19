CREATE DATABASE hosp_core_db;

USE hosp_core_db;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    county VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL
);

CREATE TABLE visits (
    visit_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    visit_date DATE NOT NULL,
    department VARCHAR(50) NOT NULL,
    admission_type VARCHAR(20) NOT NULL, -- e.g., Outpatient, Inpatient, Emergency
    length_of_stay_days INT DEFAULT 0,
    total_cost_usd DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE diagnoses (
    diagnosis_id INT PRIMARY KEY,
    visit_id INT NOT NULL,
    icd10_code VARCHAR(10) NOT NULL,
    diagnosis_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL, -- e.g., Cardiovascular, Endocrine, Infectious
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

CREATE TABLE lab_results (
    lab_id INT PRIMARY KEY,
    visit_id INT NOT NULL,
    test_name VARCHAR(50) NOT NULL,
    result_value DECIMAL(8, 2) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    is_abnormal BOOLEAN NOT NULL,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);
