

--1. Retrieve all job titles and salaries for employees working in the US.
select job_title,salary_in_usd from ds_salaries 
where employee_residence = 'US';


--2. Find the number of employees working in each company size category (S, M, L).
select company_size,count(*) as employee_count from ds_salaries 
group by company_size;


--3.Get the distinct experience levels in the dataset.
select distinct experience_level from ds_salaries;

--4. List all salaries along with their currency for employees residing in Germany (DE).
select salary,salary_currency from ds_salaries 
where employee_residence = 'DE';

--5. Calculate the average salary in USD for each job title.
select job_title,avg(salary_in_usd) as average_salary from ds_salaries 
group by job_title;

--6.  Find the highest and lowest salaries for each employment type.
select employment_type,max(salary_in_usd) as max_salary,
min(salary_in_usd) as min_salary from ds_salaries 
group by employment_type;
 

--7. Get the total number of employees for each experience level.
select experience_level,count(*) as total_employees from ds_salaries 
group by experience_level;


--8. Find the average salary for remote employees (remote_ratio = 100).
select avg(salary_in_usd) as avg_remote_salary from ds_salaries 
where remote_ratio = 100;


--9.  List the top 5 highest-paying job titles in 2022.
select top 5 job_title,salary_in_usd from ds_salaries 
where work_year = 2022
order by salary_in_usd desc;

--10. Find the total salary paid to employees working in each country.
select employee_residence, sum(salary_in_usd) as total_salary 
from ds_salaries 
group by employee_residence;

--11.Show the count of employees grouped by company location and employment type.
select company_location,employment_type,count(*) as employee_count 
from ds_salaries 
group by company_location,employment_type;

--12. Identify the most common job title in the dataset.
select top 1 job_title,count(*) as job_count from ds_salaries 
group by job_title 
order by job_count desc;

-- 13. Find the top 3 highest-paying jobs for each experience level.

with cte_ranked_jobs as(
    select experience_level, job_title, salary_in_usd, 
    row_number() over (partition by experience_level order by salary_in_usd desc) as rank 
    from ds_salaries)
select experience_level, job_title, salary_in_usd 
from cte_ranked_jobs 
where rank <= 3;


--14. Rank employees by salary within each job title.

select job_title,employee_residence,salary_in_usd, 
rank() over (partition by job_title order by salary_in_usd desc) as salary_rank 
from ds_salaries;

--15. Find the percentage of employees working fully remotely (remote_ratio = 100).
select (count(case when remote_ratio=100 then 1 end)*100.0 /count(*)) as remote_percentage 
from ds_salaries;

/* 16. Compare the average salary of employees 
working onsite (remote_ratio = 0) vs. hybrid (remote_ratio = 50) vs. fully remote (remote_ratio = 100). */

select remote_ratio, avg(salary_in_usd) as avg_salary 
from ds_salaries 
group by remote_ratio;
