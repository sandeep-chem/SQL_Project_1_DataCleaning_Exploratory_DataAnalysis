# SQL Project 1: Data Cleaning & Exploratory Data Analysis (EDA)

## 📌 Project Overview

This project focuses on cleaning and analyzing a real-world dataset of global tech layoffs from 2020 to 2023. Using SQL, I applied data cleaning techniques and performed exploratory data analysis to uncover patterns and trends in layoffs across companies, industries, and countries.

---

## 🗂️ Dataset

- **Source**: [layoffs.csv](https://github.com/sandeep-chem/SQL_Project_1_DataCleaning_Exploratory_DataAnalysis/blob/main/layoffs.csv)
- **Fields**: company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
- **Size**: ~2300 rows

---

## 🧹 Data Cleaning Steps

Performed in SQL to prepare the data for analysis:

1. Removed duplicates
2. Standardized inconsistent values (e.g., company names, industry labels)
3. Handled missing values (nulls)
4. Converted date formats and cleaned numerical fields
5. Created a staging table to avoid modifying raw data

> ✅ Scripts: [`DataCleaning.sql`](https://github.com/sandeep-chem/SQL_Project_1_DataCleaning_Exploratory_DataAnalysis/blob/main/Queries/DataCleaning.sql)

---

## 📊 Exploratory Data Analysis (EDA)

Analyzed key trends in layoffs using aggregate queries:

- Total layoffs by year and month
- Companies with highest layoffs
- Country-wise layoff distribution
- Industry and stage-based trends

> 📸 Output screenshots available in the [`Results`](https://github.com/sandeep-chem/SQL_Project_1_DataCleaning_Exploratory_DataAnalysis/tree/main/Results) folder  
> ✅ Queries: [`EDA.sql`](https://github.com/sandeep-chem/SQL_Project_1_DataCleaning_Exploratory_DataAnalysis/blob/main/Queries/EDA.sql)

---

## 🛠️ Tools Used

- **Database**: MySQL
- **IDE**: MySQL Workbench
- **Language**: SQL

---

## 💡 Key Insights

- Layoffs peaked in 2022 and early 2023
- U.S.-based tech companies had the most layoffs
- Startups in growth or post-IPO stages were highly affected
- A few large firms accounted for a majority of total layoffs

---

## 🔍 SQL Concepts Used

- Joins
- Window functions
- Aggregations (`GROUP BY`, `SUM`, `COUNT`)
- String manipulation (`LOWER`, `TRIM`)
- Conditional filtering (`WHERE`, `CASE`)
- Handling `NULL`s

---

## 📁 Repository Structure


SQL_Project_1/
│
├── Data/
│ └── layoffs.csv
│
├── Queries/
│ ├── DataCleaning.sql
│ └── EDA.sql
│
├── Results/
│ └── Screenshots of output tables


---

## ✍️ Author

**Sandeep Dash**  
Aspiring Data Analyst | SQL Learner  
[GitHub](https://github.com/sandeep-chem)

---

## 📬 Feedback

If you have suggestions or questions, feel free to open an issue or connect!
