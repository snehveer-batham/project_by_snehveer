**Problem Statement:**
Explore the company's gender, race/ethnicity, and age distribution to assess equity, enhance diversity, and customize HR initiatives for an inclusive workplace.

**Recommended Analysis:**
We collected a dataset of 22,000 rows, cleaned it using SQL and addressed 11 essential questions. Subsequently, we saved results in separate Excel files for each question. Using Power BI, we imported these files and created two dashboards with over 10 charts to showcase valuable insights.

**SQL Insights: Addressing 11 Business Questions**
Gender Breakdown: More male employees in the company.
Race/Ethnicity Breakdown: White is the most dominant, while Native Hawaiian and American Indian are the least.
Age Distribution: Ranges from 20 to 57 years, with various age groups represented.
Headquarters vs. Remote: Majority work at headquarters, especially in the 25-34 age group.
Average Length of Employment for Terminated Employees: Analysis not provided.
Gender Distribution Across Departments and Job Titles: Fairly balanced across departments; generally more males.
Distribution of Job Titles: Not explicitly provided in the insights.
Highest Turnover Rate: Marketing has the highest turnover, followed by Training.
Distribution of Employees Across Locations by State: A significant number from Ohio.
Employee Count Changes Over Time: The net change in employees increased over the years.
Tenure Distribution for Each Department: Average tenure is about 8 years, with Legal and Auditing having the highest.ble insights.

**Limitations:**
Certain records with negative ages (967 in total) were excluded during the querying process. Ages considered for analysis were 18 years and above. Additionally, term dates significantly distant into the future (1599 records) were omitted from the analysis. Only term dates less than or equal to the current date were utilized.
**Power BI Dashboard-I**
74.97% are at headquarters, and 25.03% are remote.
There are 50.97% males, 46.28% females, and 2.75% others.
28.53% identify as White in terms of race.
The state of Ohio has the highest number of employees.
There has been a 5.21% change in the number of employees.

**Power BI Dashboard-II**
28.62% belong to the age group of 26-35, representing the largest demographic.
Auditing exhibits the highest cumulative termination rate among departments.
The Engineering department has the highest gender distribution.
