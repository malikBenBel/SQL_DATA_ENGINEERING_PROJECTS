/*



*/

SELECT sd.skills, ROUND(MEDIAN( jpf.salary_year_avg),0) as median_sal , COUNT(jpf.*) AS demand_skills

FROM job_postings_fact AS jpf LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer'
GROUP BY sd.skills
HAVING demand_skills > 100
ORDER BY median_sal DESC
LIMIT 25;


