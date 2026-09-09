-- ============================================================
-- STUDYING ABROAD AND STUDENT WELL-BEING
-- SQL PORTFOLIO PROJECT
-- Database: MySQL
-- ============================================================

-- Project question:
-- Do international and domestic students differ in depression,
-- social connectedness, and acculturative stress?

-- Data note:
-- The imported dataset contains 286 rows.
-- Eighteen rows do not contain a valid international/domestic
-- student classification, leaving 268 records for analysis.


-- ============================================================
-- 1. PREVIEW THE DATA
-- ============================================================

SELECT *
FROM students
LIMIT 10;


-- ============================================================
-- 2. CHECK IMPORTED AND VALID RECORDS
-- ============================================================

SELECT
    COUNT(*) AS imported_rows,
    COUNT(inter_dom) AS valid_student_records,
    SUM(
        CASE
            WHEN inter_dom IS NULL THEN 1
            ELSE 0
        END
    ) AS blank_rows
FROM students;


-- ============================================================
-- 3. INTERNATIONAL VS DOMESTIC STUDENT COUNTS
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom
ORDER BY total_students DESC;


-- ============================================================
-- 4. PERCENTAGE OF STUDENTS IN EACH GROUP
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        1
    ) AS percentage_of_students
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom
ORDER BY total_students DESC;


-- ============================================================
-- 5. INTERNATIONAL STUDENTS BY REGION
-- ============================================================

SELECT
    region,
    COUNT(*) AS total_students
FROM students
WHERE inter_dom = 'Inter'
  AND region IS NOT NULL
GROUP BY region
ORDER BY total_students DESC;


-- ============================================================
-- 6. MAIN WELL-BEING SUMMARY
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom
ORDER BY student_type;


-- ============================================================
-- 7. COMPARE DEPRESSION SCORES
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    MIN(todep) AS minimum_depression_score,
    MAX(todep) AS maximum_depression_score
FROM students
WHERE inter_dom IS NOT NULL
  AND todep IS NOT NULL
GROUP BY inter_dom
ORDER BY avg_depression_score DESC;


-- ============================================================
-- 8. COMPARE SOCIAL CONNECTEDNESS
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    MIN(tosc) AS minimum_connectedness_score,
    MAX(tosc) AS maximum_connectedness_score
FROM students
WHERE inter_dom IS NOT NULL
  AND tosc IS NOT NULL
GROUP BY inter_dom
ORDER BY avg_social_connectedness DESC;


-- ============================================================
-- 9. COMPARE ACCULTURATIVE STRESS
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress,
    MIN(toas) AS minimum_stress_score,
    MAX(toas) AS maximum_stress_score
FROM students
WHERE inter_dom IS NOT NULL
  AND toas IS NOT NULL
GROUP BY inter_dom
ORDER BY avg_acculturative_stress DESC;


-- ============================================================
-- 10. WELL-BEING BY GENDER
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    gender,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom IS NOT NULL
  AND gender IS NOT NULL
GROUP BY inter_dom, gender
ORDER BY student_type, gender;


-- ============================================================
-- 11. WELL-BEING BY ACADEMIC LEVEL
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    academic,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom IS NOT NULL
  AND academic IS NOT NULL
GROUP BY inter_dom, academic
ORDER BY student_type, academic;


-- ============================================================
-- 12. INTERNATIONAL STUDENTS BY LENGTH-OF-STAY CATEGORY
-- ============================================================

SELECT
    stay_cate,
    COUNT(*) AS total_students,
    ROUND(AVG(stay), 2) AS avg_length_of_stay,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND stay_cate IS NOT NULL
GROUP BY stay_cate
ORDER BY FIELD(stay_cate, 'Short', 'Medium', 'Long');


-- ============================================================
-- 13. INTERNATIONAL STUDENTS BY INDIVIDUAL LENGTH OF STAY
-- ============================================================

SELECT
    stay AS years_of_stay,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND stay IS NOT NULL
GROUP BY stay
ORDER BY stay;


-- ============================================================
-- 14. JAPANESE LANGUAGE PROFICIENCY
-- ============================================================

SELECT
    japanese_cate AS japanese_proficiency,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND japanese_cate IS NOT NULL
GROUP BY japanese_cate
ORDER BY FIELD(japanese_cate, 'Low', 'Average', 'High');


-- ============================================================
-- 15. ENGLISH LANGUAGE PROFICIENCY
-- ============================================================

SELECT
    english_cate AS english_proficiency,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND english_cate IS NOT NULL
GROUP BY english_cate
ORDER BY FIELD(english_cate, 'Low', 'Average', 'High');


-- ============================================================
-- 16. INTERNATIONAL STUDENTS BY REGION
-- ============================================================

SELECT
    region,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND region IS NOT NULL
GROUP BY region
ORDER BY avg_depression_score DESC;


-- ============================================================
-- 17. REGIONAL RESULTS WITH ADEQUATE SAMPLE SIZE
-- ============================================================

SELECT
    region,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
  AND region IS NOT NULL
GROUP BY region
HAVING COUNT(*) >= 10
ORDER BY avg_depression_score DESC;


-- ============================================================
-- 18. DEPRESSION-SEVERITY DISTRIBUTION
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    depsev AS depression_severity,
    COUNT(*) AS total_students
FROM students
WHERE inter_dom IS NOT NULL
  AND depsev IN ('Min', 'Mild', 'Mod', 'ModSev', 'Sev')
GROUP BY inter_dom, depsev
ORDER BY
    student_type,
    FIELD(depsev, 'Min', 'Mild', 'Mod', 'ModSev', 'Sev');


-- ============================================================
-- 19. PERCENTAGE DISTRIBUTION OF DEPRESSION SEVERITY
-- Demonstrates CTE + window function
-- ============================================================

WITH severity_counts AS (
    SELECT
        inter_dom,
        depsev,
        COUNT(*) AS severity_total
    FROM students
    WHERE inter_dom IS NOT NULL
      AND depsev IN ('Min', 'Mild', 'Mod', 'ModSev', 'Sev')
    GROUP BY inter_dom, depsev
)

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    depsev AS depression_severity,
    severity_total,
    ROUND(
        100.0 * severity_total /
        SUM(severity_total) OVER (PARTITION BY inter_dom),
        1
    ) AS percentage_within_student_type
FROM severity_counts
ORDER BY
    student_type,
    FIELD(depsev, 'Min', 'Mild', 'Mod', 'ModSev', 'Sev');


-- ============================================================
-- 20. STUDENTS ABOVE OVERALL AVERAGE DEPRESSION SCORE
-- Demonstrates CTE + CROSS JOIN
-- ============================================================

WITH overall_average AS (
    SELECT
        AVG(todep) AS avg_depression
    FROM students
    WHERE inter_dom IS NOT NULL
      AND todep IS NOT NULL
)

SELECT
    CASE
        WHEN s.inter_dom = 'Inter' THEN 'International'
        WHEN s.inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    s.region,
    s.gender,
    s.academic,
    s.todep AS depression_score,
    ROUND(o.avg_depression, 2) AS overall_avg_depression
FROM students AS s
CROSS JOIN overall_average AS o
WHERE s.inter_dom IS NOT NULL
  AND s.todep > o.avg_depression
ORDER BY s.todep DESC;


-- ============================================================
-- 21. COUNT STUDENTS ABOVE OVERALL AVERAGE
-- ============================================================

WITH overall_average AS (
    SELECT
        AVG(todep) AS avg_depression
    FROM students
    WHERE inter_dom IS NOT NULL
      AND todep IS NOT NULL
)

SELECT
    CASE
        WHEN s.inter_dom = 'Inter' THEN 'International'
        WHEN s.inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS students_above_overall_average
FROM students AS s
CROSS JOIN overall_average AS o
WHERE s.inter_dom IS NOT NULL
  AND s.todep > o.avg_depression
GROUP BY s.inter_dom
ORDER BY students_above_overall_average DESC;


-- ============================================================
-- 22. COMPARE EACH STUDENT WITH THEIR GROUP AVERAGE
-- Demonstrates window functions
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    region,
    gender,
    academic,
    todep AS depression_score,
    ROUND(
        AVG(todep) OVER (PARTITION BY inter_dom),
        2
    ) AS student_type_avg_depression,
    ROUND(
        todep - AVG(todep) OVER (PARTITION BY inter_dom),
        2
    ) AS difference_from_group_average
FROM students
WHERE inter_dom IS NOT NULL
  AND todep IS NOT NULL
ORDER BY
    student_type,
    difference_from_group_average DESC;


-- ============================================================
-- 23. RANK REGIONS BY AVERAGE DEPRESSION
-- Demonstrates CTE + DENSE_RANK
-- ============================================================

WITH regional_summary AS (
    SELECT
        region,
        COUNT(*) AS total_students,
        AVG(todep) AS avg_depression
    FROM students
    WHERE inter_dom = 'Inter'
      AND region IS NOT NULL
    GROUP BY region
)

SELECT
    region,
    total_students,
    ROUND(avg_depression, 2) AS avg_depression_score,
    DENSE_RANK() OVER (
        ORDER BY avg_depression DESC
    ) AS depression_rank
FROM regional_summary
ORDER BY depression_rank;


-- ============================================================
-- 24. RANK LANGUAGE-PROFICIENCY GROUPS
-- ============================================================

WITH language_summary AS (
    SELECT
        japanese_cate,
        COUNT(*) AS total_students,
        AVG(todep) AS avg_depression,
        AVG(tosc) AS avg_social_connectedness
    FROM students
    WHERE inter_dom = 'Inter'
      AND japanese_cate IS NOT NULL
    GROUP BY japanese_cate
)

SELECT
    japanese_cate AS japanese_proficiency,
    total_students,
    ROUND(avg_depression, 2) AS avg_depression_score,
    ROUND(
        avg_social_connectedness,
        2
    ) AS avg_social_connectedness,
    DENSE_RANK() OVER (
        ORDER BY avg_depression
    ) AS lowest_depression_rank
FROM language_summary
ORDER BY lowest_depression_rank;


-- ============================================================
-- 25. COMPARE SOCIAL-SUPPORT SOURCES
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,

    ROUND(
        100 * AVG(
            CASE
                WHEN partner_bi = 'Yes' THEN 1
                ELSE 0
            END
        ),
        1
    ) AS pct_with_partner_support,

    ROUND(
        100 * AVG(
            CASE
                WHEN friends_bi = 'Yes' THEN 1
                ELSE 0
            END
        ),
        1
    ) AS pct_with_friend_support,

    ROUND(
        100 * AVG(
            CASE
                WHEN parents_bi = 'Yes' THEN 1
                ELSE 0
            END
        ),
        1
    ) AS pct_with_parent_support,

    ROUND(
        100 * AVG(
            CASE
                WHEN professional_bi = 'Yes' THEN 1
                ELSE 0
            END
        ),
        1
    ) AS pct_with_professional_support

FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom;


-- ============================================================
-- 26. DEPRESSION BY FRIEND SUPPORT
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    friends_bi AS friend_support,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness
FROM students
WHERE inter_dom IS NOT NULL
  AND friends_bi IS NOT NULL
GROUP BY inter_dom, friends_bi
ORDER BY student_type, friend_support;


-- ============================================================
-- 27. DEPRESSION BY PARTNER SUPPORT
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    partner_bi AS partner_support,
    COUNT(*) AS total_students,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness
FROM students
WHERE inter_dom IS NOT NULL
  AND partner_bi IS NOT NULL
GROUP BY inter_dom, partner_bi
ORDER BY student_type, partner_support;


-- ============================================================
-- 28. CREATE A SIMPLIFIED DEPRESSION CATEGORY
-- Demonstrates CASE expressions
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,

    CASE
        WHEN todep <= 4 THEN 'Minimal'
        WHEN todep BETWEEN 5 AND 9 THEN 'Mild'
        WHEN todep BETWEEN 10 AND 14 THEN 'Moderate'
        WHEN todep BETWEEN 15 AND 19 THEN 'Moderately Severe'
        WHEN todep >= 20 THEN 'Severe'
        ELSE 'Missing'
    END AS depression_category,

    COUNT(*) AS total_students

FROM students
WHERE inter_dom IS NOT NULL
  AND todep IS NOT NULL
GROUP BY
    inter_dom,
    CASE
        WHEN todep <= 4 THEN 'Minimal'
        WHEN todep BETWEEN 5 AND 9 THEN 'Mild'
        WHEN todep BETWEEN 10 AND 14 THEN 'Moderate'
        WHEN todep BETWEEN 15 AND 19 THEN 'Moderately Severe'
        WHEN todep >= 20 THEN 'Severe'
        ELSE 'Missing'
    END
ORDER BY
    student_type,
    FIELD(
        depression_category,
        'Minimal',
        'Mild',
        'Moderate',
        'Moderately Severe',
        'Severe'
    );


-- ============================================================
-- 29. HIGHEST DEPRESSION SCORES
-- Demonstrates ranking window function
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    region,
    gender,
    academic,
    todep AS depression_score,
    tosc AS social_connectedness,
    toas AS acculturative_stress,
    DENSE_RANK() OVER (
        ORDER BY todep DESC
    ) AS depression_rank
FROM students
WHERE inter_dom IS NOT NULL
  AND todep IS NOT NULL
ORDER BY depression_rank
LIMIT 10;


-- ============================================================
-- 30. FINAL SUMMARY TABLE
-- ============================================================

SELECT
    CASE
        WHEN inter_dom = 'Inter' THEN 'International'
        WHEN inter_dom = 'Dom' THEN 'Domestic'
        ELSE 'Unknown'
    END AS student_type,
    COUNT(*) AS total_students,
    ROUND(AVG(age), 2) AS avg_age,
    ROUND(AVG(stay), 2) AS avg_length_of_stay,
    ROUND(AVG(todep), 2) AS avg_depression_score,
    ROUND(AVG(tosc), 2) AS avg_social_connectedness,
    ROUND(AVG(toas), 2) AS avg_acculturative_stress
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom
ORDER BY student_type;
