-- 创建数据库
CREATE DATABASE ecommerce_analysis;

-- 进入数据库
USE ecommerce_analysis;

-- 创建原始表 与csv文件中列名对应
CREATE TABLE raw_transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

-- 查看数据导入情况
SELECT COUNT(*) FROM raw_transactions;

-- 数据质量审查
-- 查看数据时间范围

SELECT
    MIN(InvoiceDate) AS min_date,
    MAX(InvoiceDate) AS max_date
FROM raw_transactions;

-- 查看负数数量（退货）
SELECT
    COUNT(*) AS refund
FROM raw_transactions
WHERE Quantity < 0;

-- 查看是否有价格为零或者负数的
SELECT
    COUNT(*)
FROM raw_transactions
WHERE UnitPrice <= 0;

-- 查看客户为空值情况
SELECT
    COUNT(*)
FROM raw_transactions
WHERE CustomerID IS NULL;


