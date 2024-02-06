CREATE DATABASE hr_database
USE hr_database;

SELECT * FROM  hr;

-- Changing the name of the 'ï»¿id' column to 'emp_id' in the 'hr' table.
ALTER TABLE hr RENAME COLUMN  ï»¿id TO emp_id; 

-- Retrieving information about the structure of the 'hr' table
DESCRIBE hr;


-- Disabling security feature to allow changes in the dataset
SET sql_safe_updates = 0; 

/* Updating the 'birthdate' column in the 'hr' table:
 Converts date values containing '/' or '-' to the 'YYYY-MM-DD' format,
 while handling different date formats, and sets other cases to NULL.*/
UPDATE hr 
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Modifying the data type of the 'birthdate' column to DATE in the 'HR' table.
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

select birthdate from hr;

/* Updating the 'hire_date' column in the 'hr' table:
 Converts date values containing '/' or '-' to the 'YYYY-MM-DD' format,
 while handling different date formats, and sets other cases to NULL.*/
UPDATE hr 
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Modifying the data type to DATE, allowing for the update and storage of date values.
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

/*Updating the 'termdate' column in the 'hr' table:
Converting date values from the format '%Y-%m-%d %H:%i:%s UTC' to a DATE type,
and setting non-null and non-empty 'termdate' values to '0000-00-00'.*/
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

-- Set SQL mode to 'ALLOW_INVALID_DATES' to permit the use of invalid dates during operations.
SET sql_mode = 'ALLOW_INVALID_DATES';

-- Modifying the data type to DATE, allowing for the update and storage of date values.
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Adding a new column 'age' to the 'hr' table with data type INT.
ALTER TABLE hr
ADD COLUMN age INT;

-- Calculating the age based on the difference in years between 'birthdate' and the current date.
UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

-- Retrieving the minimum and maximum age from the 'hr' table:
SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr;

-- Counting the number of records in the 'hr' table where age is less than 18:
SELECT COUNT(*) FROM hr WHERE age < 18;

-- Excluding 967 records out of 22,214 records because their age is less than 18 years. --


-- Questions
-- 1.What is the gender breakdown of employees in the company?
SELECT gender,count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00' 
GROUP BY gender;

-- 2.What is the race/ethnicity breakdown of employees in the company?
select race,COUNT(*) AS count
FROM hr 
WHERE age >= 18 AND termdate = '0000-00-00' 
GROUP BY race
ORDER BY count(*) DESC

-- 3.What is the age distribution of employees in the company?
SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00' ;

SELECT 
	CASE
		WHEN age >= 18 AND age <= 25 THEN '18-25'
        WHEN age >= 26 AND age <= 35 THEN '26-35'
        WHEN age >= 36 AND age <= 45 THEN '36-45'
        WHEN age >= 46 AND age <= 55 THEN '46-55'
        WHEN age >= 56 AND age <= 65 THEN '56-65'
        ELSE '65+'
	END AS age_group,
    count(*) AS count
from hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group 
ORDER BY age_group ;

SELECT 
	CASE
		WHEN age >= 18 AND age <= 25 THEN '18-25'
        WHEN age >= 26 AND age <= 35 THEN '26-35'
        WHEN age >= 36 AND age <= 45 THEN '36-45'
        WHEN age >= 46 AND age <= 55 THEN '46-55'
        WHEN age >= 56 AND age <= 65 THEN '56-65'
        ELSE '65+'
	END AS age_group,gender,
    count(*) AS count
from hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group,gender 
ORDER BY age_group,gender ;

-- 4.How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5.What is the average length of employment for employees who have been terminated?
select round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate() and termdate <> '0000-00-00' AND age>= 18;

-- 6.How does the gender distribution vary across departments and job titles?
SELECT department,gender,COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department,gender
ORDER BY department,gender;

-- 7.What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8.Which department has the highest turnover rate?
SELECT department, 
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM(
	SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM hr WHERE age >= 18
GROUP BY department
) AS subquery
ORDER By termination_rate DESC;

-- 9.What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10.How has the company's employee count changed over time based on hire and term dates?
SELECT
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    round((hires - terminations)/  hires * 100,2) AS net_change_percentage
FROM(
	SELECT
		YEAR(hire_date) AS year,
		COUNT(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
	FROM hr
    WHERE age >= 18 
    GROUP BY YEAR(hire_date)
) AS subquery
ORDER BY year ASC;


-- 11.What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr 
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18
GROUP by Department;






