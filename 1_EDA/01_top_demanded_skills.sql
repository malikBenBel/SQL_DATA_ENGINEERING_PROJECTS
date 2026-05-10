/*



*/
SELECT sd.skills,COUNT(jpf.*) AS demand_skills

FROM job_postings_fact AS jpf LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer'
GROUP BY sd.skills
--HAVING
ORDER BY demand_skills DESC
LIMIT 10; 



