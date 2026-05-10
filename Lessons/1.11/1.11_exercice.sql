SELECT jpf.job_id, jpf.job_title , cd.name AS company_name, jpf.job_location, jpf.job_posted_date
FROM job_postings_fact AS jpf LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
WHERE jpf.job_title_short = 'Data Engineer'
ORDER BY jpf.job_posted_date DESC;


SELECT jpf.job_id, jpf.job_title , jpf.job_country, sd.skills
FROM job_postings_fact AS jpf LEFT JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_country = 'United States' AND jpf.job_health_insurance = TRUE
ORDER BY job_id DESC;

SELECT jpf.job_id, jpf.job_title , jpf.job_location, sjd.skill_id
FROM job_postings_fact AS jpf FULL JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
WHERE jpf.job_country = 'United States' 
ORDER BY job_id  ,  sjd.skill_id ;


SELECT jpf.job_title_short , sd.skills, sd.skills, COUNT(jpf.job_id)
FROM job_postings_fact AS jpf FULL JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short LIKE '%Data%'
GROUP BY jpf.job_title_short , sd.skills, sd.skills
ORDER BY COUNT(jpf.job_id);

SELECT 
    jpf.job_title_short,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM 
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.salary_year_avg > 100000
GROUP BY 
    jpf.job_title_short,
    sd.skills
ORDER BY 
    job_count DESC;
EXPLAIN ANALYZE
    SELECT
    sd.skill_id,
    sd.skills,
    COUNT(jpf.job_id) AS job_count
FROM
    skills_dim AS sd
    RIGHT JOIN skills_job_dim AS sjd
        ON sd.skill_id = sjd.skill_id
    RIGHT JOIN job_postings_fact AS jpf
        ON jpf.job_id = sjd.job_id
WHERE
    jpf.job_title_short LIKE '%Data%'
GROUP BY
    sd.skill_id,
    sd.skills
ORDER BY
    job_count DESC;


SELECT COUNT(job_id) 
FROM job_postings_fact
WHERE job_country = 'Algeria';


SELECT DISTINCT  job_country FROM job_postings_fact ORDER BY job_country;
