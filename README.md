# 电商 SQL 与统计分析项目

## 项目概述

本项目基于 UCI 公开电商交易数据集，完成了一套完整的端到端数据分析流程，涵盖：

- MySQL 数据建模与 SQL 分析
- Python 数据探索（EDA）
- 统计假设检验
- 多元线性回归归因分析
- RFM 客户价值分层
- 收入集中度分析

项目从数据清洗 → 业务分析 → 统计推断 → 归因建模，构建完整分析闭环。

---

## 技术栈

- MySQL 8.0
- DataGrip
- Python 3.9
- Pandas
- NumPy
- Statsmodels
- Matplotlib

---

## 核心分析内容

### 收入与趋势分析

- 总销售额：£10.6M
- 平均客单价（AOV）：£534
- 明显 Q4 季节性爆发
- 业务呈现批发型（B2B）特征

---

### 客户集中度分析

- 前 10 名客户贡献 30% 收入
- 最大单一客户贡献 16% 收入
- 存在一定大客户依赖风险，但整体结构可控

---

### RFM 客户分层

- 22% 高价值客户
- 贡献 54% 收入
- 客户价值呈明显分层结构

---

### 统计假设检验

研究问题：

> 高频客户的订单金额是否显著高于低频客户？

检验结果：

- p < 0.001（统计显著）
- Cohen's d = 0.11（效应量较小）

结论：

虽然高频客户单笔订单金额显著更高，但实际差异较小，客户价值主要由“购买频次”驱动，而非单笔金额。

---

### 回归归因分析

模型：

log(Order Value) ~ frequency + product_count + recency

主要发现：

- 商品种类（product_count）是订单金额最强驱动因素
- 最近活跃客户订单金额更高
- 控制其他变量后，频次对单笔金额影响较小
- R² = 0.17

说明订单金额受多因素影响，商品多样性是核心驱动变量。

---

## 商业洞察

- 该业务呈现 B2B 特征（高 AOV、高复购）
- 收入存在一定集中度，但风险可控
- 客户价值主要来源于复购频率
- 提升商品组合丰富度有助于提高订单金额
- 应重点维护高价值客户并激活中层客户

---

## 项目复现方式

1. 从 UCI 官网下载原始数据
2. 使用 `/sql` 目录中的 SQL 脚本构建数据库
3. 依次运行 `/notebook` 中的分析文件

注：原始数据文件未包含在仓库中。

---

## 后续优化方向

- 加入季节性虚拟变量
- 构建随机森林模型进行非线性归因
- 进行因果推断分析
- 构建客户生命周期价值预测模型

---

## 数据来源

D. Chen, "Online Retail," UCI Machine Learning Repository, 2015.  
[Online]. Available: https://doi.org/10.24432/C5BW33



# E-commerce SQL & Statistical Analysis Project

## Project Overview

This project performs a full end-to-end data analysis on an e-commerce transaction dataset using:

- MySQL (data modeling & SQL analytics)
- Python (EDA, hypothesis testing, regression analysis)
- Statistical inference
- RFM customer segmentation
- Revenue concentration analysis

---

## Tech Stack

- MySQL 8.0
- DataGrip
- Python 3.9
- Pandas
- NumPy
- Statsmodels
- Matplotlib

---

## Key Analysis

### 1. Revenue Analysis
- Total Revenue: £10.6M
- Average Order Value: £534
- Strong Q4 seasonality

### 2. Customer Concentration
- Top 10 customers: 30% revenue
- Top 1 customer: 16% revenue

### 3. RFM Segmentation
- 22% high-value customers
- Contribute 54% of revenue

### 4. Hypothesis Testing
- High-frequency customers have statistically higher order value
- p < 0.001
- Effect size small (Cohen's d = 0.11)

### 5. Regression Attribution
log(Order Value) ~ frequency + product_count + recency

- Product count is strongest driver
- Recency negatively correlated
- Frequency slightly negative when controlling other factors
- R² = 0.17

---

## Business Insights

- Business is B2B-like with high AOV
- Revenue concentrated but not extreme
- Customer value driven more by purchase frequency than per-order amount
- Product diversity significantly impacts order value

---

## Future Improvements

- Add seasonality dummy variables
- Try Random Forest model
- Perform causal inference

## Data Source

D. Chen, "Online Retail," UCI Machine Learning Repository, 2015.  
[Online]. Available: https://doi.org/10.24432/C5BW33