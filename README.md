# 🏥 Clinical Data Science & Healthcare Analytics SQL Portfolio

## Overview
This repository contains a privacy-preserving synthetic medical database schema alongside production-grade SQL analytics modules. The queries demonstrate clinical decision-support logic, risk cohort identification, quality-of-care tracking, and hospital resource stratification.

---

## 📐 Relational Database Schema

The database models a clinical workflow spanning patient demographics, clinic visits, diagnostic coding (ICD-10), and laboratory results:

* **`patients`**: Demographic profiles (Age, Gender, County).
* **`visits`**: Encounter records (Department, Admission Type, Length of Stay, Total Cost).
* **`diagnoses`**: Clinical diagnostic records (ICD-10 Codes, Diagnosis Name, Category).
* **`lab_results`**: Laboratory biomarker measurements (Test Name, Result Value, Abnormality Flag).

---

## 📊 Analytical Modules & Key Questions

### Module 1: Uncontrolled Type 2 Diabetes Risk Cohort
* **Clinical Focus:** Identifies patients with Type 2 Diabetes (ICD-10 `E11`) whose latest glycated hemoglobin (HbA1c) level exceeds the uncontrolled threshold (> 8.0%).
* **SQL Focus:** CTEs combined with `ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY visit_date DESC)` to isolate recency.

### Module 2: Multi-Morbidity Cohort Identification
* **Clinical Focus:** Detects complex patients presenting with co-occurring Cardiovascular and Endocrine conditions across encounters.
* **SQL Focus:** Grouping and conditional aggregation using `HAVING COUNT(DISTINCT category) = 2`.

### Module 3: 30-Day Unplanned Hospital Readmission Tracker
* **Clinical Focus:** Evaluates healthcare delivery quality by identifying inpatient readmissions occurring within 30 days of discharge.
* **SQL Focus:** Temporal sequencing using `LAG(visit_date) OVER (PARTITION BY patient_id ORDER BY visit_date)` and `DATEDIFF()`.

### Module 4: Patient Expenditure & Resource Stratification
* **Clinical Focus:** Segments the patient population into cost quintiles to isolate top-tier financial utilizers for proactive care management.
* **SQL Focus:** Window ranking functions using `NTILE(5) OVER (ORDER BY cumulative_cost DESC)`.

---

## 🚀 Execution Instructions

1. Clone this repository:
   ```bash
   git clone [https://github.com/DrData-bit/med-data-sql-portfolio.git](https://github.com/DrData-bit/med-data-sql-portfolio.git)
