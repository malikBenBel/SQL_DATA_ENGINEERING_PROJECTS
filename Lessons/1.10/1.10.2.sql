SELECT *
FROM information_schema.tables
WHERE table_name like '%dim%';


SELECT table_name, constraint_name,count(constraint_name) as constraint_name_count
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs'
GROUP BY  table_name,constraint_name
HAVING count(constraint_name) > 1 ;


SELECT *
FROM information_schema.tables
WHERE table_name = 'job_postings_fact';
