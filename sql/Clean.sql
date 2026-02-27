-- 创建清洗后的数据表
CREATE TABLE clean_transactions AS
SELECT *
FROM raw_transactions
WHERE Quantity > 0
  AND UnitPrice > 0;

-- 创建做RFM的表
CREATE TABLE clean_transactions_rfm AS
SELECT *
FROM clean_transactions
WHERE CustomerID IS NOT NULL;

SELECT COUNT(*) FROM clean_transactions;
SELECT COUNT(*) FROM clean_transactions_rfm;

-- 构建订单事实表
CREATE TABLE fact_orders AS
SELECT
    InvoiceNo,
    CustomerID,
    MIN(InvoiceDate) AS order_date,
    SUM(Quantity * UnitPrice) AS order_value,
    SUM(Quantity) AS total_quantity,
    COUNT(DISTINCT StockCode) AS product_count
FROM clean_transactions
GROUP BY InvoiceNo, CustomerID;

SELECT COUNT(*) FROM fact_orders;