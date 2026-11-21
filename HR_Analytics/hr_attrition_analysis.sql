DROP DATABASE IF EXISTS hr_analytics;
CREATE DATABASE hr_analytics;
USE hr_analytics;

CREATE TABLE hr_attrition (
  Age INT,
  Attrition VARCHAR(5),
  BusinessTravel VARCHAR(30),
  DailyRate INT,
  Department VARCHAR(50),
  DistanceFromHome INT,
  Education INT,
  EducationField VARCHAR(50),
  EmployeeCount INT,
  EmployeeNumber INT PRIMARY KEY,
  EnvironmentSatisfaction INT,
  Gender VARCHAR(10),
  HourlyRate INT,
  JobInvolvement INT,
  JobLevel INT,
  JobRole VARCHAR(50),
  JobSatisfaction INT,
  MaritalStatus VARCHAR(20),
  MonthlyIncome INT,
  MonthlyRate INT,
  NumCompaniesWorked INT,
  Over18 VARCHAR(5),
  OverTime VARCHAR(5),
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
  YearsWithCurrManager INT
);

SELECT COUNT(*) FROM hr_attrition;   -- expect 1470
SELECT Attrition, COUNT(*) FROM hr_attrition GROUP BY Attrition;

SELECT COUNT(DISTINCT EmployeeCount) AS ec,
       COUNT(DISTINCT Over18) AS o18,
       COUNT(DISTINCT StandardHours) AS sh
FROM hr_attrition;

USE hr_analytics;
ALTER TABLE hr_attrition
  DROP COLUMN EmployeeCount,
  DROP COLUMN Over18,
  DROP COLUMN StandardHours;
  
  SELECT
  MIN(Age), MAX(Age),
  MIN(MonthlyIncome), MAX(MonthlyIncome),
  MIN(YearsAtCompany), MAX(YearsAtCompany)
FROM hr_attrition;

SELECT DISTINCT Attrition FROM hr_attrition;      
SELECT DISTINCT OverTime FROM hr_attrition;      
SELECT DISTINCT Department FROM hr_attrition;     
SELECT DISTINCT BusinessTravel FROM hr_attrition;

USE hr_analytics;

CREATE OR REPLACE VIEW hr_clean AS
SELECT
  EmployeeNumber,
  Age,
  CASE WHEN Age < 25 THEN 'Under 25'
       WHEN Age < 35 THEN '25-34'
       WHEN Age < 45 THEN '35-44'
       WHEN Age < 55 THEN '45-54'
       ELSE '55+' END AS AgeGroup,
  Gender,
  MaritalStatus,
  Attrition,
  CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END AS AttritionFlag,

  Department,
  JobRole,
  JobLevel,
  BusinessTravel,
  OverTime,
  DistanceFromHome,
  EducationField,
  Education AS EducationSort,
  CASE Education
    WHEN 1 THEN 'Below College' WHEN 2 THEN 'College'
    WHEN 3 THEN 'Bachelor'      WHEN 4 THEN 'Master'
    WHEN 5 THEN 'Doctor' END AS EducationLevel,

  EnvironmentSatisfaction AS EnvSatSort,
  CASE EnvironmentSatisfaction
    WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'High' WHEN 4 THEN 'Very High' END AS EnvironmentSatisfactionLabel,

  JobInvolvement AS JobInvSort,
  CASE JobInvolvement
    WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'High' WHEN 4 THEN 'Very High' END AS JobInvolvementLabel,

  JobSatisfaction AS JobSatSort,
  CASE JobSatisfaction
    WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'High' WHEN 4 THEN 'Very High' END AS JobSatisfactionLabel,

  RelationshipSatisfaction AS RelSatSort,
  CASE RelationshipSatisfaction
    WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'High' WHEN 4 THEN 'Very High' END AS RelationshipSatisfactionLabel,

  WorkLifeBalance AS WLBSort,
  CASE WorkLifeBalance
    WHEN 1 THEN 'Bad' WHEN 2 THEN 'Good'
    WHEN 3 THEN 'Better' WHEN 4 THEN 'Best' END AS WorkLifeBalanceLabel,

  PerformanceRating AS PerfSort,
  CASE PerformanceRating
    WHEN 1 THEN 'Low' WHEN 2 THEN 'Good'
    WHEN 3 THEN 'Excellent' WHEN 4 THEN 'Outstanding' END AS PerformanceLabel,
    MonthlyIncome,
  CASE WHEN MonthlyIncome < 3000 THEN 'Low'
       WHEN MonthlyIncome < 7000 THEN 'Mid'
       ELSE 'High' END AS IncomeBand,
  PercentSalaryHike,
  StockOptionLevel,
TotalWorkingYears,
  NumCompaniesWorked,
  TrainingTimesLastYear,
  YearsAtCompany,
  CASE WHEN YearsAtCompany <= 2 THEN '0-2 yrs'
       WHEN YearsAtCompany <= 5 THEN '3-5 yrs'
       WHEN YearsAtCompany <= 10 THEN '6-10 yrs'
       ELSE 'Over 10 yrs' END AS TenureBand,
  YearsInCurrentRole,
  YearsSinceLastPromotion,
  CASE WHEN YearsSinceLastPromotion <= 1 THEN '0-1 yrs'
       WHEN YearsSinceLastPromotion <= 4 THEN '2-4 yrs'
       ELSE '5+ yrs' END AS PromotionGapBand,
  YearsWithCurrManager
FROM hr_attrition;

SELECT COUNT(*) FROM hr_clean;  -- crosschecking

SELECT JobSatisfactionLabel, COUNT(*) AS Employees,
       ROUND(AVG(AttritionFlag)*100,1) AS AttritionRate
FROM hr_clean
GROUP BY JobSatisfactionLabel, JobSatSort
ORDER BY JobSatSort;

USE hr_analytics;
SELECT * FROM hr_clean;