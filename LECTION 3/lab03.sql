SELECT `name`,date_format(`start`,'%Y-%m-%d') AS `start`FROM `games`
 WHERE YEAR(`start`) IN (2011,2012)
 ORDER BY `start`, `name`
 Limit 50;
 
 /*Find information about the email providers of all users. 
 Display the user_name and the email provider. Sort the results
 by email provider alphabetically, 
 then by username. 
 */
 SELECT `email` FROM `users`;
 SELECT `user_name`, SUBSTRING(`email`,locate('@',email)+1) as `Email Provider`FROM `users`
 ORDER BY `Email Provider`, `user_name`; 
 
 SELECT `user_name`, `ip_address` FROM `users`
 WHERE `ip_address` LIKE "___.1%.%.%___"
 ORDER BY `user_name`;
 
 /* Find all games with their corresponding part of the day and duration. 
 Parts of the day should be Morning (start time is >= 0 and < 12), Afternoon (start time is >= 12 and < 18), 
 Evening (start time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3), Short (between 3 and 6 including), 
 Long (between 6 and 10 including) and Extra Long in any other cases or without duration. 
 */
 
 SELECT`name` AS `game`,
 CASE 
 WHEN HOUR(`start`)>=0 AND HOUR(`start`)<12 THEN 'Morning'
 WHEN HOUR(`start`)>=12 AND HOUR(`start`)<18 THEN 'Afternoon'
 ELSE 'Evening'
 END
 AS `Part of the Day`,
 
 CASE 
 WHEN `duration` <=3 THEN 'Extra Short'
 WHEN `duration` <=6 THEN 'Short'
 WHEN `duration` <=10 THEN 'Long'
 ELSE 'Extra Long'
 END
 AS `Duration`
 FROM `games`;
 
 
 