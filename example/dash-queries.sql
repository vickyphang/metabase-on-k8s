-- Count of Employees
-- Visual: Number
SELECT COUNT(EmpID) AS EmployeeCount
FROM hr_analytics;

-- Count of Attrition
-- Visual: Number
SELECT COUNT(EmpID) AS AttritionCount
FROM hr_analytics
WHERE Attrition = 'Yes';

-- Attrition Rate
-- Visual: Number
SELECT 
    (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 1.0 / COUNT(empid)) * 100 AS "attrition_rate"
FROM hr_analytics;

-- Average of Age
-- Visual: Number
SELECT AVG(Age) AS AvgAge
FROM hr_analytics;

-- Average of Monthly Income
-- Visual: Number
SELECT AVG(MonthlyIncome) AS AvgMonthlyIncome
FROM hr_analytics;

-- Average of Years at Company
-- Visual: Number
SELECT AVG(YearsAtCompany) AS AvgYearsAtCompany
FROM hr_analytics;

-- Attrition by Educational Field
-- Visual: Pie
SELECT 
    EducationField, 
    COUNT(EmpID) AS AttritionCount
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY EducationField;

-- Attrition by Job Role
-- Visual: Bar
SELECT 
    JobRole, 
    COUNT(EmpID) AS AttritionCount
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY JobRole;

-- Attrition by Salary Slab
-- Visual: Bar
SELECT 
    SalarySlab, 
    COUNT(EmpID) AS AttritionCount
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY SalarySlab;

-- Attrition by Age Group
-- Visual: Bar
SELECT 
    AgeGroup, 
    COUNT(EmpID) AS AttritionCount
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY AgeGroup
ORDER BY AgeGroup;

-- Age Distribution
-- Visual: Line
SELECT 
    Age, 
    COUNT(EmpID) AS EmployeeCount
FROM hr_analytics
GROUP BY Age
ORDER BY Age;