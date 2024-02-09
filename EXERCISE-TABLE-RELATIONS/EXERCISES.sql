#One-To-One Relationshipfk_passport
CREATE DATABASE `TableRelations`;

CREATE TABLE `passports`(
`passport_id` INT NOT NULL PRIMARY KEY,
`passport_number` VARCHAR(30) NOT NULL UNIQUE
);

 INSERT INTO `passports`(`passport_id`,`passport_number`)
 VALUES
 (101,'N34FG21B'),
 (102,'K65LO4R7'),
 (103,'ZE657QP2');
 
 CREATE TABLE `people`(
`person_id` INT AUTO_INCREMENT PRIMARY KEY,
`first_name` VARCHAR(35)NOT NULL,
`salary` DECIMAL(9,2) NOT NULL,
`passport_id` INT UNIQUE,
CONSTRAINT fk_passport
FOREIGN KEY(`passport_id`)
REFERENCES`passports`(`passport_id`)
);

INSERT INTO `people`(`first_name`, `salary`, `passport_id`)
VALUES
('Roberto',43300,102),
('Tom',56100,103),
('Yana',60200,101);

# not part of the exercise

ALTER TABLE `tablerelations`.`people` 
DROP FOREIGN KEY `fk_passport`;
ALTER TABLE `tablerelations`.`people` 
DROP INDEX `passport_id` ;
;

#One-To-Many Relationship
CREATE DATABASE `cars`;

CREATE TABLE `manufacturers`(
`manufacturer_id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR (15) NOT NULL UNIQUE,
`established_on` DATE
);

INSERT INTO `manufacturers`(`name`, `established_on`)
VALUES
('BMW','1916-03-01'),
('Tesla','2003-01-01'),
('Lada','1966-05-01');

CREATE TABLE `models`(
`model_id` INT(10) NOT NULL PRIMARY KEY,
`name` VARCHAR(30) NOT NULL,
`manufacturer_id` INT,
CONSTRAINT fk_manufacturer
FOREIGN KEY (`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`)
);

INSERT INTO `models` (`model_id`,`name`,`manufacturer_id`)
VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);