# Syntecxhub_Website_Traffic_Analytics_Project
A website traffic analytics system designed to track, process, and visualize user engagement and traffic data.
# 📊 Website Traffic & Engagement Analytics

An end-to-end Data Analytics project analyzing website traffic trends, user engagement, and acquisition channel performance. This project demonstrates data ingestion using **Python**, ETL and Exploratory Data Analysis (EDA) in **MySQL**, and interactive visualization via **Power BI**.

---

## 🛠️ Tech Stack & Tools
* **Language:** Python (Pandas)
* **Database Management:** MySQL Workbench
* **Business Intelligence:** Power BI Desktop
* **Version Control:** Git & GitHub

---

## 📌 Project Architecture & Workflow
### 1. Data Ingestion & Preprocessing (Python)
* Ingested the raw multi-header website traffic CSV file using `pandas`.
* Handled top-level header misalignments and exported structured tables directly into MySQL database (`website_traffic_db`).

### 2. Data Cleaning & Feature Engineering (MySQL)
* **Data Inspection:** Verified schema, initial records, and column data types using `DESCRIBE`.
* **Null Value Handling:** Checked for missing values across key performance indicators (KPIs) like `users`, `sessions`, and `engagement_rate`.
* **Column Normalization:** Trimmed leading/trailing whitespaces and renamed complex string column names into clean, standardized SQL headers (`session_primary_channel`, `date_hour`).
* **Feature Extraction:** Transformed string timestamp values (`YYYYMMDDHH`) to extract core temporal features:
  * `formatted_date` (DATE)
  * `hour_of_day` (INT)
  * `day_name` (VARCHAR)

### 3. Exploratory Data Analysis (MySQL Insights)
Executed SQL queries to derive core business insights:
* **High-Level Aggregations:** Calculated overall traffic metrics including total users, total sessions, engaged sessions, and average engagement rates.
* **Channel Performance:** Identified primary acquisition drivers by grouping metrics across channel categories.
* **Temporal Patterns:** Identified top peak hours for user visits and day-of-week trends.
* **Advanced Window Functions:** Leveraged CTEs and `DENSE_RANK()` to isolate top-performing traffic hours per channel category.

### 4. Interactive Data Visualization (Power BI)
Built an executive dashboard focusing on clarity and actionability:
* **KPI Cards:** Overview of Total Users, Sessions, Engaged Sessions, and Overall Engagement Rate.
* **Hourly Trend Analysis (Line Chart):** Visualized peak activity hours to inform marketing schedule optimization.
* **Channel Performance (Donut Chart):** Displayed share of users acquired per acquisition channel.
* **Engagement Metrics by Channel (Clustered Bar Chart):** Analyzed traffic quality vs. traffic volume across acquisition sources.
* **Day-of-Week Breakdown (Matrix/Table):** Tracked daily engagement fluctuations to pinpoint high-converting days.

---

## 📊 Key Business Insights

1. **Peak Engagement Hours:** Traffic peaks during specific hours of the day, indicating optimal times for launching promotional campaigns or content drops.
2. **Channel Quality vs. Quantity:** While direct traffic drives volume, organic social channels yield higher engagement time per session.
3. **Day-of-Week Variation:** Mid-week days show higher engagement rates compared to weekends.

---
## 📁 Repository Structure

├── raw_data.csv                  # Original website traffic raw dataset
├── clean_data.csv                # Processed dataset exported from MySQL
├── load_data.py                  # Python script for database ingestion
├── website_traffic_analysis.sql  # Complete SQL script (Cleaning, Transformation, & EDA)
├── dashboard.pbix                # Power BI Desktop report file
└── README.md                     # Project documentation


---

## 🚀 How to Run This Project

1. **Database Setup:**
   * Run `load_data.py` to push raw data into your local MySQL instance (`website_traffic_db`).
2. **Execute SQL Transformations:**
   * Open `website_traffic_analysis.sql` in MySQL Workbench and run the script sequentially to clean data and create engineered columns.
3. **View Dashboard:**
   * Open `dashboard.pbix` in Power BI Desktop to interact with the visualizations.
