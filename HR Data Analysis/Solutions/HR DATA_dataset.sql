SELECT * FROM general_data$;
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