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

