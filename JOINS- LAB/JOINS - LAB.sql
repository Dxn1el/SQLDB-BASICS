# MANAGERS
SELECT 
    d.manager_id 'employee_id',
    concat_ws(' ', e.first_name, e.last_name) 'full_name',
    d.department_id department_id,
    d.name 'department_name'
FROM
    departments AS d
        JOIN
    employees AS e ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

#HIGHEST SALARY COUNT
SELECT COUNT(*) FROM employees as e
WHERE e.salary>(
SELECT AVG(e1.salary) FROM employees as e1
);
