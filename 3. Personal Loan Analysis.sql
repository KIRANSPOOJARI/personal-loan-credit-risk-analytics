
CREATE TABLE loan_default 

(

applicant_id varchar(20),
age int,
gender varchar(10),
marital_status varchar(20),
city_tier varchar(10),
state varchar(20),
employment_type  varchar(30),
bank_account_vintage_years  Float,
monthly_income_inr int,
existing_loans_count int,
existing_emi_monthly_inr int,
credit_utilization_ratio_pct Float,
num_credit_inquiries_last_6m  int,
late_payments_last_12m   int,
loan_amount_requested_inr  int,
loan_tenure_months  int,
loan_purpose  varchar(30),
collateral_provided varchar(10),
cibil_score int,
interest_rate_offered_pct float,
default_risk_score float,
default_flag  int

);



select count(*) as total_application,
    SUM(loan_amount_requested_inr) AS total_loan_amount,
    ROUND(AVG(loan_amount_requested_inr), 2) AS avg_loan_amount,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default;


   
---- default rate vary by CIBIL score range?

SELECT
    CASE
        WHEN cibil_score < 550 THEN 'Below 550'
        WHEN cibil_score BETWEEN 550 AND 649 THEN '550-649'
        WHEN cibil_score BETWEEN 650 AND 749 THEN '650-749'
        WHEN cibil_score >= 750 THEN '750+'
    END AS cibil_range,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY cibil_range
ORDER BY cibil_range;




------ Does credit utilization affect default risk? 



SELECT
    CASE
        WHEN credit_utilization_ratio_pct < 30 THEN 'Below 30%'
        WHEN credit_utilization_ratio_pct < 60 THEN '30%-59%'
        WHEN credit_utilization_ratio_pct < 80 THEN '60%-79%'
        ELSE '80%+'
    END AS utilization_range,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY utilization_range
ORDER BY utilization_range;



-- How does the number of late payments affect default rate?


SELECT
    CASE
        WHEN late_payments_last_12m = 0 THEN '0 Late Payments'
        WHEN late_payments_last_12m BETWEEN 1 AND 2 THEN '1-2 Late Payments'
        WHEN late_payments_last_12m BETWEEN 3 AND 5 THEN '3-5 Late Payments'
        ELSE '6+ Late Payments'
    END AS late_payment_range,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY late_payment_range
ORDER BY late_payment_range;





---- examine income vs default risk.

SELECT
    CASE
        WHEN monthly_income_inr < 30000 THEN 'Below 30K'
        WHEN monthly_income_inr < 60000 THEN '30K-59K'
        WHEN monthly_income_inr < 100000 THEN '60K-99K'
        ELSE '100K+'
    END AS income_range,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY income_range
ORDER BY income_range;






------  existing EMI burden relative to income, which is more meaningful than income alone.

SELECT
    CASE
        WHEN existing_emi_monthly_inr / NULLIF(monthly_income_inr, 0) < 0.20
            THEN 'Below 20%'
        WHEN existing_emi_monthly_inr / NULLIF(monthly_income_inr, 0) < 0.40
            THEN '20%-39%'
        WHEN existing_emi_monthly_inr / NULLIF(monthly_income_inr, 0) < 0.60
            THEN '40%-59%'
        ELSE '60%+'
    END AS emi_income_ratio,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY emi_income_ratio
ORDER BY emi_income_ratio;


SELECT
    ROUND(
        MAX(
            existing_emi_monthly_inr::numeric
            / NULLIF(monthly_income_inr, 0) * 100
        ), 2
    ) AS maximum_emi_income_pct
FROM loan_default;


SELECT
    applicant_id,
    monthly_income_inr,
    existing_emi_monthly_inr,
    ROUND(
        existing_emi_monthly_inr::numeric
        / NULLIF(monthly_income_inr, 0) * 100,
        2
    ) AS emi_income_pct
FROM loan_default
ORDER BY emi_income_pct DESC
LIMIT 10;



SELECT
    CASE
        WHEN existing_emi_monthly_inr::numeric / NULLIF(monthly_income_inr, 0) < 0.20
            THEN 'Below 20%'
        WHEN existing_emi_monthly_inr::numeric / NULLIF(monthly_income_inr, 0) < 0.40
            THEN '20%-39%'
        WHEN existing_emi_monthly_inr::numeric / NULLIF(monthly_income_inr, 0) < 0.60
            THEN '40%-59%'
        ELSE '60%+'
    END AS emi_income_ratio,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY emi_income_ratio
ORDER BY emi_income_ratio;







SELECT
    loan_purpose,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY loan_purpose
ORDER BY default_rate_pct DESC;


--------- employment type vs default rate.

SELECT
    employment_type,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY employment_type
ORDER BY default_rate_pct DESC;


-------- Loan amount vs default risk

SELECT
    CASE
        WHEN loan_amount_requested_inr < 100000 THEN 'Below 1L'
        WHEN loan_amount_requested_inr < 300000 THEN '1L-2.99L'
        WHEN loan_amount_requested_inr < 500000 THEN '3L-4.99L'
        ELSE '5L+'
    END AS loan_amount_range,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY loan_amount_range
ORDER BY default_rate_pct DESC;


------   collateral vs default risk:


SELECT
    collateral_provided,
    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_default
GROUP BY collateral_provided
ORDER BY default_rate_pct DESC;






SELECT
    CASE
        WHEN cibil_score < 550 THEN 'High Risk'
        WHEN cibil_score BETWEEN 550 AND 649 THEN 'Medium Risk'
        WHEN cibil_score BETWEEN 650 AND 749 THEN 'Low Risk'
        ELSE 'Very Low Risk'
    END AS risk_segment,

    COUNT(*) AS applicants,
    SUM(default_flag) AS defaults,

    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct,

    ROUND(AVG(loan_amount_requested_inr), 2) AS avg_loan_amount,

    ROUND(AVG(monthly_income_inr), 2) AS avg_monthly_income

FROM loan_default

GROUP BY
    CASE
        WHEN cibil_score < 550 THEN 'High Risk'
        WHEN cibil_score BETWEEN 550 AND 649 THEN 'Medium Risk'
        WHEN cibil_score BETWEEN 650 AND 749 THEN 'Low Risk'
        ELSE 'Very Low Risk'
    END

ORDER BY
    MIN(cibil_score);