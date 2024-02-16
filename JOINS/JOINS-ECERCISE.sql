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

SELECT e.employee_id,e.first_name, p.name
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





