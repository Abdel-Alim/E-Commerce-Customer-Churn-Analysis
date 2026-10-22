USE ecommerce_db;
GO

/* ============================================================================
   PROJECT: E-Commerce Customer Churn Analysis (SQL Server / SSMS Compatible)
   ============================================================================ */

-- ============================================================================
-- STEP 1: DATA CLEANING (تنظيف البيانات)
-- ============================================================================

IF OBJECT_ID('ecommerce_churn_clean', 'U') IS NOT NULL 
    DROP TABLE ecommerce_churn_clean;
GO

SELECT 
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS CustomerID,
    
    -- تحويل Churn إلى INT لمنع أي خطأ مستقبلي
    CAST(Churn AS INT) AS Churn,
    CASE WHEN CAST(Churn AS INT) = 1 THEN 'Churned' ELSE 'Stayed' END AS ChurnStatus,
    
    COALESCE(Tenure, (SELECT ROUND(AVG(Tenure), 0) FROM data_ecommerce_customer_churn)) AS Tenure,
    COALESCE(WarehouseToHome, (SELECT ROUND(AVG(WarehouseToHome), 0) FROM data_ecommerce_customer_churn)) AS WarehouseToHome,
    COALESCE(DaySinceLastOrder, (SELECT ROUND(AVG(DaySinceLastOrder), 0) FROM data_ecommerce_customer_churn)) AS DaySinceLastOrder,
    COALESCE(CashbackAmount, (SELECT ROUND(AVG(CashbackAmount), 2) FROM data_ecommerce_customer_churn)) AS CashbackAmount,
    
    CASE 
        WHEN PreferedOrderCat = 'Mobile' THEN 'Mobile Phone' 
        ELSE PreferedOrderCat 
    END AS PreferedOrderCat,
    
    SatisfactionScore,
    MaritalStatus,
    NumberOfAddress,
    NumberOfDeviceRegistered,
    Complain
INTO ecommerce_churn_clean
FROM data_ecommerce_customer_churn;
GO


-- ============================================================================
-- STEP 2: EXPLORATORY DATA ANALYSIS (التحليل الاستكشافي)
-- ============================================================================

-- 1. معدل التسرب العام للعملاء
SELECT 
    COUNT(*) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS TotalChurned,
    ROUND(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(*) * 100, 2) AS ChurnRatePct
FROM ecommerce_churn_clean;
GO

-- 2. تحليل التسرب حسب فئة الطلبات المفضلة
SELECT 
    PreferedOrderCat,
    COUNT(CustomerID) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS ChurnedCustomers,
    ROUND(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePct
FROM ecommerce_churn_clean
GROUP BY PreferedOrderCat
ORDER BY ChurnRatePct DESC;
GO

-- 3. تأثير الشكاوى على تسرب العملاء
SELECT 
    CASE WHEN Complain = 1 THEN 'Yes' ELSE 'No' END AS HasComplaint,
    COUNT(CustomerID) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS ChurnedCustomers,
    ROUND(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePct
FROM ecommerce_churn_clean
GROUP BY Complain
ORDER BY ChurnRatePct DESC;
GO

-- 4. تحليل التسرب حسب الحالة الاجتماعية
SELECT 
    MaritalStatus,
    COUNT(CustomerID) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS ChurnedCustomers,
    ROUND(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePct
FROM ecommerce_churn_clean
GROUP BY MaritalStatus
ORDER BY ChurnRatePct DESC;
GO

-- 5. علاقة درجة الرضا بتسرب العملاء
SELECT 
    SatisfactionScore,
    COUNT(CustomerID) AS TotalCustomers,
    SUM(CAST(Churn AS INT)) AS ChurnedCustomers,
    ROUND(CAST(SUM(CAST(Churn AS INT)) AS FLOAT) / COUNT(CustomerID) * 100, 2) AS ChurnRatePct
FROM ecommerce_churn_clean
GROUP BY SatisfactionScore
ORDER BY SatisfactionScore ASC;
GO

-- 6. متوسط مدة التعامل والمبلغ المرتجع للمستمرين مقابل المغادرين
SELECT 
    ChurnStatus,
    ROUND(AVG(Tenure), 1) AS AvgTenureMonths,
    ROUND(AVG(CashbackAmount), 2) AS AvgCashback,
    ROUND(AVG(WarehouseToHome), 1) AS AvgWarehouseDistance
FROM ecommerce_churn_clean
GROUP BY ChurnStatus;
GO