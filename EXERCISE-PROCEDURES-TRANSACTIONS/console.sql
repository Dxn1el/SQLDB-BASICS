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

#EMPLOYEES WITH SALARY ABOVE NUMBER

CREATE PROCEDURE usp_get_employees_salary_above(target_salary DECIMAL (19,4))
begin
    SELECT  first_name, last_name FROM employees
        where salary >=target_salary
    ORDER BY first_name,last_name,employee_id;
end;

#TEST
call soft_uni.usp_get_employees_salary_above(100000.0000);

#TOWN NAMES  STARTING WITH STRING
CREATE PROCEDURE  usp_get_towns_starting_with(starting_string VARCHAR(25))
begin
SELECT  name FROM towns
    WHERE name like concat(starting_string, '%')
    ORDER BY name;
end;

#TEST
call soft_uni.usp_get_towns_starting_with('b');

#Employees from Town
CREATE PROCEDURE usp_get_employees_from_town (string_town VARCHAR (25))
begin
SELECT first_name, last_name FROM employees as e
    JOIN addresses as a USING (address_id)
    JOIN towns as t USING (town_id)

WHERE t.name = string_town
ORDER BY first_name, last_name;
end;

#TEST
call soft_uni.usp_get_employees_from_town('Sofia');


#Salary Level Function
CREATE FUNCTION  ufn_get_salary_level (employee_salary DECIMAL(19,4))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE salary_level VARCHAR(10);# text with the level of salary
    IF employee_salary <  30000 THEN set salary_level :='low';
    ELSEIF  employee_salary <=50000 then  set salary_level :='average';
    ELSE  set salary_leveL :='high';
    end if;
    return salary_level;

end;

#Employees by Salary Level
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_lever VARCHAR(10))
begin
    SELECT first_name, last_name from employees
    WHERE ufn_get_salary_level(salary) = salary_lever
    ORDER BY first_name, last_name;
    end;

#Define Function

