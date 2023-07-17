CREATE TABLE  `Employees` 
   (	
    `employee_code` CHAR(6) NOT NULL, 
	`employee_name` CHAR(40), 
	`dept` CHAR(35), 
	`email` CHAR(25), 
	`joining_type` CHAR(15) NOT NULL,
	`full_time_date` DATE NOT NULL,
	`created` DATETIME,
	PRIMARY KEY (`employee_code`)
	 );

	 CREATE TABLE  `EmployeeLegacy` 
   (	
	`id` int(11) NOT NULL AUTO_INCREMENT, 
    `employee_code` CHAR(6) NOT NULL, 
	`employee_name` CHAR(40), 
	`dept` CHAR(35), 
	`email` CHAR(25), 
	`is_active` TINYINT(1),
	PRIMARY KEY (`id`)
	 );

INSERT INTO EmployeeLegacy VALUES (NULL,"CA1","John","Sales","john@doe.com",0);
INSERT INTO EmployeeLegacy VALUES (NULL,"CA1","John","IT","john@doe.com",1);
INSERT INTO EmployeeLegacy  VALUES (NULL,"LA2","Jonny","Sales","jonny@doe.com",1);


CREATE TABLE  `EmployeeJoinigDetails` 
   (	
	`id` int(11) NOT NULL AUTO_INCREMENT, 
    `employee_code` CHAR(6) NOT NULL, 
	`joining_date` DATE, 
	`is_remote` TINYINT(1),
	`created` DATE,
	PRIMARY KEY (`id`),
	UNIQUE KEY `employee_code` (`employee_code`)
	 );
 
INSERT INTO EmployeeJoinigDetails VALUES (NULL,"CA1",STR_TO_DATE('09-25-2022','%m-%d-%Y'),1,CURRENT_TIMESTAMP);
INSERT INTO EmployeeJoinigDetails VALUES (NULL,"LA2",STR_TO_DATE('07-25-2022','%m-%d-%Y'),0,CURRENT_TIMESTAMP);



-- Think we need the data in New table from the Legacy table
INSERT INTO Employees (
	`employee_code`,
	`employee_name`,
	`dept`,
	`email`,
	`joining_type`,
	`full_time_date`,
	`created` 
) SELECT
le.employee_code,
le.employee_name,
le.dept,
le.email,
IF
	( ejd.is_remote = 1, "Remote", "Non-Remote" ),
	DATE_SUB( ejd.joining_date, INTERVAL 6 MONTH ),
CURRENT_TIMESTAMP 
FROM
	`EmployeeLegacy` le
	LEFT JOIN `EmployeeJoinigDetails` ejd ON ejd.employee_code = le.employee_code 
WHERE
	le.employee_code = 'CA1' 
	AND le.is_active = 1 
	ON DUPLICATE KEY UPDATE dept =
VALUES
	( dept ),
	email =
VALUES
	( email ),
	joining_type =
VALUES
	( joining_type ),
	full_time_date =
VALUES
	(
	full_time_date)