/*
定义：
    高频客户：frequency ≥ 4
    低频客户：frequency ≤ 2
 */

-- 统计学检验数据准备
 SELECT
    f.CustomerID,
    f.order_value,
    r.frequency
FROM fact_orders f
JOIN rfm_base r
  ON f.CustomerID = r.CustomerID;

-- 为归因分析做数据准备
SELECT
    f.CustomerID,
    f.order_value,
    f.product_count,
    r.frequency,
    r.recency
FROM fact_orders f
JOIN rfm_base r
  ON f.CustomerID = r.CustomerID;