-- Create table
CREATE TABLE hr_analytics (
    EmpID VARCHAR(255),
    Age INT,
    AgeGroup VARCHAR(255),
    Attrition VARCHAR(255),
    BusinessTravel VARCHAR(255),
    DailyRate INT,
    Department VARCHAR(255),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(255),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(255),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(255),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(255),
    MonthlyIncome INT,
    SalarySlab VARCHAR(255),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(255),
    OverTime VARCHAR(255),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager FLOAT
);

-- Load csv data into postgres
\copy hr_analytics FROM 'hr-analytics.csv' with (format csv, header true);