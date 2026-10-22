# E-Commerce Customer Churn Analysis

<p align="center">
  <img src="Dashboard.png" alt="E-Commerce Customer Churn Dashboard" width="100%">
</p>

<h1 align="center">E-Commerce Customer Churn Analysis</h1>

<p align="center">
  <b>SQL Server + Power BI | Customer Churn Analysis | Business Intelligence</b>
</p>

<p align="center">
  Turning customer data into actionable retention insights using SQL Server and Power BI.
</p>

---

## Project Overview

This project analyzes **customer churn in an e-commerce business** using **SQL Server** for data cleaning and exploratory analysis and **Power BI** for interactive business intelligence and visualization.

The goal is to identify:

- Customers who are most likely to churn
- Product categories with the highest churn rates
- The impact of customer complaints on churn
- Churn behavior across marital status
- The relationship between satisfaction score and churn
- Customer behavior patterns that can support retention strategies

The project follows a complete analytical workflow:

```text
Raw Customer Data
       |
       v
Data Cleaning
       |
       v
SQL Server Analysis
       |
       v
Business Insights
       |
       v
Power BI Dashboard
       |
       v
Retention Recommendations
```

---

## Business Problem

Customer churn is one of the most important challenges for e-commerce businesses.

Losing customers can lead to:

- Lower revenue
- Higher customer acquisition costs
- Reduced customer lifetime value
- Lower customer loyalty
- Increased pressure on marketing and sales teams

The objective of this project is to understand **why customers leave** and identify the customer segments that require immediate retention actions.

---

## Project Objectives

The main objectives of this analysis are:

1. Clean and prepare the raw customer churn dataset.
2. Calculate the overall customer churn rate.
3. Analyze churn by product category.
4. Measure the impact of customer complaints.
5. Analyze churn across marital status.
6. Investigate the relationship between satisfaction and churn.
7. Compare customer characteristics between churned and retained customers.
8. Build an executive-level Power BI dashboard.
9. Provide actionable recommendations for customer retention.

---

# Technology Stack

| Technology | Purpose |
|---|---|
| SQL Server | Data cleaning and analysis |
| SSMS | SQL development environment |
| Power BI | Interactive dashboard and visualization |
| DAX | Power BI calculations |
| Power Query | Data transformation |
| GitHub | Project documentation and portfolio |

---

# Repository Structure

```text
E-Commerce-Customer-Churn-Analysis/
│
├── README.md
│
├── Dashboard.png
│
├── Ecommerce_Churn_Analysis.sql
│
└── E-Commerce Customer Churn Dashboard.pbix
```

### Files Description

**Ecommerce_Churn_Analysis.sql**

Contains the complete SQL Server workflow including:

- Data cleaning
- Missing value treatment
- Customer segmentation
- Churn calculations
- Exploratory Data Analysis
- Business analysis

**E-Commerce Customer Churn Dashboard.pbix**

Power BI dashboard containing the interactive visualizations and executive insights.

**Dashboard.png**

Preview image of the final Power BI dashboard.

---

# Data Preparation

The project starts by creating a cleaned analytical table called:

```sql
ecommerce_churn_clean
```

The cleaning process includes:

- Creating a unique `CustomerID`
- Converting churn values into integer format
- Creating a readable `ChurnStatus`
- Handling missing values
- Standardizing product category names
- Preparing customer attributes for analysis

Example:

```sql
CASE 
    WHEN CAST(Churn AS INT) = 1 
    THEN 'Churned' 
    ELSE 'Stayed' 
END AS ChurnStatus
```

This converts the original churn indicator into a business-friendly categorical field.

---

# Missing Value Treatment

Missing values were handled using average-value imputation.

For example:

```sql
COALESCE(
    Tenure,
    (
        SELECT ROUND(AVG(Tenure), 0)
        FROM data_ecommerce_customer_churn
    )
) AS Tenure
```

The same approach was applied to relevant numerical fields such as:

- Tenure
- WarehouseToHome
- DaySinceLastOrder
- CashbackAmount

This ensures that missing values do not prevent further analysis.

---

# Data Standardization

Product category values were also standardized.

For example:

```sql
CASE 
    WHEN PreferedOrderCat = 'Mobile' 
    THEN 'Mobile Phone'
    ELSE PreferedOrderCat
END AS PreferedOrderCat
```

This creates consistent category labels for reporting and visualization.

---

# Exploratory Data Analysis

After cleaning the data, several SQL queries were used to understand customer churn.

## Overall Churn

The project calculates:

- Total Customers
- Total Churned Customers
- Overall Churn Rate

```sql
SELECT 
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS TotalChurned,
    ROUND(
        CAST(SUM(CAST(Churn AS INT)) AS FLOAT) 
        / COUNT(*) * 100,
        2
    ) AS ChurnRatePct
FROM ecommerce_churn_clean;
```

---

# Churn by Product Category

The analysis evaluates customer churn across different product categories.

This helps identify product categories where customers are more likely to leave.

The dashboard highlights:

| Product Category | Displayed Churn Rate |
|---|---:|
| Mobile Phone | ~29% |
| Fashion | ~16% |
| Laptop & Accessory | ~10% |
| Others | ~7% |
| Grocery | ~4% |

### Key Finding

The **Mobile Phone** category has the highest displayed churn rate.

This suggests that product quality, customer support, delivery experience, or post-sale service should be investigated within this category.

---

# Churn by Complaint Status

Customer complaints are one of the strongest indicators of churn in this analysis.

The dashboard compares customers who:

- Submitted complaints
- Did not submit complaints

### Key Finding

Customers with complaints show a significantly higher churn rate than customers without complaints.

The dashboard highlights approximately:

```text
Complaint Customers
Churn Rate ≈ 32.8%

Non-Complaint Customers
Much Lower Churn Rate
```

### Business Interpretation

Customer complaints should be treated as an early warning signal.

Companies should consider:

- Faster complaint resolution
- Customer service follow-up
- Escalation procedures
- Service recovery offers
- Post-resolution satisfaction tracking

---

# Churn by Marital Status

Customer churn was also analyzed according to marital status.

The dashboard includes:

- Married
- Single
- Divorced

The customer distribution shown in the dashboard is approximately:

| Marital Status | Customer Share |
|---|---:|
| Married | 52.14% |
| Single | 33.24% |
| Divorced | 14.62% |

### Key Finding

The **Single** customer segment shows the highest displayed churn risk.

This indicates an opportunity to create targeted retention campaigns for this segment.

---

# Churn by Satisfaction Score

Customer satisfaction was analyzed to understand whether satisfaction levels are associated with churn.

The dashboard compares:

```text
Satisfaction Score
        +
Complaint Status
        |
        v
Customer Churn Rate
```

The analysis reveals differences in churn behavior across satisfaction levels.

### Important Observation

Some higher satisfaction scores still show relatively high churn.

This creates a potential **Satisfaction Paradox** that requires additional investigation.

Possible explanations could include:

- Customer expectations
- Product availability
- Competitor offers
- Delivery experience
- Pricing
- Customer service expectations
- Loyalty program effectiveness

---

# Customer Behavior Analysis

The project also compares average customer characteristics between churned and retained customers.

The analysis includes:

- Average Tenure
- Average Cashback
- Average Warehouse-to-Home Distance

Example SQL:

```sql
SELECT 
    ChurnStatus,
    ROUND(AVG(Tenure), 1) AS AvgTenureMonths,
    ROUND(AVG(CashbackAmount), 2) AS AvgCashback,
    ROUND(AVG(WarehouseToHome), 1) AS AvgWarehouseDistance
FROM ecommerce_churn_clean
GROUP BY ChurnStatus;
```

This provides additional context around customer behavior.

---

# Power BI Dashboard

The final dashboard was designed as an **Executive Customer Churn Dashboard**.

It combines KPI cards, charts, filters, and business recommendations into a single analytical interface.

## Dashboard Structure

```text
+---------------------------------------------------------------+
|              E-COMMERCE CUSTOMER CHURN DASHBOARD              |
|          Executive Insights & Retention Strategy               |
+---------------------------------------------------------------+
| PRODUCT CATEGORY FILTER                                       |
+----------------+----------------+----------------+------------+
| TOTAL CUSTOMERS| TOTAL CHURNED  |   CHURN RATE   | AVG TENURE |
+----------------+----------------+----------------+------------+
|                                                               |
| CHURN BY       | CHURN RATE BY PRODUCT CATEGORY                |
| COMPLAINT      |                                                |
| STATUS         |                                                |
|                                                               |
+----------------+-----------------------------------------------+
| CHURN RATE BY MARITAL STATUS                                  |
|                                                               |
+---------------------------------------------------------------+
| SATISFACTION SCORE & COMPLAINT ANALYSIS                       |
+---------------------------------------------------------------+
| EXECUTIVE INSIGHTS & RECOMMENDATIONS                          |
+---------------------------------------------------------------+
```

---

# Dashboard KPIs

The dashboard includes four primary KPIs.

### Total Customers

```text
3.941K
```

Represents the total number of customers analyzed.

### Total Churned

```text
674
```

Represents the number of customers identified as churned.

### Churn Rate

```text
17%
```

Represents the overall customer churn level shown in the dashboard.

### Average Tenure

```text
10.08
```

Represents the average customer tenure.

---

# Dashboard Visualizations

## 1. Churn by Complaint Status

A comparison of churned customers based on complaint status.

The visualization highlights the strong relationship between complaints and customer churn.

---

## 2. Churn Rate by Product Category

A bar chart comparing churn rates across product categories.

The highest displayed churn rate is associated with:

```text
Mobile Phone
```

followed by:

```text
Fashion
Laptop & Accessory
Others
Grocery
```

---

## 3. Churn Rate by Marital Status

A donut chart showing customer distribution across marital status groups.

The visualization allows management to identify important customer segments.

---

## 4. Churn Rate by Satisfaction Score & Complaint

This visualization combines:

- Satisfaction Score
- Complaint Status
- Churn Rate

It helps identify combinations of satisfaction and complaint behavior associated with higher churn.

---

# Executive Insights

## Insight 1 — Complaints Have a Strong Impact

Customers who submit complaints demonstrate significantly higher churn behavior.

### Recommendation

Implement a structured complaint management process:

```text
Complaint
   ↓
Immediate Detection
   ↓
Priority Classification
   ↓
Fast Resolution
   ↓
Customer Follow-up
   ↓
Retention Offer
```

---

## Insight 2 — Mobile Phone Customers Are High Risk

The Mobile Phone category has the highest displayed churn rate.

### Recommendation

Investigate:

- Product quality
- Delivery issues
- Returns
- Warranty experience
- Customer support
- Post-sale service

A category-specific retention strategy should be considered.

---

## Insight 3 — Single Customers Represent a High-Risk Segment

Single customers show the highest displayed churn rate among the marital-status groups.

### Recommendation

Develop targeted retention strategies such as:

- Personalized offers
- Loyalty rewards
- Exclusive promotions
- Personalized recommendations
- Customer engagement campaigns

---

## Insight 4 — Satisfaction Requires Deeper Investigation

Higher satisfaction scores do not always correspond to lower churn.

### Recommendation

The company should investigate additional factors such as:

- Customer expectations
- Pricing
- Competitor activity
- Delivery performance
- Product availability
- Service quality
- Loyalty programs

This can help explain the observed satisfaction paradox.

---

# Retention Strategy Framework

The insights from this project can be transformed into a practical retention framework.

```text
                 CUSTOMER DATA
                       |
                       v
              CHURN RISK ANALYSIS
                       |
          +------------+------------+
          |            |            |
          v            v            v
      Complaints   Product       Customer
                   Category      Segment
          |            |            |
          v            v            v
      Service       Quality      Targeted
      Recovery      Control      Campaign
          |            |            |
          +------------+------------+
                       |
                       v
                RETENTION ACTION
                       |
                       v
              LOWER CUSTOMER CHURN
```

---

# SQL Analysis Workflow

The SQL workflow follows a structured analytical process:

```text
Raw Data
   |
   v
Data Cleaning
   |
   v
Missing Value Treatment
   |
   v
Data Standardization
   |
   v
Customer Churn Classification
   |
   v
Exploratory Data Analysis
   |
   v
Business Insights
```

---

# Power BI Workflow

The Power BI workflow follows:

```text
SQL Server
    |
    v
Clean Analytical Table
    |
    v
Power BI
    |
    +---- Data Modeling
    |
    +---- Measures
    |
    +---- Visualizations
    |
    +---- Filters
    |
    +---- Dashboard
    |
    v
Executive Decision Making
```

---

# Analytical Framework

The project follows a complete Business Intelligence workflow:

| Stage | Description |
|---|---|
| Business Understanding | Define the customer churn problem |
| Data Preparation | Clean and transform customer data |
| SQL Analysis | Analyze churn patterns |
| Data Exploration | Identify important customer segments |
| Visualization | Build interactive Power BI visuals |
| Insight Generation | Identify key churn drivers |
| Recommendations | Propose retention strategies |

---

# Key Business Questions Answered

This project answers important business questions such as:

### 1. How many customers have churned?

The dashboard identifies:

```text
674 Churned Customers
```

### 2. What is the overall churn level?

The dashboard displays an overall churn rate of approximately:

```text
17%
```

### 3. Which product category has the highest churn?

```text
Mobile Phone
```

### 4. Do complaints affect churn?

Yes.

Customers with complaints demonstrate substantially higher churn behavior.

### 5. Which marital status represents a high-risk segment?

```text
Single Customers
```

### 6. Does satisfaction fully explain churn?

No.

The dashboard shows that some higher satisfaction levels can still have relatively high churn, suggesting that additional variables should be investigated.

---

# Skills Demonstrated

This project demonstrates practical skills in:

### SQL

- SQL Server
- Data Cleaning
- `CASE`
- `COALESCE`
- `CAST`
- `ROUND`
- `COUNT`
- `SUM`
- `AVG`
- `GROUP BY`
- Window Functions
- Conditional Analysis
- Exploratory Data Analysis

### Power BI

- Data Modeling
- Data Visualization
- KPI Cards
- Donut Charts
- Bar Charts
- Filters
- Interactive Dashboard Design
- Executive Reporting
- Business Insights

### Business Intelligence

- Customer Segmentation
- Churn Analysis
- Retention Strategy
- KPI Development
- Business Recommendations
- Data Storytelling

---

# Project Outcome

The final solution transforms raw customer data into a business intelligence dashboard that allows decision-makers to quickly understand:

```text
WHO IS CHURNING?
        |
        v
WHY ARE THEY CHURNING?
        |
        v
WHICH SEGMENTS ARE HIGH RISK?
        |
        v
WHAT ACTION SHOULD THE BUSINESS TAKE?
```

The combination of SQL Server and Power BI creates a complete analytical pipeline from **raw data to business decision-making**.

---

# Project Files

### SQL Analysis

`Ecommerce_Churn_Analysis.sql`

Contains the complete SQL Server analysis workflow.

### Power BI Dashboard

`E-Commerce Customer Churn Dashboard.pbix`

Contains the interactive Power BI dashboard.

### Dashboard Preview

`Dashboard.png`

Contains the final dashboard preview.

---

# How to Use

## 1. Run the SQL Script

Open:

```text
Ecommerce_Churn_Analysis.sql
```

in SQL Server Management Studio.

Make sure the source database exists:

```text
ecommerce_db
```

and that the source table exists:

```text
data_ecommerce_customer_churn
```

Then execute the SQL script.

---

## 2. Open Power BI

Open:

```text
E-Commerce Customer Churn Dashboard.pbix
```

in Power BI Desktop.

---

## 3. Explore the Dashboard

Use the:

```text
PRODUCT CATEGORY
```

filter to analyze churn across different product categories.

Explore the KPI cards and visualizations to understand the main churn drivers.

---

# Recommended Next Steps

This project can be extended by adding:

- Customer Lifetime Value
- Revenue at Risk
- Customer Cohort Analysis
- Monthly Churn Trends
- RFM Customer Segmentation
- Churn Prediction Machine Learning Model
- Customer Risk Score
- Automated Retention Alerts
- Advanced DAX Measures
- Drill-through Customer Profiles

A future version could combine the Power BI dashboard with a machine learning model to predict which customers are most likely to churn.

---

# Final Business Recommendation

The analysis indicates that customer retention should focus on **early identification of high-risk customers**.

The most important actions are:

1. Prioritize customers who submit complaints.
2. Investigate the high churn rate in the Mobile Phone category.
3. Create targeted retention campaigns for high-risk customer segments.
4. Investigate the relationship between satisfaction and churn more deeply.
5. Monitor churn KPIs continuously through Power BI.
6. Develop predictive churn models to identify customers before they leave.

---

# Author

## Abdel-Alim

**Data Scientist | NLP Specialist | BI Analyst | AI Automation Engineer**

I turn business questions into intelligent solutions using:

```text
Python
SQL
Power BI
NLP
Machine Learning
AI Automation
```

### GitHub

[Visit My GitHub Profile](https://github.com/Abdel-Alim/Abdel-Alim)

---

# License

This project is intended for educational, portfolio, and demonstration purposes.

---

<p align="center">
  <b>E-Commerce Customer Churn Analysis</b>
  <br>
  SQL Server • Power BI • Business Intelligence
</p>
