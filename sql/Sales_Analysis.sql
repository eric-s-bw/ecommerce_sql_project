-- 计算总销售额
SELECT
    ROUND(SUM(order_value),2) AS total_revenue
FROM fact_orders;

-- 计算平均客单价 AOV
SELECT
    ROUND(AVG(order_value),2) AS avg_order_value
FROM fact_orders;

-- 计算总客户数
SELECT
    COUNT(DISTINCT CustomerID) AS total_customers
FROM fact_orders;

-- 计算人均订单数
SELECT
    COUNT(*) / COUNT(DISTINCT CustomerID) AS avg_orders_per_customer
FROM fact_orders;

-- 时间趋势分析
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(order_value),2) AS revenue,
    COUNT(*) AS orders
FROM fact_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 增长率计算
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(order_value) AS revenue,
    LAG(SUM(order_value)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS last_month,
    ROUND(
        (SUM(order_value) - LAG(SUM(order_value)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')))
        /
        LAG(SUM(order_value)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) * 100
    ,2) AS growth_rate_percent
FROM fact_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 前十客户贡献占比
WITH customer_rev AS (
  SELECT CustomerID, SUM(order_value) AS customer_revenue
  FROM fact_orders
  GROUP BY CustomerID
),
top10 AS (
  SELECT customer_revenue
  FROM customer_rev
  ORDER BY customer_revenue DESC
  LIMIT 10
)
SELECT
  ROUND((SELECT SUM(customer_revenue) FROM top10), 2) AS top10_revenue,
  ROUND((SELECT SUM(customer_revenue) FROM customer_rev), 2) AS total_revenue,
  ROUND(
    (SELECT SUM(customer_revenue) FROM top10)
    /
    (SELECT SUM(customer_revenue) FROM customer_rev)
    * 100, 2
  ) AS top10_pct;

-- 排名第一用户贡献度
WITH customer_rev AS (
  SELECT CustomerID, SUM(order_value) AS customer_revenue
  FROM fact_orders
  GROUP BY CustomerID
)
SELECT
  MAX(customer_revenue) AS top1_revenue,
  ROUND(
    MAX(customer_revenue) /
    (SELECT SUM(customer_revenue) FROM customer_rev) * 100, 2
  ) AS top1_pct
FROM customer_rev;

-- 前五客户消费占比
WITH customer_rev AS (
  SELECT CustomerID, SUM(order_value) AS customer_revenue
  FROM fact_orders
  GROUP BY CustomerID
),
top5 AS (
  SELECT customer_revenue
  FROM customer_rev
  ORDER BY customer_revenue DESC
  LIMIT 5
)
SELECT
  ROUND(SUM(customer_revenue),2) AS top5_revenue,
  ROUND(
    SUM(customer_revenue) /
    (SELECT SUM(customer_revenue) FROM customer_rev) * 100
  ,2) AS top5_pct
FROM top5;

/*
Top1：16.46%

Top5：24.92%

Top10：30.15%
 */

# 得出结论：该公司属于“少数大客户 + 长尾客户”的混合结构

-- RFM 客户分层
-- Recency：距离最近一次购买的天数
-- Frequency：订单次数
-- Monetary：总消费金额

CREATE TABLE rfm_base AS
SELECT
    CustomerID,
    DATEDIFF('2011-12-09', MAX(order_date)) AS recency,
    COUNT(*) AS frequency,
    SUM(order_value) AS monetary
FROM fact_orders
GROUP BY CustomerID;

SELECT * FROM rfm_base LIMIT 10;

-- 创建rfm_score表
CREATE TABLE rfm_score AS
SELECT *,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency) AS f_score,
    NTILE(5) OVER (ORDER BY monetary) AS m_score
FROM rfm_base;

SELECT * FROM rfm_score LIMIT 10;

-- 生成rfm组合标签
CREATE TABLE rfm_segment AS
SELECT *,
       CONCAT(r_score, f_score, m_score) AS rfm_code
FROM rfm_score;

-- 检查高价值用户数量 R >=4 AND F >=4 AND M >=4 （958）
SELECT
    COUNT(*) AS high_value_customers
FROM rfm_segment
WHERE r_score >=4
  AND f_score >=4
  AND m_score >=4;

SELECT COUNT(*) FROM rfm_segment; -- 4339 发现约22%的用户为高价值用户

-- 查看高价值用户贡献的收入
WITH high_value AS (
  SELECT CustomerID
  FROM rfm_segment
  WHERE r_score >=4
    AND f_score >=4
    AND m_score >=4
)
SELECT
  ROUND(SUM(f.order_value),2) AS high_value_revenue
FROM fact_orders f
JOIN high_value h
  ON f.CustomerID = h.CustomerID;

SELECT ROUND(SUM(order_value),2) FROM fact_orders; -- 总贡献的收入 发现约22%的用户（高价值用户）贡献了约54%的收入