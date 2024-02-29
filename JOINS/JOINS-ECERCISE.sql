#EMPLOYEE ADDRESS
SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees as e
         INNER JOIN addresses as a ON e.address_id = a.address_id
ORDER BY address_id asc
limit 5;

# Addresses with Towns


SELECT e.first_name, e.last_name, t.name, a.address_text
FROM employees as e
         JOIN addresses as a ON e.address_id = a.address_id
         JOIN towns as t ON a.town_id = t.town_id
ORDER BY first_name ASC, last_name ASC
LIMIT 5;

# SALES EMPLOYEE

SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
         JOIN departments as d On e.department_id = d.department_id
WHERE d.name = 'sales'
ORDER BY e.employee_id DESC;

#Employee Department

SELECT e.employee_id,
       e.first_name,
       e.salary,
       d.name
FROM employees AS e
         JOIN departments as d ON e.department_id = d.department_id

#Filter only employees with salary higher than 15000.
# Return the first 5 rows sorted by department_id in descending order.
WHERE e.salary > 14999
order by d.department_id DESC
limit 5
;

#Employees Without Project

SELECT e.employee_id,
       e.first_name
from employees as e
         LEFT JOIN employees_projects as p ON e.employee_id = p.project_id
WHERE project_id IS NULL
ORDER BY e.employee_id DESC
Limit 3;

#Employees Hired After
SELECT e.first_name, e.last_name, e.hire_date, d.name as dept_name
FROM employees AS e
         JOIN departments as d ON e.department_id = d.department_id
WHERE hire_date > '1999/01/01'
  AND (d.name = 'finance' OR d.name = 'sales')
ORDER BY e.hire_date ASC;

#Employees with Project

SELECT e.employee_id, e.first_name, p.name
FROM employees as e
         JOIN employees_projects as ep ON e.employee_id = ep.employee_id
         JOIN projects as p on ep.project_id = p.project_id
#Filter only employees with a project, which has started after 13.08.2002 and it is still ongoing (no end date).
WHERE DATE(start_date) > '2002-08-13 00:00:00'
  AND end_date IS NULL
# Return the first 5 rows sorted by first_name then by project_name both in ascending order.
ORDER BY e.first_name, p.name
LIMIT 5;

#Employee 24
SELECT e.employee_id,
       first_name,
       IF(YEAR(p.start_date) >= 2005, NULL, p.name) as project_name
FROM employees e
         JOIN employees_projects ep ON e.employee_id = ep.employee_id
         JOIN projects p ON ep.project_id = p.project_id
WHERE e.employee_id = 24
ORDER BY project_name;

#Employee Manager

SELECT e1.employee_id, e1.first_name, e1.manager_id, m.first_name
FROM employees e1,
     employees m
WHERE e1.manager_id = m.employee_id
  AND e1.manager_id IN (3, 7)
ORDER BY e1.first_name;

#Employee Summary
SELECT e.employee_id,
       concat(e.first_name, ' ', e.last_name) AS 'employee_name',
       concat(m.first_name, ' ', m.last_name) as 'manager_name',
       d.name
FROM employees as e
         JOIN employees as m on e.manager_id = m.employee_id
         JOIN departments as d on e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;;

# MIN AVERAGE SALARY
SELECT avg(salary) as 'min_average_salary'
from employees
GROUP BY department_id
ORDER BY min_average_salary
LIMIT 1;

#Highest Peaks in Bulgaria
USE geography;
SELECT c.country_code
     , m.mountain_range
     , p.peak_name
     , p.elevation
FROM countries as c
         JOIN mountains_countries as mc on c.country_code = mc.country_code
         JOIN mountains as m on mc.mountain_id = m.id
         JOIN peaks as p on m.id = p.mountain_id
WHERE c.country_name = 'Bulgaria'
  AND elevation > 2835
#Filter all peaks in Bulgaria with elevation over 2835. Return all rows sorted by elevation in descending order. ;
ORDER BY elevation desc;

# Count Mountain Ranges
SELECT country_code, count(mountain_range)as mrc FROM mountains_countries as mc
JOIN mountains as m ON mc.mountain_id = m.id
WHERE mc.country_code IN ('BG','US','RU')
GROUP BY mc.country_code
ORDER BY mrc desc;

#COUNTRIES WITH RIVERS
