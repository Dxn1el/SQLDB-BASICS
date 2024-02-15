SELECT 
    d.manager_id 'employee_id',
    CONCAT_WS(' ', e.first_name, e.last_name) 'full_name',
    d.department_id department_id,
    d.name 'department_name'
FROM
    departments AS d
        JOIN
    employees AS e ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

SELECT 
    COUNT(*)
FROM
    employees AS e
WHERE
    e.salary > (SELECT 
            AVG(e1.salary)
        FROM
            employees AS e1);
