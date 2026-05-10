

SELECT
    jpf.job_id,jpf.job_title_short,jpf.job_location, cd.name as compagny_name
FROM    
    job_postings_fact AS jpf LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
LIMIT 10;    

SELECT COUNT(*)
FROM job_postings_fact;


SELECT
    jpf.job_id,jpf.job_title_short,jpf.job_location, cd.company_id,cd.name as compagny_name
FROM    
    job_postings_fact AS jpf RIGHT JOIN company_dim AS cd ON jpf.company_id = cd.company_id;
  



SELECT
    jpf.job_id,jpf.job_title_short,jpf.job_location, cd.company_id,cd.name as compagny_name
FROM    
    job_postings_fact AS jpf INNER JOIN company_dim AS cd ON jpf.company_id = cd.company_id;
  


SELECT
    jpf.job_id,jpf.job_title_short,jpf.job_location, cd.company_id,cd.name as compagny_name
FROM    
    job_postings_fact AS jpf FULL OUTER JOIN company_dim AS cd ON jpf.company_id = cd.company_id;
  


SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT jpf.job_id, jpf.job_title_short,sd.skill_id,sdd.skills
FROM job_postings_fact AS jpf 
LEFT JOIN skills_job_dim AS sd 
ON jpf.job_id = sd.job_id
LEFT JOIN skills_dim AS sdd 
ON sdd.skill_id = sd.skill_id;


SELECT jpf.job_id, jpf.job_title_short,sd.skill_id,sdd.skills
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim AS sd 
ON jpf.job_id = sd.job_id
INNER JOIN skills_dim AS sdd 
ON sdd.skill_id = sd.skill_id;



SELECT jpf.job_id, jpf.job_title_short,sd.skill_id,sdd.skills
FROM job_postings_fact AS jpf 
FULL JOIN skills_job_dim AS sd 
ON jpf.job_id = sd.job_id
FULL JOIN skills_dim AS sdd 
ON sdd.skill_id = sd.skill_id;
