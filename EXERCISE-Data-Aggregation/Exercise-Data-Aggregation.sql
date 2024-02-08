# records count

SELECT COUNT(*) AS 'count' FROM `wizzard_deposits`;

# longest magic want
SELECT MAX(`magic_wand_size`) AS 'Longest Wand' FROM `wizzard_deposits`;

# NOT A SUBMISSION : 2 longest magic want 2.1
SELECT DISTINCT `magic_wand_size`FROM `wizzard_deposits`
 ORDER BY `magic_wand_size` DESC
 LIMIT 1 OFFSET 1;
 
 # longest magic wand per deposit group
 SELECT `deposit_group`, MAX(`magic_wand_size`) AS'longest_magic_wand' FROM `wizzard_deposits`
 GROUP BY `deposit_group`
 ORDER BY `longest_magic_wand`, `deposit_group`
;

# smallest magic wand per deposit group

SELECT `deposit_group`, MIN(`magic_wand_size`) AS `smallest_magic_wand` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `smallest_magic_wand`, `deposit_group`
;

# smallest deposit group per magic wand size

SELECT `deposit_group` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`) LIMIT 1;
# get all sum
SELECT SUM(`deposit_amount`) FROM `wizzard_deposits`;

#  get sum per deposit group
SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
GROUP BY`deposit_group`
ORDER BY `Suma`, `deposit_group`;

#deposit sum for ollivander family

SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander Family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

# deposit filter
SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander Family'
GROUP BY `deposit_group`
HAVING `Suma`<150000
ORDER BY `Suma` DESC;

# deposit change
SELECT `deposit_group`,`magic_wand_creator`,MIN(`deposit_charge`) FROM `wizzard_deposits`
GROUP BY`deposit_group`,`magic_wand_creator`
ORDER BY `magic_wand_creator`,`deposit_group` ASC;

#AGE GROUPS

SELECT  (
CASE
WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
WHEN `age`>=61 THEN '[61+]'
END
) AS 'age_group', 	COUNT(`first_name`) FROM `wizzard_deposits` 
GROUP BY `age_group`
ORDER BY `age_group`
;

# unique letters

SELECT substring(`first_name`,1,1) AS 'letter' FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `letter`
Order by `letter`;


# Average Interest 
SELECT `deposit_group`,`is_deposit_expired`,AVG(deposit_interest) FROM `wizzard_deposits`
WHERE `deposit_start_date` >'1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired` ASC;

# Employees Minimum Salaries

SELECT `department_id`, MIN(`salary`) FROM `employees`
WHERE `hire_date`> '2000-01-01' AND( `department_id`=2 OR `department_id`=7 OR `department_id`=5)
GROUP BY `department_id`
ORDER BY `department_id` ASC;


# Employees Average Salarie

CREATE TABLE `high_paid_employees` AS
SELECT * FROM `employees` 
WHERE salary>30000;

DELETE FROM `high_paid_employees`
WHERE `manager_id`=42;

UPDATE `high_paid_employees`
SET `salary` =  `salary` + 5000
WHERE `department_id`=1;

SELECT `department_id`,AVG(`salary`) FROM `high_paid_employees`
GROUP BY `department_id`
ORDER BY `department_id` ASC;

# Employees Maximum Salaries
SELECT `department_id`, MAX(`salary`) AS `max_salary` FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

# Employees Count Salaries
SELECT COUNT(`salary`) FROM `employees`
WHERE `manager_id` IS NULL;

# 3rd Highest Salary* 
SELECT DISTINCT `department_id`, (
SELECT DISTINCT `salary`  FROM `employees` e
WHERE e.`department_id`= `employees`.`department_id`
ORDER BY `salary` DESC
LIMIT 1 OFFSET 2
) AS 'third_highest_salary' FROM `employees`
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

# Salary Challenge**

SELECT `first_name`, `last_name`, `department_id` FROM `employees` AS e1
WHERE `salary`>(
SELECT AVG(`salary`) FROM `employees` e2
WHERE e1.`department_id`= e2.`department_id`
)
ORDER BY `department_id`, `employee_id`
LIMIT 10;

# Departments Total Salaries
SELECT `department_id`, SUM(`salary`) FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;
