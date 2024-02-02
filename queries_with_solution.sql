-- Query 01 :  Write a query to show  all employees first_name,last_name,salary,expertise ordered by salary (highest salary first). 
-- The report will include the position of each employee in the ranking.

-- Solution:--
select first_name,last_name,expertise,salary,
dense_rank() over(order by salary desc) as ranking
from employee
order by ranking;

-- Query 02 : Write a sql query to find the top 5 salary in the company and the order criteria will again be salary DESC:

-- Solution : --
with cte as(
select first_name,last_name,expertise,salary,
dense_rank() over(order by salary desc) as rnk
from employee)
select *
from cte
where rnk <= 5
order by rnk;

-- Query 03 :-- Write a sql query to find the last top 5 salary in the company and the order criteria will again be salary DESC:
with cte as(
select first_name,last_name,expertise,salary,
dense_rank() over(order by salary) as rnk
from employee)
select *
from cte
where rnk <= 5
order by rnk;

-- Query 04 : -- Write a query to find the secon highest salary of the employee  from company.
with cte as(
select first_name,last_name,expertise,salary,
dense_rank() over(order by salary desc) as rnk
from employee)
select *
from cte
where rnk = 2
order by rnk;

-- Query 05 -- Let’s add a variation to the previous SQL query. 
-- Write a sql query to find the second highest salary in each department.
 
 -- Solution
 
 with cte as(
select first_name,last_name,expertise,dept_id,salary,
dense_rank() over(partition by dept_id order by salary desc) as rnk
from employee)
select *
from cte
where rnk = 2
order by rnk;

-- Query 06 -- write a query to fetch the first 50% data of employee table.

WITH employee_ranking AS (
  SELECT
    employee_id,
    last_name,
    first_name,
    salary,
    NTILE(2) OVER (ORDER BY salary ) as nti
  FROM employee
)
SELECT
  employee_id,
  last_name,
  first_name,
  salary
FROM employee_ranking
WHERE nti = 1
ORDER BY salary;

-- Query 07 -- write a query to fetch last 25% data from employye table ?
WITH employee_ranking AS (
  SELECT
    employee_id,
    last_name,
    first_name,
    salary,
    NTILE(4) OVER (ORDER BY salary ) as nti
  FROM employee
)
SELECT
  employee_id,
  last_name,
  first_name,
  salary
FROM employee_ranking
WHERE nti = 4
ORDER BY salary;

-- Query 08 -- write a query to numbering the data from employee table .?
 SELECT
  employee_id,
  last_name,
  first_name,
  salary,
  ROW_NUMBER() OVER (ORDER BY employee_id) as ranking_position
FROM employee;

-- Query 09 -- Write a query to fetch all employees data who earns more than company's avg salary.
SELECT
  first_name,
  last_name,
  salary
FROM employee 
WHERE salary > ( SELECT AVG(salary) FROM employee);

-- 10.Write a query to fetch all employees data who earns more than their departmental avg ?

SELECT
  first_name,
  last_name,dept_id,
  salary
FROM employee e1
WHERE salary >
    (SELECT AVG(salary)
     FROM employee e2
     WHERE e1.dept_id = e2.dept_id)
order by dept_id;

-- 11 -- find the duplicate entries in employee table ?
SELECT 
  employee_id,
  last_name,
  first_name,
  dept_id,
  manager_id,
  salary
FROM employee
GROUP BY   
  employee_id,
  last_name,
  first_name,
  dept_id,
  manager_id,
  salary
HAVING COUNT(*) > 1;

-- As there is 0 duplicate values that's y there is no data in the output table

-- Query 12: Write a query to find the total salary in each department and expertise level.

SELECT 
  dept_id,
  expertise,
  SUM(salary) total_salary
FROM    employee
GROUP BY dept_id, expertise;

-- Query 13 -- 




 
