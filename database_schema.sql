-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    join_date DATE,
    region VARCHAR(50)
);

-- 2. Transactions Table (for purchase frequency & inactivity)
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 3. Support_Tickets Table (for complaint rates)
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    ticket_date DATE,
    issue_type VARCHAR(50), -- e.g., 'Complaint', 'Inquiry'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Query

/* Goal: Engineer features for Inactivity, Frequency, and Complaint Rate
  Techniques: CTEs, Window Functions, Aggregations
*/

WITH Transaction_Stats AS (
    -- Calculate Purchase Frequency and Inactivity
    SELECT 
        customer_id,
        COUNT(transaction_id) AS total_transactions,
        MAX(transaction_date) AS last_purchase_date,
        SUM(amount) AS total_spend,
        DATEDIFF(CURRENT_DATE, MAX(transaction_date)) AS inactivity_days
    FROM transactions
    GROUP BY customer_id
),

Complaint_Stats AS (
    -- Calculate Complaint Rates
    SELECT 
        customer_id,
        COUNT(ticket_id) AS total_complaints
    FROM support_tickets
    WHERE issue_type = 'Complaint'
    GROUP BY customer_id
),

Customer_Features AS (
    -- Combine datasets
    SELECT 
        c.customer_id,
        c.join_date,
        COALESCE(ts.total_transactions, 0) AS purchase_frequency,
        COALESCE(ts.inactivity_days, 999) AS inactivity_days, -- 999 if no purchase
        COALESCE(cs.total_complaints, 0) AS complaint_count
    FROM customers c
    LEFT JOIN Transaction_Stats ts ON c.customer_id = ts.customer_id
    LEFT JOIN Complaint_Stats cs ON c.customer_id = cs.customer_id
)

-- Final Segmentation Query (Rule-Based)
SELECT 
    customer_id,
    purchase_frequency,
    inactivity_days,
    complaint_count,
    -- Rule-Based Churn Logic (CASE Statements)
    CASE 
        WHEN inactivity_days > 90 OR complaint_count >= 3 THEN 'High Risk'
        WHEN inactivity_days BETWEEN 60 AND 90 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS churn_risk_segment
FROM Customer_Features;