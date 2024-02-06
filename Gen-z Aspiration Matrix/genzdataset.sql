CREATE DATABASE genzdataset;
use genzdataset;
-- IMPORT GENZ DUMP -- 
show tables;
select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;

-- Delete the 'Timestamp' column from the 'personalized_info' table where all values are in zero format
ALTER TABLE personalized_info
DROP COLUMN Timestamp;

-- connect all table into one table--

CREATE TABLE combined_table AS
SELECT
    COALESCE(t1.ResponseID, t2.ResponseID, t3.ResponseID, t4.ResponseID) AS ResponseID,
    t1.CareerInfluenceFactor,
    t1.HigherEducationAbroad,
    t1.PreferredWorkingEnvironment,
    t1.ZipCode AS ZipCode_t1,
    t1.ClosestAspirationalCareer,
    
    t2.WorkLikelihood3Years,
    t2.PreferredEmployer,
    t2.PreferredManager,
    t2.PreferredWorkSetup,
    t2.WorkLikelihood7Years,
    
    t3.MissionUndefinedLikelihood,
    t3.MisalignedMissionLikelihood,
    t3.NoSocialImpactLikelihood,
    t3.LaidOffEmployees,
    t3.ExpectedSalary3Years,
    t3.ExpectedSalary5Years,
    
    t4.CurrentCountry,
    t4.ZipCode AS ZipCode_t4,
    t4.Gender
FROM
    learning_aspirations t1
LEFT JOIN manager_aspirations t2 ON t1.ResponseID = t2.ResponseID
LEFT JOIN mission_aspirations t3 ON t1.ResponseID = t3.ResponseID
LEFT JOIN personalized_info t4 ON t1.ResponseID = t4.ResponseID

UNION

SELECT
    COALESCE(t1.ResponseID, t2.ResponseID, t3.ResponseID, t4.ResponseID) AS ResponseID,
    t1.CareerInfluenceFactor,
    t1.HigherEducationAbroad,
    t1.PreferredWorkingEnvironment,
    t1.ZipCode AS ZipCode_t1,
    t1.ClosestAspirationalCareer,
    
    t2.WorkLikelihood3Years,
    t2.PreferredEmployer,
    t2.PreferredManager,
    t2.PreferredWorkSetup,
    t2.WorkLikelihood7Years,
    
    t3.MissionUndefinedLikelihood,
    t3.MisalignedMissionLikelihood,
    t3.NoSocialImpactLikelihood,
    t3.LaidOffEmployees,
    t3.ExpectedSalary3Years,
    t3.ExpectedSalary5Years,
    
    t4.CurrentCountry,
    t4.ZipCode AS ZipCode_t4,
    t4.Gender
FROM
    manager_aspirations t2
LEFT JOIN learning_aspirations t1 ON t1.ResponseID = t2.ResponseID
LEFT JOIN mission_aspirations t3 ON t2.ResponseID = t3.ResponseID
LEFT JOIN personalized_info t4 ON t2.ResponseID = t4.ResponseID

UNION

SELECT
    COALESCE(t1.ResponseID, t2.ResponseID, t3.ResponseID, t4.ResponseID) AS ResponseID,
    t1.CareerInfluenceFactor,
    t1.HigherEducationAbroad,
    t1.PreferredWorkingEnvironment,
    t1.ZipCode AS ZipCode_t1,
    t1.ClosestAspirationalCareer,
    
    t2.WorkLikelihood3Years,
    t2.PreferredEmployer,
    t2.PreferredManager,
    t2.PreferredWorkSetup,
    t2.WorkLikelihood7Years,
    
    t3.MissionUndefinedLikelihood,
    t3.MisalignedMissionLikelihood,
    t3.NoSocialImpactLikelihood,
    t3.LaidOffEmployees,
    t3.ExpectedSalary3Years,
    t3.ExpectedSalary5Years,
    
    t4.CurrentCountry,
    t4.ZipCode AS ZipCode_t4,
    t4.Gender
FROM
    mission_aspirations t3
LEFT JOIN learning_aspirations t1 ON t1.ResponseID = t3.ResponseID
LEFT JOIN manager_aspirations t2 ON t3.ResponseID = t2.ResponseID
LEFT JOIN personalized_info t4 ON t3.ResponseID = t4.ResponseID

UNION

SELECT
    COALESCE(t1.ResponseID, t2.ResponseID, t3.ResponseID, t4.ResponseID) AS ResponseID,
    t1.CareerInfluenceFactor,
    t1.HigherEducationAbroad,
    t1.PreferredWorkingEnvironment,
    t1.ZipCode AS ZipCode_t1,
    t1.ClosestAspirationalCareer,
    
    t2.WorkLikelihood3Years,
    t2.PreferredEmployer,
    t2.PreferredManager,
    t2.PreferredWorkSetup,
    t2.WorkLikelihood7Years,
    
    t3.MissionUndefinedLikelihood,
    t3.MisalignedMissionLikelihood,
    t3.NoSocialImpactLikelihood,
    t3.LaidOffEmployees,
    t3.ExpectedSalary3Years,
    t3.ExpectedSalary5Years,
    
    t4.CurrentCountry,
    t4.ZipCode AS ZipCode_t4,
    t4.Gender
FROM
    personalized_info t4
LEFT JOIN learning_aspirations t1 ON t1.ResponseID = t4.ResponseID
LEFT JOIN manager_aspirations t2 ON t4.ResponseID = t2.ResponseID
LEFT JOIN mission_aspirations t3 ON t4.ResponseID = t3.ResponseID;

  select * from combined_table;
    
    -- Phase 1 Questions --

-- Question 1: How many Male have responded to the survey from India--
select Count(*) as Male from combined_table where Gender like 'Male%' AND CurrentCountry = 'India'


-- Question 2: How many Female have responded to the survey from India --
 select Count(*) from combined_table where Gender = 'Female\r' AND CurrentCountry = 'India'

-- Question 3: How many of the Gen-Z are influenced by their parents in regards to their career choices from India --
select distinct(CareerInfluenceFactor) from combined_table  -- Know the how many distinct career influencer factor --
select count(ResponseId) from combined_table where CareerInfluenceFactor = 'My Parents';

-- Question 4: How many of the Female Gen-Z are influenced by their parents in regards to their career choices from India --
select count(ResponseId) from combined_table where CareerInfluenceFactor = 'My Parents' And Gender = 'Female\r';

-- Question 5: How many of the Male Gen-Z are influenced by their parents in regards to their career choices from India --
select count(ResponseId) from combined_table where CareerInfluenceFactor = 'My Parents' And Gender = 'Male\r';

/*  Question 6: How many of the Male and Female (individually display in 2 different columns, but as part of the same query)
Gen-Z are influenced by their parents in regards to their career choices from India */
select distinct(gender),count(gender) from combined_table where CareerInfluenceFactor = 'My Parents' group by Gender;

-- Question 7: How many Gen-Z are influenced by Social Media and Influencers together from India --
select distinct(CareerInfluenceFactor) from combined_table  -- Know the how many distinct career influencer factor --
select count(CareerInfluenceFactor) from combined_table 
where (CareerInfluenceFactor = 'Social Media like LinkedIn' OR CareerInfluenceFactor= 'Influencers who had successful careers') 
AND CurrentCountry = 'India'


-- Question 8: How many Gen-Z are influenced by Social Media and Influencers together, display for Male and Female seperately from India -- 
select distinct(Gender),count(CareerInfluenceFactor) from combined_table 
where CareerInfluenceFactor = 'Social Media like LinkedIn' OR CareerInfluenceFactor= 'Influencers who had successful careers' group by Gender;


-- Question 9: How many of the Gen-Z who are influenced by the social media for their career aspiration are looking to go abroad -- 
select count(CareerInfluenceFactor) from combined_table 
where CareerInfluenceFactor = 'Social Media like LinkedIn' And HigherEducationAbroad = 'Yes, I wil'


-- Question 10: How many of the Gen-Z who are influenced by "people in their circle" for career aspiration are looking to go abroad -- 
select distinct(CareerInfluenceFactor) from combined_table  -- Know the how many distinct career influencer factor --
select count(CareerInfluenceFactor) from combined_table 
where HigherEducationAbroad = 'Yes, I wil' And CareerInfluenceFactor = 'People who have changed the world for better'


-- phase 2 Questions -- 
select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;

-- 1. What percentage of male and female Gen Z wants to go to the office Every Day? --
SELECT
Gender,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Every Day Office Environment' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS PercentageEveryDayOffice
FROM
Personalized_info p
JOIN
learning_aspirations l ON p.ResponseID = l.ResponseID
GROUP BY
Gender;


-- 2. What percentage of Genz's who have chosen their career in Business operations are most likely to be influenced by their Parents?
SELECT 
(sum(CASE WHEN l.ClosestAspirationalCareer LIKE '%Business Operations%' THEN 1 ELSE 0 END ) / COUNT(*))*100 AS Percentage
FROM
Personalized_info p
JOIN 
learning_aspirations l ON p.ResponseID = l.ResponseID
WHERE l.CareerInfluenceFactor = 'My Parents'


-- 3. What percentage of Genz prefer opting for higher studies, give a gender wise approach? --		
SELECT Gender,
(SUM(CASE WHEN l.HigherEducationAbroad = 'Yes, I wil' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS genderpercentage
FROM
Personalized_info p
JOIN
learning_aspirations l ON p.ResponseID = l.ResponseID
GROUP BY
Gender;

/*  4. What percentage of Genz are willing & not willing to work for a company whose mission is misaligned 
with their public actions or even their products? (give gender based split) */ 

SELECT Gender,
(SUM(CASE WHEN mis.MisalignedMissionLikelihood = 'Will NOT work for them' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS genderpercentagewillnotwork,
(SUM(CASE WHEN mis.MisalignedMissionLikelihood = 'Will work for them' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS genderpercentagewillwork
FROM
Personalized_info p
JOIN
mission_aspirations mis ON p.ResponseID = mis.ResponseID
GROUP BY
Gender;

-- 5. What is the most suitable working environment according to female genz's? --

SELECT
Gender,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Every Day Office Environment' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env1,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Fully Remote with No option to visit offices' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env2,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Hybrid Working Environment with less than 15 days a month at office' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env3,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Fully Remote with Options to travel as and when needed' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env4,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Hybrid Working Environment with less than 3 days a month at office' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env5,
(SUM(CASE WHEN l.PreferredWorkingEnvironment = 'Hybrid Working Environment with less than 10 days a month at office' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env6,
(SUM(CASE WHEN l.PreferredWorkingEnvironment ='Hybrid Working Environment with more than 15 days a month at office' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS env7
FROM
Personalized_info p
JOIN
learning_aspirations l ON p.ResponseID = l.ResponseID
WHERE Gender = 'Female\r';

-- 6. Calculate the total number of Female who aspire to work in their Closest Aspirational Career and have a No Social Impact Likelihood of "1 to 5" --

SELECT
SUM(CASE WHEN mis.NoSocialImpactLikelihood IN (1, 2, 3, 4, 5) THEN 1 ELSE 0 END) AS countfemale
FROM
Personalized_info p
JOIN
mission_aspirations mis ON p.ResponseID = mis.ResponseID
WHERE Gender = 'Female\r';

-- 7. Retrieve the Male who are interested in Higher Education Abroad and have a Career Influence Factor of "My Parents." -- 

SELECT 
(SUM(CASE WHEN l.HigherEducationAbroad = 'Yes, I wil' THEN 1 ELSE 0 END) ) AS interestedmale
FROM
Personalized_info p
JOIN
learning_aspirations l ON p.ResponseID = l.ResponseID
where Gender = 'Male\r' ;

-- 8. Determine the percentage of gender who have a No Social Impact Likelihood of "8 to 10" among those who are interested in Higher Education Abroad --

SELECT Gender,
 (sum(CASE WHEN mis.NoSocialImpactLikelihood IN(8,9,10) THEN 1 ELSE 0 END)/ COUNT(*)) * 100 AS GENDERPERCENTAGE
FROM
 personalized_info p 
 join mission_aspirations mis on p.ResponseID = mis.ResponseID  
 join learning_aspirations l on l.ResponseID = mis.ResponseID
where l.HigherEducationAbroad = 'Yes, I wil' group by Gender;


--  9. Give a detailed split of the GenZ preferences to work with Teams, Data should include Male, Female and Overall in counts and also the overall in % --
 

select Gender,
(SUM(CASE WHEN man.PreferredWorkSetup like '%Work with%'  THEN 1 ELSE 0 END) ) AS countpreferences,
(SUM(CASE WHEN man.PreferredWorkSetup like '%Work with%'  THEN 1 ELSE 0 END) / count(*)) * 100 AS preferencepercentage
FROM
Personalized_info p
JOIN
manager_aspirations man on p.ResponseID = man.ResponseID
group by Gender;





-- 10. Give a detailed breakdown of "WorkLikelihood 3 Years" for each gender -- 

SELECT 
Gender,
sum(case when WorkLikelihood3Years = 'No way' then 1 else 0 end) as countofnoway,
sum(case when WorkLikelihood3Years = 'No way, 3 years with one employer is crazy' then 1 else 0 end) as countof3yriscrazy,
sum(case when WorkLikelihood3Years = 'This will be hard to do, but if it is the right co' then 1 else 0 end) as countofhardtodo,
sum(case when WorkLikelihood3Years = 'Will work for 3 years or more' then 1 else 0 end) as countofwillwork,
(sum(case when WorkLikelihood3Years = 'No way' then 1 else 0 end)/count(*))*100 as percentageofnoway,
(sum(case when WorkLikelihood3Years = 'No way, 3 years with one employer is crazy' then 1 else 0 end)/count(*))*100 as percentageof3yriscrazy,
(sum(case when WorkLikelihood3Years = 'This will be hard to do, but if it is the right co' then 1 else 0 end)/count(*))*100 as percentageofhardtodo,
(sum(case when WorkLikelihood3Years = 'Will work for 3 years or more' then 1 else 0 end)/count(*))*100 as percetageofwillwork
from personalized_info p
join manager_aspirations man on p.ResponseID = man.ResponseID
group by Gender;


-- 11. What is the Average Starting salary expectations at 3 year mark for each gender

select Gender,avg(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',1),'k',1)AS signed)) AS extracted_value
 from personalized_info p
join mission_aspirations mis on p.ResponseID = mis.ResponseID
group by Gender;

-- 12. What is the Average Starting salary expectations at 5 year mark for each gender --
select Gender, avg(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary5Years,'to',1),'k',1)AS signed)) AS extracted_value
from personalized_info p
join mission_aspirations mis on p.ResponseID = mis.ResponseID
group by Gender;

-- 13. What is the Average Higher Bar salary expectations at 3 year mark for each gender --

select Gender,
 ROUND(AVG(RIGHT(ExpectedSalary3Years,3) -  RIGHT(ExpectedSalary3Years,1)),2) AS AVGSALARY
 from personalized_info p
join
mission_aspirations mis on p.ResponseID = mis.ResponseID
group by Gender;


-- 14. What is the Average Higher Bar salary expectations at 5 year mark for each gender


SELECT p.Gender,
  avg(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1)AS signed)) AS extracted_value
 FROM personalized_info p
join
mission_aspirations mis on p.ResponseID = mis.ResponseID group by Gender


 -- 15. What is the Average Starting salary expectations at 3 year mark for each gender and each state in India --

WITH state AS (
SELECT ResponseID, Gender,
    CASE
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '11' AND '11' THEN 'Delhi'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '12' AND '13' THEN 'Haryana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '14' AND '16' THEN 'Punjab'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '17' AND '17' THEN 'Himachal Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '18' AND '19' THEN 'Jammu & Kashmir'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '20' AND '28' THEN 'Uttar Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '30' AND '34' THEN 'Rajasthan'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '36' AND '39' THEN 'Gujarat'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '40' AND '44' THEN 'Maharashtra'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '45' AND '48' THEN 'Madhya Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) = '49' THEN 'Chhattisgarh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '50' AND '53' THEN 'Andhra Pradesh / Telangana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '56' AND '59' THEN 'Karnataka'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '60' AND '64' THEN 'Tamil Nadu'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '67' AND '69' THEN 'Kerala'
        WHEN SUBSTRING(zipcode, 1, 3) = '682' THEN 'Lakshadweep'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '70' AND '74' THEN 'West Bengal'
        WHEN SUBSTRING(zipcode, 1, 3) = '744' THEN 'Andaman & Nicobar'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '75' AND '77' THEN 'Orissa'
        WHEN SUBSTRING(zipcode, 1, 2) = '78' THEN 'Assam'
        WHEN SUBSTRING(zipcode, 1, 2) = '79' THEN 'Arunachal Pradesh / Manipur / Meghalaya / Mizoram / Nagaland / Tripura'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '80' AND '85' THEN 'Bihar / Jharkhand'
        ELSE 'Unknown'
    END AS state
FROM personalized_info
),
avg_salary as(
SELECT s.state,s.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary3Years, 'k', 1) AS SIGNED)) AS average_starting_salary
FROM state s
INNER JOIN mission_aspirations m2 
ON s.ResponseID = m2.ResponseID
GROUP BY s.state,s.Gender
ORDER BY s.state
)
SELECT state,
	SUM(CASE WHEN gender LIKE 'Female%' THEN average_starting_salary ELSE 0 END) AS female_avg_sal,
    SUM(CASE WHEN gender LIKE 'Male%' THEN average_starting_salary ELSE 0 END) AS male_avg_sal
from avg_salary
group by 1;


select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;
 
 
--  16. What is the Average Starting salary expectations at 5 year mark for each gender and each state in India
WITH state AS (
SELECT ResponseID, Gender,
    CASE
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '11' AND '11' THEN 'Delhi'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '12' AND '13' THEN 'Haryana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '14' AND '16' THEN 'Punjab'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '17' AND '17' THEN 'Himachal Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '18' AND '19' THEN 'Jammu & Kashmir'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '20' AND '28' THEN 'Uttar Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '30' AND '34' THEN 'Rajasthan'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '36' AND '39' THEN 'Gujarat'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '40' AND '44' THEN 'Maharashtra'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '45' AND '48' THEN 'Madhya Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) = '49' THEN 'Chhattisgarh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '50' AND '53' THEN 'Andhra Pradesh / Telangana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '56' AND '59' THEN 'Karnataka'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '60' AND '64' THEN 'Tamil Nadu'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '67' AND '69' THEN 'Kerala'
        WHEN SUBSTRING(zipcode, 1, 3) = '682' THEN 'Lakshadweep'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '70' AND '74' THEN 'West Bengal'
        WHEN SUBSTRING(zipcode, 1, 3) = '744' THEN 'Andaman & Nicobar'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '75' AND '77' THEN 'Orissa'
        WHEN SUBSTRING(zipcode, 1, 2) = '78' THEN 'Assam'
        WHEN SUBSTRING(zipcode, 1, 2) = '79' THEN 'Arunachal Pradesh / Manipur / Meghalaya / Mizoram / Nagaland / Tripura'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '80' AND '85' THEN 'Bihar / Jharkhand'
        ELSE 'Unknown'
    END AS state
FROM personalized_info
),
avg_salary as(
SELECT s.state,s.Gender,
    AVG(CAST(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) AS SIGNED)) AS average_starting_salary
FROM state s
INNER JOIN mission_aspirations m2 
ON s.ResponseID = m2.ResponseID
GROUP BY s.state,s.Gender
ORDER BY s.state
)
SELECT state,
	SUM(CASE WHEN gender LIKE 'Female%' THEN average_starting_salary ELSE 0 END) AS female_avg_sal,
    SUM(CASE WHEN gender LIKE 'Male%' THEN average_starting_salary ELSE 0 END) AS male_avg_sal
from avg_salary
group by 1;


-- 17. What is the Average Higher Bar salary expectations at 3 year mark for each gender and each
WITH state AS (
SELECT ResponseID, Gender,
    CASE
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '11' AND '11' THEN 'Delhi'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '12' AND '13' THEN 'Haryana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '14' AND '16' THEN 'Punjab'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '17' AND '17' THEN 'Himachal Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '18' AND '19' THEN 'Jammu & Kashmir'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '20' AND '28' THEN 'Uttar Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '30' AND '34' THEN 'Rajasthan'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '36' AND '39' THEN 'Gujarat'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '40' AND '44' THEN 'Maharashtra'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '45' AND '48' THEN 'Madhya Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) = '49' THEN 'Chhattisgarh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '50' AND '53' THEN 'Andhra Pradesh / Telangana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '56' AND '59' THEN 'Karnataka'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '60' AND '64' THEN 'Tamil Nadu'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '67' AND '69' THEN 'Kerala'
        WHEN SUBSTRING(zipcode, 1, 3) = '682' THEN 'Lakshadweep'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '70' AND '74' THEN 'West Bengal'
        WHEN SUBSTRING(zipcode, 1, 3) = '744' THEN 'Andaman & Nicobar'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '75' AND '77' THEN 'Orissa'
        WHEN SUBSTRING(zipcode, 1, 2) = '78' THEN 'Assam'
        WHEN SUBSTRING(zipcode, 1, 2) = '79' THEN 'Arunachal Pradesh / Manipur / Meghalaya / Mizoram / Nagaland / Tripura'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '80' AND '85' THEN 'Bihar / Jharkhand'
        ELSE 'Unknown'
    END AS state
FROM personalized_info
),
avg_salary as(
SELECT s.state,s.Gender,
      avg(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1)AS signed)) AS extracted_value
FROM state s
INNER JOIN mission_aspirations m2 
ON s.ResponseID = m2.ResponseID
GROUP BY s.state,s.Gender
ORDER BY s.state
)
SELECT state,
	SUM(CASE WHEN gender LIKE 'Female%' THEN extracted_value ELSE 0 END) AS female_avg_sal,
    SUM(CASE WHEN gender LIKE 'Male%' THEN extracted_value ELSE 0 END) AS male_avg_sal
from avg_salary
group by 1;



/*  18 . What is the Average Higher Bar salary expectations at 5 year mark for
state in India each gender and each state in India */ 
WITH state AS (
SELECT ResponseID, Gender,
    CASE
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '11' AND '11' THEN 'Delhi'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '12' AND '13' THEN 'Haryana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '14' AND '16' THEN 'Punjab'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '17' AND '17' THEN 'Himachal Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '18' AND '19' THEN 'Jammu & Kashmir'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '20' AND '28' THEN 'Uttar Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '30' AND '34' THEN 'Rajasthan'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '36' AND '39' THEN 'Gujarat'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '40' AND '44' THEN 'Maharashtra'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '45' AND '48' THEN 'Madhya Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) = '49' THEN 'Chhattisgarh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '50' AND '53' THEN 'Andhra Pradesh / Telangana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '56' AND '59' THEN 'Karnataka'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '60' AND '64' THEN 'Tamil Nadu'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '67' AND '69' THEN 'Kerala'
        WHEN SUBSTRING(zipcode, 1, 3) = '682' THEN 'Lakshadweep'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '70' AND '74' THEN 'West Bengal'
        WHEN SUBSTRING(zipcode, 1, 3) = '744' THEN 'Andaman & Nicobar'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '75' AND '77' THEN 'Orissa'
        WHEN SUBSTRING(zipcode, 1, 2) = '78' THEN 'Assam'
        WHEN SUBSTRING(zipcode, 1, 2) = '79' THEN 'Arunachal Pradesh / Manipur / Meghalaya / Mizoram / Nagaland / Tripura'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '80' AND '85' THEN 'Bihar / Jharkhand'
        ELSE 'Unknown'
    END AS state
FROM personalized_info
),
avg_salary as(
SELECT s.state,s.Gender,
      avg(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary5Years,'to',-1),'k',1)AS signed)) AS extracted_value
FROM state s
INNER JOIN mission_aspirations m2 
ON s.ResponseID = m2.ResponseID
GROUP BY s.state,s.Gender
ORDER BY s.state
)
SELECT state,
	SUM(CASE WHEN gender LIKE 'Female%' THEN extracted_value ELSE 0 END) AS female_avg_sal,
    SUM(CASE WHEN gender LIKE 'Male%' THEN extracted_value ELSE 0 END) AS male_avg_sal
from avg_salary
group by 1;


-- 19. Give a detailed breakdown of the possibility of Genz working for an Org if the "Mission is misaligned" for each state in India
WITH state AS (
SELECT ResponseID, Gender,
    CASE
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '11' AND '11' THEN 'Delhi'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '12' AND '13' THEN 'Haryana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '14' AND '16' THEN 'Punjab'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '17' AND '17' THEN 'Himachal Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '18' AND '19' THEN 'Jammu & Kashmir'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '20' AND '28' THEN 'Uttar Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '30' AND '34' THEN 'Rajasthan'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '36' AND '39' THEN 'Gujarat'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '40' AND '44' THEN 'Maharashtra'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '45' AND '48' THEN 'Madhya Pradesh'
        WHEN SUBSTRING(zipcode, 1, 2) = '49' THEN 'Chhattisgarh'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '50' AND '53' THEN 'Andhra Pradesh / Telangana'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '56' AND '59' THEN 'Karnataka'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '60' AND '64' THEN 'Tamil Nadu'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '67' AND '69' THEN 'Kerala'
        WHEN SUBSTRING(zipcode, 1, 3) = '682' THEN 'Lakshadweep'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '70' AND '74' THEN 'West Bengal'
        WHEN SUBSTRING(zipcode, 1, 3) = '744' THEN 'Andaman & Nicobar'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '75' AND '77' THEN 'Orissa'
        WHEN SUBSTRING(zipcode, 1, 2) = '78' THEN 'Assam'
        WHEN SUBSTRING(zipcode, 1, 2) = '79' THEN 'Arunachal Pradesh / Manipur / Meghalaya / Mizoram / Nagaland / Tripura'
        WHEN SUBSTRING(zipcode, 1, 2) BETWEEN '80' AND '85' THEN 'Bihar / Jharkhand'
        ELSE 'Unknown'
    END AS state
FROM personalized_info
),
mission as (
		SELECT s.state,s.Gender,
		SUM(CASE WHEN MisalignedMissionLikelihood like 'Will work%' THEN 1 ELSE 0 END) AS will_work,
        SUM(CASE WHEN MisalignedMissionLikelihood like 'Will NOT%' THEN 1 ELSE 0 END) AS willnot_work
FROM state s
INNER JOIN mission_aspirations m2
ON s.ResponseID=m2.ResponseID
GROUP BY s.state,s.Gender)
SELECT state,
SUM(CASE WHEN gender LIKE 'Female%' THEN will_work ELSE 0 END) AS female_willwork,
SUM(CASE WHEN gender LIKE 'Male%' THEN will_work ELSE 0 END) AS male_willwork,
SUM(CASE WHEN gender LIKE 'Female%' THEN willnot_work ELSE 0 END) AS female_willnotwork,
SUM(CASE WHEN gender LIKE 'Male%' THEN willnot_work ELSE 0 END) AS male_willnotwork
FROM mission
GROUP BY 1;		
