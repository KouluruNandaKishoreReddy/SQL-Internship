SELECT * FROM general_data$;SELECT * FROM employee_survey_data;SELECT * FROM manager_survey_data;SELECT * FROM in_time;SELECT * FROM data_dictionary$;--.Retrieve the total number of employees in the dataset.SELECT COUNT(EmployeeID) As no_ofEmployees FROM general_data$;--  List all unique job roles in the dataset.SELECT DISTINCT(JobRole) FROM general_data$;-- Find the average age of employeesSELECT AVG(Age) FROM general_data$;--Retrieve the names and ages of employees who have worked at the company for more than 5 yearsSELECT [Emp Name],Age FROM general_data$ WHERE YearsAtCompany>5;--Get a count of employees grouped by their departmentSELECT COUNT(EmployeeID),Department FROM general_data$ GROUP BY Department;--List employees who have 'High' Job Satisfaction.SELECT general_data$.EmployeeID,[Emp Name],employee_survey_data.JobSatisfaction FROM general_data$ JOIN employee_survey_data ON general_data$.EmployeeID = employee_survey_data.EmployeeID ORDER BY JobSatisfaction DESC;--Find the highest Monthly Income in the dataset.SELECT MAX(MonthlyIncome) FROM general_data$;--List employees who have 'Travel_Rarely' as their BusinessTravel typeSELECT [Emp Name] FROM general_data$ WHERE BusinessTravel IN ('Travel_Rarely');--Retrieve the distinct MaritalStatus categories in the dataset.SELECT DISTINCT(MaritalStatus) FROM general_data$;-- Get a list of employees with more than 2 years of work experience but less than 4 years in their current role.SELECT [Emp Name] FROM general_data$ WHERE TotalWorkingYears IN(2,4);-- List employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job).SELECT [Emp Name] FROM general_data$ WHERE JobLevel!= JobLevel AND JobRole!=JobRole;--Find the average distance from home for employees in each departmentSELECT Department,AVG(DistanceFromHOME)AS Avg_Distance FROM general_data$ GROUP BY Department;--Retrieve the top 5 employees with the highest MonthlyIncome.SELECT  TOP 5  MonthlyIncome, [Emp Name] FROM general_data$ ORDER BY MonthlyIncome DESC ;-- Calculate the percentage of employees who have had a promotion in the last yearSELECT COUNT(*)*100/(SELECT COUNT(*) FROM general_data$) AS Promotion_percentage FROM general_data$WHERE YearsSinceLastPromotion=1;-- List the employees with the highest and lowest EnvironmentSatisfaction.SELECT EmployeeID,EnvironmentSatisfaction AS High_EnvironmentSatisfaction FROM employee_survey_dataWhere EnvironmentSatisfaction = 4 UNION ALLSELECT EmployeeID,EnvironmentSatisfaction AS Low_EnvironmentSatisfaction FROM employee_survey_dataWhere EnvironmentSatisfaction = 1 ;--Find the employees who have the same JobRole and MaritalStatusselect a.employeeid, a. jobrole, b.jobrole, a.maritalstatus, b.maritalstatus from general_data$ a join
general_data$ b on a.EmployeeID=b. EmployeeID
where a.JobRole=b.jobrole and a. MaritalStatus=b.MaritalStatus

--  List the employees with the highest TotalWorkingYears who also have a PerformanceRating of 4
SELECT general_data$.EmployeeID,general_data$.TotalWorkingYears,PerformanceRating FROM general_data$
JOIN manager_survey_data ON general_data$.EmployeeID =manager_survey_data.EmployeeID
WHERE manager_survey_data.PerformanceRating=4
ORDER BY general_data$.TotalWorkingYears DESC ;

--Calculate the average Age and JobSatisfaction for each BusinessTravel type.
SELECT E.BusinessTravel,AVG(E.Age) As Averageage,AVG(J.JobSatisfaction)AS Averagejobsatisfaction 
FROM general_data$ E
JOIN employee_survey_data J ON E.EmployeeID=J.EmployeeID
GROUP BY E.BusinessTravel;

-- Retrieve the most common EducationField among employees.
SELECT EducationField FROM general_data$ GROUP BY EducationField ORDER BY EducationField DESC;

-- List the employees who have worked for the company the longest but haven't had a promotion.
SELECT EmployeeID,MAX(YearsAtCompany)AS Maxnoofyears FROM general_data$ WHERE YearsSinceLastPromotion =0
GROUP BY EmployeeID ORDER BY Maxnoofyears DESC ;