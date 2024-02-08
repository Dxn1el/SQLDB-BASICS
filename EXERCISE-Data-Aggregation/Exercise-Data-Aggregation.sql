#1. records count

SELECT COUNT(*) AS 'count' FROM `wizzard_deposits`;

#2. longest magic want
SELECT MAX(`magic_wand_size`) AS 'Longest Wand' FROM `wizzard_deposits`;

# NOT A SUBMISSION : 2 longest magic want 2.1
SELECT DISTINCT `magic_wand_size`FROM `wizzard_deposits`
 ORDER BY `magic_wand_size` DESC
 LIMIT 1 OFFSET 1;
 
 #3. longest magic wand per deposit group
 SELECT `deposit_group`, MAX(`magic_wand_size`) AS'longest_magic_wand' FROM `wizzard_deposits`
 GROUP BY `deposit_group`
 ORDER BY `longest_magic_wand`, `deposit_group`
;

#4. smallest magic wand per deposit group

SELECT `deposit_group`, MIN(`magic_wand_size`) AS `smallest_magic_wand` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `smallest_magic_wand`, `deposit_group`
;

#5. smallest deposit group per magic wand size

SELECT `deposit_group` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`) LIMIT 1;
# get all sum
SELECT SUM(`deposit_amount`) FROM `wizzard_deposits`;

#6.  get sum per deposit group
SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
GROUP BY`deposit_group`
ORDER BY `Suma`, `deposit_group`;

#7. deposit sum for ollivander family

SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander Family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

#8. deposit filter
SELECT `deposit_group`, SUM(`deposit_amount`) AS'Suma'FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander Family'
GROUP BY `deposit_group`
HAVING `Suma`<150000
ORDER BY `Suma` DESC;

#9. deposit change
SELECT `deposit_group`,`magic_wand_creator`,MIN(`deposit_charge`) FROM `wizzard_deposits`
GROUP BY`deposit_group`,`magic_wand_creator`
ORDER BY `magic_wand_creator`,`deposit_group` ASC;

#10.AGE GROUPS

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

#11. unique letters

SELECT substring(`first_name`,1,1) AS 'letter' FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `letter`
Order by `letter`;

#12. Employees Minimum Salaries
#13. Employees Average Salarie
#14. Employees Maximum Salaries
#15. Employees Count Salaries
#17. Salary Challenge**
#18. Departments Total Salaries
