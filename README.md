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