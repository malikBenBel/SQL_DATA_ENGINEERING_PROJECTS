/*

1er le bonne requete

*/

SELECT sd.skills, ROUND(MEDIAN( jpf.salary_year_avg),0) as median_sal , COUNT(jpf.*) AS demand_skills,
       ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
       ROUND((MEDIAN( jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1000000,2) AS opti_score
FROM job_postings_fact AS jpf LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer' AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING demand_skills > 100
ORDER BY opti_score DESC
LIMIT 25;




SELECT sd.skills, ROUND(MEDIAN( jpf.salary_year_avg),0) as median_sal , COUNT(jpf.*) AS demand_skills,
        RANK() OVER (ORDER BY (median_sal * demand_skills) DESC) as rank_score
FROM job_postings_fact AS jpf LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer' AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING demand_skills > 100
ORDER BY rank_score ASC
LIMIT 25;



WITH skill_stats AS (
    SELECT 
        sd.skills, 
        ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_sal, 
        COUNT(jpf.job_id) AS demand_skills
    FROM job_postings_fact AS jpf 
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id 
    LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE jpf.job_work_from_home = TRUE 
      AND jpf.job_title_short = 'Data Engineer'
      AND jpf.salary_year_avg IS NOT NULL -- On évite les valeurs vides
    GROUP BY sd.skills
    HAVING COUNT(jpf.job_id) > 100
)
SELECT 
    skills,
    median_sal,
    demand_skills,
    -- On crée le rang combiné
    RANK() OVER (ORDER BY (median_sal * demand_skills) DESC) as rank_score
FROM skill_stats
ORDER BY rank_score ASC
LIMIT 25;


WITH stats AS (
    SELECT 
        sd.skills, 
        MEDIAN(jpf.salary_year_avg) AS median_sal, 
        COUNT(jpf.job_id) AS demand_skills
    FROM job_postings_fact AS jpf 
    LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id 
    LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
    WHERE jpf.job_work_from_home = TRUE 
      AND jpf.job_title_short = 'Data Engineer'
    GROUP BY sd.skills
    HAVING COUNT(jpf.job_id) > 100
),
normalized AS (
    SELECT *,
        -- Normalisation du salaire (0 à 1)
        (median_sal - MIN(median_sal) OVER()) / (MAX(median_sal) OVER() - MIN(median_sal) OVER()) AS n_sal,
        -- Normalisation de la demande (0 à 1)
        (CAST(demand_skills AS FLOAT) - MIN(demand_skills) OVER()) / (MAX(demand_skills) OVER() - MIN(demand_skills) OVER()) AS n_dem
    FROM stats
)
SELECT 
    skills,
    ROUND(median_sal, 0) AS median_sal,
    demand_skills,
    -- Application de la pondération : 70% Salaire + 30% Demande
    ROUND((n_sal * 0.1) + (n_dem * 0.9), 4) AS opportunity_score
FROM normalized
ORDER BY opportunity_score DESC
LIMIT 25;
