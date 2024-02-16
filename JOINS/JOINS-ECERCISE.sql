#EMPLOYEE ADDRESS

SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees as e
INNER JOIN addresses as a ON e.address_id = a.address_id
ORDER BY address_id asc
limit 5;

# Addresses with Towns

#Write a query that selects:
# first_name
#last_name
#town
#address_text
#Sort the result by first_name in ascending order then by last_name. Select first 5 employees.

SELECT e.first_name,e.last_name,t.name, a.address_text
FROM employees as e
JOIN addresses as a ON e.address_id = a.address_id
JOIN towns as t ON a.town_id = t.town_id
ORDER BY first_name ASC , last_name ASC
LIMIT 5;
