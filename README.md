# AI-Driven-Customer-Churn-Retention-Analysis

--Project Overview
This project focuses on identifying high-risk customers likely to churn (stop doing business) using a hybrid approach of SQL-based behavioral analysis and Machine Learning.

By analyzing 50,000+ customer records and 25,000+ transaction entries, I engineered behavioral features to segment users based on risk. The project compares a traditional Rule-Based approach (SQL) against an AI-Driven approach (Random Forest), demonstrating how machine learning can improve churn identification accuracy by ~25%

--Key Features & Business Logic
-Data Processing: Cleaned and joined datasets across Customers, Transactions, and Support Tickets.

-Feature Engineering (SQL): Engineered 15+ behavioral features including purchase frequency, inactivity days, and complaint rates using Complex SQL queries.

-Customer Segmentation: Categorized users into High, Medium, and Low Risk segments.

-AI Integration: Implemented a Random Forest Classifier to detect subtle churn patterns that static rules missed.

--Technical Implementation
1. SQL: Feature Engineering & Rule-Based Logic
I used Common Table Expressions (CTEs) and Window Functions to aggregate raw transaction logs into meaningful customer profiles.

Techniques: CTEs, LEFT JOIN, COALESCE, DATEDIFF, CASE Statements.

Key Metrics Calculated:

inactivity_days: Days since last purchase.

complaint_rate: Frequency of support tickets logged.

total_spend: Lifetime value of the customer.

2. Python: AI Prediction Model
After exporting the SQL-engineered features, I used Python to train a predictive model.

Libraries: pandas, scikit-learn

Model: Random Forest Classifier

Goal: Validate if ML could outperform the static SQL rules (e.g., "If inactive > 90 days").

--Results & Insights

Risk Identification: Successfully identified ~20% of the user base as "High Risk".


Accuracy Boost: The AI model caught "silent churners" (users who visit but don't buy) that the SQL rules missed, improving identification accuracy by ~25%.

Actionable Insight: High complaint rates were the strongest predictor of churn, suggesting a need for immediate intervention by the support team.
