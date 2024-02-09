#One-To-One Relationship

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

#One-To-Many Relationship