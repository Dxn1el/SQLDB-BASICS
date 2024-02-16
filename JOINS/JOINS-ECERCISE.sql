#EMPLOYEE ADDRESS

SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees as e
INNER JOIN addresses as a ON e.address_id = a.address_id
ORDER BY address_id asc
limit 5;

