Personal Loan Credit Risk & Default Analytics

📌 Project Overview
An end-to-end Personal Loan Credit Risk & Default Analytics project focused on analyzing loan application data to identify default patterns, segment credit risk, and generate actionable lending insights.
The project uses 25,000 loan applications and demonstrates the complete analytics workflow — from data cleaning and validation to SQL analysis, Python-based statistical analysis, and an interactive Power BI dashboard.

🎯 Business Objective
The primary objectives of this project were to:
- Analyze overall loan portfolio performance and default rate
- Identify key factors associated with loan defaults
- Segment applicants based on credit risk
- Analyze the relationship between CIBIL score, loan amount, collateral, and default
- Build an interactive dashboard for portfolio and risk analysis
- Generate insights that can support data-driven lending and credit-risk decisions

🛠️ Tools & Technologies

Tool	Purpose
Excel	Data cleaning and validation
PostgreSQL	Data analysis and SQL-based risk segmentation
Python	EDA, visualization and statistical testing
Pandas	Data manipulation
Matplotlib	Data visualization
SciPy	Statistical hypothesis testing
Power BI	Interactive dashboard and reporting


📊 Dataset
The dataset contains 25,000 loan applications with 22 attributes, including:
- Applicant demographics
- Employment information
- Monthly income
- Existing loans and EMI
- Credit utilization
- Credit inquiries
- Late payments
- Loan amount and tenure
- Loan purpose
- Collateral status
- CIBIL score
- Interest rate
- Default risk score
- Default flag
Note: This is an independent analytics project using an India-focused loan dataset. It does not contain Navi customer data.

🧹 Data Cleaning & Validation
Data preparation was performed before analysis.
Key activities included:
- Identified missing values
- Imputed missing numerical values using median values
- Validated numerical ranges
- Checked categorical fields for inconsistencies
- Verified the cleaned dataset contained 25,000 records and no remaining missing values
- Performed basic outlier and data-quality checks

🗄️ SQL Analysis — PostgreSQL
PostgreSQL was used to analyze portfolio performance and identify risk patterns.
Key analyses
- Total applications
- Total loan amount requested
- Average loan amount
- Overall default rate
- Default rate by CIBIL score
- Default rate by loan amount
- Default rate by collateral status
- Default rate by employment type
- Default rate by credit utilization
- Risk segmentation based on CIBIL score


Portfolio KPIs
Metric	Result
Total Applications	25,000
Total Loan Amount Requested	₹396.14 Cr
Average Loan Amount	₹1,58,457
Overall Default Rate	6.14%


🐍 Python Analysis
Python was used for exploratory data analysis and statistical validation.
Analysis performed
- Dataset profiling
- Missing-value validation
- Descriptive statistics
- Default distribution analysis
- Correlation analysis
- CIBIL score segmentation
- Loan amount segmentation
- Collateral analysis
- Statistical hypothesis testing
  
A Welch's independent t-test was performed to determine whether CIBIL scores differed significantly between defaulters and non-defaulters.
The test showed a statistically significant difference (p < 0.001).


📈 Power BI Dashboard
An interactive Power BI dashboard was developed to monitor loan portfolio and credit-risk patterns.
Dashboard includes
KPI Cards
- Total Applications
- Total Loan Amount
- Average Loan Amount
- Default Rate
Risk Analysis
- Default Rate by CIBIL Score Range
- Default Rate by Loan Amount
- Default Rate by Collateral Status
- Default Rate by Employment Type
- Default Rate by Credit Utilization
Interactive Filters
- State
- Gender
- Loan Purpose

  
🔍 Key Findings
1. CIBIL score is the strongest risk differentiator
CIBIL Range	Default Rate
Below 550	23.77%
550–649	4.26%
650–749	0.77%
750+	0.00%

Applicants with CIBIL scores below 550 showed substantially higher default rates than higher-score segments.
2. Loan amount shows a meaningful difference
Applicants requesting loans below ₹1 lakh had a default rate of approximately 1.8%, while loan amounts above ₹1 lakh showed default rates around 8%.

3. Collateral is associated with lower default rates
- Without collateral: 6.85%
- With collateral: 3.59%
  
4. Employment type has a relatively weak relationship
Default rates across employment categories were relatively close, ranging approximately from 5.9% to 6.4%.

6. Credit utilization shows a weaker relationship
Default rates across utilization bands were relatively close, ranging from approximately 5.7% to 7.2%.


💡 Business Insights
Based on the analysis, credit-risk teams could consider:
- Giving greater attention to applicants with lower CIBIL scores
- Using loan amount as an additional risk-segmentation factor
- Considering collateral status when assessing risk
- Avoiding reliance on a single variable and using multiple risk indicators together
- Using interactive dashboards for ongoing portfolio monitoring
These are analytical recommendations based on the dataset and not production lending policies.


personal-loan-credit-risk-analytics/
│
├── README.md
│
├── data/
│   └── loan_default_cleaned.csv
│
├── sql/
│   └── credit_risk_analysis.sql
│
├── python/
│   └── credit_risk_analysis.ipynb
│
├── powerbi/
│   └── personal_loan_credit_risk.pbix
│
└── screenshots/
    └── dashboard.png
    

🚀 Project Outcome
This project demonstrates an end-to-end analytics workflow involving:
Data Cleaning → SQL Analysis → Python EDA → Statistical Testing → Power BI Dashboard → Business Insights
It strengthened practical skills in SQL, Python, Power BI, data validation, statistical analysis, risk segmentation, and business-focused data storytelling.

👤 Author
Kiran S Poojari
Aspiring Data Analyst / Business Analyst with skills in:
SQL | Excel | Power BI | Python | Data Analytics
