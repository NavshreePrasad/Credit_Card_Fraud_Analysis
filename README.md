# 💳 Credit Card Fraud Analytics Dashboard

An end-to-end **Credit Card Fraud Analysis** project that leverages **Python, SQL, and Power BI** to detect fraud patterns, identify high-risk merchants, authentication methods and customer behaviours, and turn raw transaction data into actionable fraud-prevention insights. The project transforms 20,000 transaction records into an interactive two-page dashboard that supports risk monitoring and decision-making.

---

# 📖 Short Description

The **Credit Card Fraud Analytics Dashboard** is an interactive Business Intelligence solution designed to help banks and payment teams understand *where*, *when* and *how* card fraud occurs, across merchant categories, card types, authentication methods, channels, devices, geography, customer demographics and behavioural signals.

Using **20,000 card transactions (339 flagged as fraud)**, the project measures fraud rates across segments, ranks merchants by risk, and highlights the behavioural red flags (CVV retries, velocity, IP/billing mismatches, AI-generated scam attempts) that most strongly separate fraudulent from genuine transactions. It combines **Python for data preparation and EDA, SQL for business analysis, and Power BI for visualization**, giving a complete analytics workflow.

---

# 🛠 Tech Stack

- 🐍 **Python** – Data cleaning, feature engineering, and exploratory data analysis
- 📊 **Pandas & NumPy** – Data manipulation, binning and group-wise fraud-rate calculations
- 📈 **Matplotlib & Seaborn** – Exploratory data visualization
- 🗄️ **MySQL** – Business queries and analytical reporting (database: `credit_card_fraud_analysis_db`, table: `fraud_analysis`)
- 📊 **Power BI Desktop** – Interactive dashboard development
- 🧠 **DAX (Data Analysis Expressions)** – Measures such as *Fraud Rate*, *Total Fraud Amount*, *Avg Fraud Transaction Amount*, plus *Merchant Risk Category* and *Velocity Category*
- 📝 **Jupyter Notebook** – Python development environment
- 📄 **Microsoft Word** – SQL query documentation
- 📁 **CSV Dataset** – Source data

---

# 📂 Data Source

**Dataset:** `credit_card_fraud_2026.csv`

The dataset consists of **20,000 transactions** with **26 attributes** covering transaction details, card and authentication data, device and channel information, customer profile, and behavioural/risk signals. There are **no missing values**, and `transaction_id` is unique for every record. Fraud is rare: **339 fraudulent transactions (1.70%)**, so this is a class-imbalanced dataset.

### Dataset includes:

- **Transaction:** Transaction ID, Amount (USD), Merchant Category, Time of Day (hour), Day of Week
- **Card & Authentication:** Card Type, Auth Method, CVV Retry Count, Card Age (months)
- **Channel & Device:** Channel, Device Type
- **Geography & Network:** Foreign Transaction, Distance from Home (km), VPN Used, IP-Country Mismatch, Billing/Shipping Mismatch
- **Customer:** Customer Age, Account Balance (USD), Prior Disputes
- **Behavioural / Risk Signals:** Hours Since Last Transaction, Transactions in Last 24h, Velocity Score, New Merchant flag, Merchant Risk Score, AI-Generated Scam Attempt flag
- **Target:** `is_fraud` (1 = fraud, 0 = legitimate)

### 🧩 Engineered features (Python)

| Feature | Logic |
|---|---|
| `age_group` | young, adult, middle-aged, old, senior (20-year bands) |
| `time_of_day` | Four 6-hour blocks of the day |
| `velocity_group` | Very Low → Very High (20-point bands of velocity score) |
| `transaction_size` | Low (< $1,000) vs High (≥ $1,000) |
| `day_name` | Day-of-week number mapped to Monday–Sunday |
| `remaining_balance` | Low / Medium / High account balance bands |
| `transaction_frequency` | Rare / Often / Very frequent (24-hour transaction count) |
| `distance_group` | Very near → Far (distance from home) |

---

# ✨ Features & Highlights

## 📌 Business Problem

Card fraud causes direct financial loss, chargebacks and customer distrust, yet fraudulent transactions are a tiny fraction of total volume and hard to spot. Risk teams needed to understand which merchants, channels, authentication methods and customer behaviours carry the highest fraud risk so they can tighten controls without adding friction to genuine customers.

---

## 🎯 Goal of the Dashboard

The dashboard was developed to:

- Measure overall fraud volume, value and fraud rate
- Identify high-risk merchant categories, card types, channels and devices
- Evaluate how authentication methods affect fraud
- Detect behavioural red flags (CVV retries, velocity, VPN, mismatches)
- Understand fraud timing by hour and day of week
- Compare foreign vs domestic and low- vs high-value transactions
- Support risk-based monitoring and manual-review rules

---

# 📊 Walkthrough of Key Visuals

## 🖥️ Page 1 – Executive Fraud Overview

### 🔹 KPI Cards

Headline metrics driven by DAX measures:

- 🧾 Total Transactions: **20,000**
- 🚨 Fraud Transactions: **339**
- 📉 Fraud Rate: **1.70%**
- 💰 Total Transaction Value: **$2.65M**
- 💸 Total Fraud Amount: **$61.4K**

---

### 🔹 Foreign vs Domestic Transactions

Donut chart showing fraud split between foreign and domestic transactions.

**Insight:** Foreign transactions make up only ~6% of all activity but account for roughly **21.5% of all fraud cases**, with a fraud rate of **5.89% vs 1.42%** for domestic.

---

### 🔹 Fraud by Merchant Category

Bar chart of fraud rate by merchant category, with tooltips for average fraud amount, merchant risk score and fraud count.

**Insight:** **Crypto Exchange (4.99%)**, **Gift Cards (4.38%)** and **Gaming (3.67%)** are the riskiest categories; Online Retail is the lowest (0.94%).

---

### 🔹 Fraud by Age Group

Area chart comparing fraud rate across customer age groups.

**Insight:** Fraud rate rises with age: the older and senior groups are the most exposed.

---

### 🔹 Interactive Filters

Users can dynamically filter visuals by:

- New Merchant
- AI-Generated Scam Attempt
- VPN Usage
- Card Type
- Transaction Size
- Authentication Method
- Channel
- Transaction Frequency
- Device Type

---

## 🖥️ Page 2 – Fraud Risk & Behavioral Analysis

### 🔹 Merchant Risk × Velocity Matrix

Matrix of fraud rate by **Merchant Risk Category** (rows) and **Velocity Category** (columns).

**Insight:** Transactions combining **high merchant risk and high velocity** show the highest fraud rates, making them strong candidates for manual review.

---

### 🔹 Hour × Day Fraud Heatmap

Matrix of fraud counts by hour of day and day of week.

**Insight:** Fraud peaks in the **early-morning hours (around 5 AM)** and on **Sundays**.

---

### 🔹 Key Insights & Recommendations Panel

A text panel summarising the main findings and recommended controls (see below).

---

# 🗄️ SQL Analysis

A set of **24 business questions** answered in MySQL (documented in `Credit_Card_Fraud_SQL_Queries_Doc.docx`):

| Area | Questions Covered |
|---|---|
| **Overview KPIs** | Total transactions, total fraud, fraud %, average and maximum transaction amount |
| **Segment fraud rates** | Merchant category, card type, authentication method, channel, device type, age group, day of week, time of day |
| **Merchant profiling** | Average amount and average risk score per merchant category |
| **Customer & geography** | Foreign vs domestic split, average account balance of fraud victims |
| **Transaction value** | High- vs low-value transaction counts |
| **Advanced SQL** | `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `NTILE(4)` risk quartiles, CTEs, `CASE` risk-level tagging (High / Medium / Low) |

---

# 🐍 Python Analysis (Jupyter Notebook)

The notebook walks through **metadata inspection → feature engineering → EDA** organised into seven analysis blocks:

1. **Customer** – age group, account balance, transaction frequency
2. **Transaction** – average fraud amount, high-value transactions, time of day, day of week
3. **Merchant** – fraud rate by category, highest-value merchants, new-merchant risk, risk-score correlation
4. **Authentication** – lowest-fraud method, CVV retry effect
5. **Device & Channel** – most-affected device and channel
6. **Geographic** – foreign transactions, VPN, IP-country mismatch, billing/shipping mismatch
7. **Behavioural** – velocity score, AI-generated scam attempts, prior disputes, distance from home

<img width="613" height="367" alt="image" src="https://github.com/user-attachments/assets/27dba8c5-513c-42c7-aa98-267170761c8a" />


# 📂 Project Structure

```text
Credit_Card_Fraud_Analysis/
│
├── README.md                                  # Project documentation
│
├── data/
│   └── credit_card_fraud_2026.csv             # Source dataset (20,000 rows x 26 columns)
│
├── notebooks/
│   └── Credit_Card_Fraud.ipynb                # Cleaning, feature engineering & EDA
│
├── sql/
│   ├── Fraud_analysis_SQL_script.sql          # 24 business queries (MySQL)
│   └── Credit_Card_Fraud_SQL_Queries_Doc.docx # Query documentation
│
└── powerbi/
    └── Credit_Card_Fraud_Dashboard.pbix       # 2-page interactive Power BI dashboard
```

---

# 📈 Key Insights

- 🚨 **Overall fraud rate is 1.70%** (339 of 20,000 transactions); the average fraud transaction is higher than a genuine one.
- 🪙 **Crypto Exchange (4.99%) and Gift Cards (4.38%)** are the highest-risk merchant categories.
- 🔓 **No authentication = 4.44% fraud**, versus **0.78% with biometrics**, the lowest of any method.
- 🔁 **CVV retries are a strong signal:** fraud is 0.92% with no retries but **16.14% at 2 retries** and 13.33% at 3.
- 🤖 **AI-generated scam attempts** show a 9.07% fraud rate versus 1.55% otherwise.
- 🌍 **IP-country mismatch (7.80%)** and **billing/shipping mismatch (7.79%)** are among the strongest red flags; **foreign transactions (5.89%)** and **VPN use (4.38%)** also raise risk.
- ⚡ **Velocity matters:** transactions in the high-velocity band show a ~10% fraud rate versus under 1% in the lowest band.
- 💵 **High-value transactions (≥ $1,000)** have more than double the fraud rate of low-value ones (3.72% vs 1.66%).
- 🆕 **New merchants** are riskier (3.50% vs 1.16%).
- ⏰ **Fraud is highest in the early-morning hours (peaking around 5 AM) and on Sundays (2.09%).**
- 👴 **Older and senior customers** experience the highest fraud rates.
- 📱 **Online is the most vulnerable channel (1.98%)**; differences between devices and card types are small (Amex highest at 2.01%).

---

# 💡 Business Impact & Recommendations

### ✅ Strengthen Authentication
Reduce "no authentication" transactions and promote biometric / 3D Secure verification.

### ✅ Monitor High-Risk Merchants
Apply enhanced monitoring to Crypto Exchange, Gift Card and Gaming merchants.

### ✅ Flag Behavioural Red Flags
Auto-flag transactions with multiple CVV retries, IP-country or billing/shipping mismatches, VPN use and AI-scam indicators.

### ✅ Risk-Based Manual Review
Route high merchant-risk + high-velocity transactions, and high-value foreign payments, to manual review.

### ✅ Time-Based Monitoring
Increase monitoring during peak fraud hours (early morning) and on Sundays.

### ✅ Protect Vulnerable Customers
Introduce additional alerts and education for older and senior customers.

---

# 🔮 Future Improvements

- Build a fraud-prediction model (logistic regression, random forest, XGBoost) with class-imbalance handling (SMOTE / class weights).
- Evaluate with precision, recall, F1 and ROC-AUC rather than accuracy.
- Create a rule-based risk-scoring engine from the strongest signals.
- Add time-series fraud trend analysis.
- Deploy the dashboard to Power BI Service with a live database connection.
