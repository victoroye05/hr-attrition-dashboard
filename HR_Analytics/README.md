# HR Attrition Dashboard

This project looks at employee attrition: who leaves a company, how long they stay before they go, and which factors show up most among the people who leave. I cleaned the data in MySQL, did a first check in Excel, and built a five-page dashboard in Power BI.

## The data

The data is the IBM HR Analytics Employee Attrition & Performance dataset from Kaggle. It has 1,470 employees and 35 columns covering age, department, job role, income, overtime, business travel, satisfaction scores, and years at the company. The dataset is fictional, so the findings describe this data and not a real organisation.

## What I did

**1. Cleaning and preparation in MySQL**
- Created a database and a table for the raw data and loaded the CSV into it.
- Checked the row count (1,470), the employee IDs, and the data types.
- Dropped three columns that hold the same value for every employee: `EmployeeCount`, `Over18` and `StandardHours`.
- Built a view called `hr_clean` that turns the number codes into readable labels (for example, job satisfaction 1 to 4 becomes Low, Medium, High, Very High) and adds groupings for age, income, tenure and years since last promotion.
- Added an `AttritionFlag` column (1 for Yes, 0 for No) so attrition can be averaged into a rate.

**2. Quick checks in Excel**
I opened the raw data in Excel first to get a feel for it and to spot anything odd before moving to SQL.

**3. Dashboard in Power BI**
I exported `hr_clean` as a CSV, loaded it into Power BI, set the sort order for the label columns, wrote the measures, and built the pages below.

## Dashboard pages

- **Overview:** headcount, attrition count, attrition rate, average monthly income and average tenure, with attrition by job role, overtime, age group and tenure band.
- **Drivers:** attrition by business travel, marital status, job level and distance from home.
- **Pay:** income by job role, income of stayers compared with leavers, and attrition by income band and stock option level.
- **Satisfaction:** attrition by job satisfaction, environment satisfaction, work-life balance and relationship satisfaction.
- **Tenure:** attrition by tenure band, years since last promotion plus average tenure by department.

Every page has slicers for department, job role, gender and marital status. In each chart the bar that matters most is shown in red.

## Measures used

```
Total Employees = COUNTROWS(hr_clean)
Attrition Count = CALCULATE(COUNTROWS(hr_clean), hr_clean[Attrition] = "Yes")
Attrition Rate = DIVIDE([Attrition Count], [Total Employees])
Avg Monthly Income = AVERAGE(hr_clean[MonthlyIncome])
Avg Tenure = AVERAGE(hr_clean[YearsAtCompany])
```

## What the data showed

- 237 of the 1,470 employees left, an attrition rate of 16.1%.
- Employees who work overtime left at about 30.5%, against about 10.4% for those who do not.
- Sales Representatives had the highest attrition of any job role, at roughly 40%.

## Possible solutions

These are in order of priority. The data shows links between these factors and attrition, not proven causes, so each one is a starting point to test and not a guaranteed fix.

1. **Deal with overtime first.** Employees who work overtime left at 30.5%, compared with 10.4% for those who do not. This is the biggest gap in the data and the easiest one to act on. Overtime should come with real perks, such as extra pay or time off in return, or the extra work should be shared across the team so the same people are not carrying it all the time. A good place to start is the job roles with the most overtime and the highest attrition: Sales-Representative Role   .

2. **Review pay in the department with the most attrition.** Sales Department had the highest attrition, at 34% and its average monthly income was 2.6k against a company average of 6.5k. If that gap holds up, adjusting salaries there is the next step. Leavers earn noticeably less than stayers. The lowest income band and employees with no stock options show the highest attrition.

3. **Support employees under 25 and give everyone a clearer path to grow.** Attrition was highest in the under-25 group, at 39.2%, and these employees are mostly in entry-level roles at 26.3%. Mentoring, a visible promotion path and a friendly working environment for every age group would give younger employees a reason to stay, and the same changes help the other age groups too, since people leave in every group.

## How to measure success

Track the attrition rate each quarter for three groups: overtime workers, the department with the highest attrition, and employees under 25. The aim is to bring each one closer to the company average of 16.1%.

## Files in this project

| File | What it is |
|---|---|
| `HR_Attrition_Dashboard.pbix` | The Power BI report |
| `HR_Attrition_Dashboard.pdf` | A PDF export of all five pages |
| `hr_attrition_analysis.sql` | The MySQL script: table, load, cleaning and the `hr_clean` view |
| `HR_Attrition_Data.csv` | The Excel file used for the first look at the data |

## How to open it

- **Dashboard:** open the `.pbix` file in Power BI Desktop, which is free to download.
- **SQL script:** run it in MySQL Workbench. In the `LOAD DATA` line, change the file path to wherever you saved the dataset on your computer.
- **Original data:** search for "IBM HR Analytics Employee Attrition & Performance" on Kaggle and download the CSV from the Data tab.

## Tools

MySQL Workbench, Microsoft Excel, Power BI Desktop

## Contact

OYEDIRAN OLUWASEYI
LinkedIn:    https://www.linkedin.com/in/oluwaseyi-oyediran-b8299a185?utm_source=share_via&utm_content=profile&utm_medium=member_android
oyediranoluwaseyi18@gmail.com
