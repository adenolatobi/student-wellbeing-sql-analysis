# Studying Abroad and Student Well-Being: An End-to-End SQL Analysis

## Overview

This project uses **MySQL** to explore differences in student well-being between international and domestic students.

The analysis focuses on depression, social connectedness, acculturative stress, language proficiency, academic level, social support, region, and length of stay. It also demonstrates a range of SQL techniques, including aggregations, `CASE` expressions, common table expressions, window functions, ranking functions, and subgroup comparisons.

## Project Questions

This analysis addresses questions such as:

1. Do international and domestic students differ in average depression, social connectedness, and acculturative stress?
2. How do well-being outcomes vary by gender and academic level?
3. Does length of stay relate to student well-being?
4. How do Japanese and English language proficiency relate to well-being among international students?
5. Which regions show higher average depression scores?
6. How do different forms of social support relate to depression and connectedness?

## Tools

- **MySQL**
- Aggregations
- `CASE` expressions
- Common Table Expressions (CTEs)
- Window functions
- Ranking functions
- Filtering and grouping
- Subgroup analysis

## Data

The dataset contains **286 imported student records**.

Eighteen records do not contain a valid international/domestic classification, leaving **268 students** for the main comparisons.

The dataset includes demographic, academic, language, social-support, and well-being variables.

Key measures include:

- `todep` — depression score
- `tosc` — social connectedness score
- `toas` — acculturative stress score

The full dataset is available in:

```text
data/students.csv
```

Additional variable information is documented in [`data/README.md`](data/README.md).

## Analysis Workflow

### 1. Data Validation

The analysis begins by checking the imported row count, identifying missing international/domestic classifications, and confirming the number of valid student records.

### 2. International vs Domestic Student Comparison

Average depression, social connectedness, and acculturative stress are compared between international and domestic students.

### 3. Demographic and Academic Comparisons

The analysis examines differences by:

- gender
- academic level
- region
- length of stay

### 4. Language Proficiency

Among international students, well-being measures are compared across:

- Japanese language proficiency
- English language proficiency

### 5. Depression Severity

Students are grouped by depression-severity categories to compare both counts and within-group percentages.

### 6. Social Support

The analysis evaluates several forms of support, including:

- partner support
- friend support
- parent support
- professional support

These variables are then compared with depression and social-connectedness outcomes.

### 7. Advanced SQL Analysis

The project also uses:

- CTEs
- window functions
- `DENSE_RANK()`
- group-level averages
- differences from group averages
- percentage calculations within categories

These techniques make it possible to move beyond simple descriptive queries and perform more structured comparisons.

## SQL Techniques Demonstrated

Examples of techniques used in the project include:

```sql
CASE
    WHEN inter_dom = 'Inter' THEN 'International'
    WHEN inter_dom = 'Dom' THEN 'Domestic'
END
```

```sql
AVG(todep) OVER (PARTITION BY inter_dom)
```

```sql
DENSE_RANK() OVER (
    ORDER BY avg_depression DESC
)
```

```sql
WITH regional_summary AS (
    SELECT
        region,
        COUNT(*) AS total_students,
        AVG(todep) AS avg_depression
    FROM students
    WHERE inter_dom = 'Inter'
    GROUP BY region
)
```

## Key Analytical Themes

The project emphasizes several recurring themes:

- comparing international and domestic student well-being
- identifying subgroup differences
- examining possible relationships between language proficiency and adjustment
- exploring the role of social support
- evaluating length-of-stay patterns
- using SQL to create interpretable analytical summaries

The analysis is descriptive and exploratory. Group differences should not be interpreted as causal effects.

## Repository Structure

```text
student-wellbeing-sql-analysis/
├── data/
│   ├── README.md
│   └── students.csv
├── sql/
│   ├── README.md
│   └── student_wellbeing_analysis.sql
├── LICENSE
└── README.md
```

## Reproducing the Analysis

1. Create a MySQL database.
2. Import `data/students.csv` into a table named:

```text
students
```

3. Open:

```text
sql/student_wellbeing_analysis.sql
```

4. Run the queries in MySQL Workbench or another MySQL-compatible environment.

The SQL script is organized into sections so that each stage of the analysis can be run and reviewed independently.

## Portfolio Article

A detailed write-up of this project is available on my portfolio:

https://tobiadenola.com/studying-abroad-and-student-well-being-an-end-to-end-sql-analysis/

## Author

**Oluwatobiloba Adenola**

Portfolio: https://tobiadenola.com/
