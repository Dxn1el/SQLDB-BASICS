#EMPLOYEES >35000
CREATE PROCEDURE usp_get_employees_salary_above_35000()
begin
    SELECT first_name, last_name
    FROM employees
    WHERE salary > 35000
    order by first_name, last_name, employee_id;
end;

# test
call soft_uni.usp_get_employees_salary_above_35000();

#
CREATE PROCEDURE 