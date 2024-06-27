use corona;
select * from corona_datasets;

-- Q1. Write a code to check NULL values

select 
count(*) as null_count from corona_datasets
where Province is null or Country is null or Latitude is null or Longitude is null or Date is null or confirmed is null or
deaths is null or Recovered is null;

#Q2. If NULL values are present, update them with zeros for all columns. 
   #  THERE IS NO NULL VALUE IN THE DATSET.

-- Q3. check total number of rows

select
count(*) as total_rows from corona_datasets;

-- Q4. Check what is start_date and end_date

SELECT
    MIN(STR_TO_DATE(Date, '%d-%m-%Y')) AS start_date,
    MAX(STR_TO_DATE(Date, '%d-%m-%Y')) AS end_date
FROM corona_datasets;

-- Q5. Number of month present in dataset

SELECT COUNT(DISTINCT DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m')) AS num_months
FROM corona_datasets;

-- Q6. Find monthly average for confirmed, deaths, recovered

SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m') AS month_year,
    AVG(CONVERT(Confirmed, UNSIGNED)) AS avg_confirmed,
    AVG(CONVERT(Deaths, UNSIGNED)) AS avg_deaths,
    AVG(CONVERT(Recovered, UNSIGNED)) AS avg_recovered
FROM corona_datasets
GROUP BY month_year;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month

SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month_year,
    SUBSTRING_INDEX(GROUP_CONCAT(Confirmed ORDER BY cnt_confirmed DESC), ',', 1) AS most_frequent_confirmed,
    SUBSTRING_INDEX(GROUP_CONCAT(Deaths ORDER BY cnt_deaths DESC), ',', 1) AS most_frequent_deaths,
    SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY cnt_recovered DESC), ',', 1) AS most_frequent_recovered
FROM (
    SELECT 
        Date,
        Confirmed,
        Deaths,
        Recovered,
        COUNT(*) AS cnt,
        COUNT(Confirmed) AS cnt_confirmed,
        COUNT(Deaths) AS cnt_deaths,
        COUNT(Recovered) AS cnt_recovered
    FROM corona_datasets
    GROUP BY date, Confirmed, Deaths, Recovered
) AS subquery
GROUP BY month_year;

-- Q8. Find minimum values of confirmed, deaths, recovered per year

SELECT 
    YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) AS year,
    MIN(CONVERT(Confirmed, UNSIGNED)) AS min_confirmed,
    MIN(CONVERT(Deaths, UNSIGNED)) AS min_deaths,
    MIN(CONVERT(Recovered, UNSIGNED)) AS min_recovered
FROM corona_datasets
GROUP BY YEAR(STR_TO_DATE(Date, '%Y-%m-%d'));

-- Q9. Find maximum values of confirmed, deaths, recovered per year

SELECT 
    YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) AS year,
    MAX(CONVERT(Confirmed, UNSIGNED)) AS max_confirmed,
    MAX(CONVERT(Deaths, UNSIGNED)) AS max_deaths,
    MAX(CONVERT(Recovered, UNSIGNED)) AS max_recovered
FROM corona_datasets
GROUP BY YEAR(STR_TO_DATE(Date, '%Y-%m-%d'));

-- Q10. The total number of case of confirmed, deaths, recovered each month

SELECT 
    DATE_FORMAT(STR_TO_DATE(DATE, '%Y-%m-%d'), '%Y-%m') AS month_year,
    SUM(CONVERT(Confirmed, UNSIGNED)) AS total_confirmed,
    SUM(CONVERT(Deaths, UNSIGNED)) AS total_deaths,
    SUM(CONVERT(Recovered, UNSIGNED)) AS total_recovered
FROM corona_datasets
GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m');

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total confirmed cases
SELECT
DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month_year,
SUM(CONVERT(Confirmed, UNSIGNED)) AS total_confirmed_cases, 
AVG(CONVERT(Confirmed, UNSIGNED)) AS average_confirmed_cases,
VARIANCE(CONVERT(Confirmed, UNSIGNED)) AS variance_confirmed_case,
STDDEV(CONVERT(Confirmed, UNSIGNED)) AS std_dev_confirmed_cases
FROM  corona_datasets
GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m');


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

-- Calculate total death cases per month
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month_year,
    SUM(CONVERT(Deaths, UNSIGNED)) AS total_death_cases,
    AVG(CONVERT(Deaths, UNSIGNED)) AS average_death_cases,
    VARIANCE(CONVERT(Deaths, UNSIGNED)) AS variance_death_cases,
    STDDEV(CONVERT(Deaths, UNSIGNED)) AS std_dev_death_cases
FROM corona_datasets
GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m');

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
-- Calculate total recovered cases
SELECT 
DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m') AS month_year,
    SUM(CONVERT(Recovered, UNSIGNED)) AS total_recovered_cases, 
    AVG(CONVERT(Recovered, UNSIGNED)) AS average_recovered_cases,
    VARIANCE(CONVERT(Recovered, UNSIGNED)) AS variance_recovered_cases,
    STDDEV(CONVERT(Recovered, UNSIGNED)) AS std_dev_recovered_cases
FROM corona_datasets
GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%Y-%m-%d'), '%Y-%m');

-- Q14. Find Country having highest number of the Confirmed case

SELECT Country, MAX(CONVERT(Confirmed, UNSIGNED)) AS max_confirmed_cases
FROM corona_datasets
GROUP BY Country
ORDER BY max_confirmed_cases DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case

SELECT Country, MIN(CONVERT(Deaths, UNSIGNED)) AS min_death_cases
FROM corona_datasets
WHERE Deaths IS NOT NULL
GROUP BY Country
ORDER BY min_death_cases ASC
LIMIT 1;



#Q16. Find top 5 countries having highest recovered case

SELECT 
    Country,
    SUM(CONVERT(Recovered, UNSIGNED)) AS total_recovered_cases
FROM 
    corona_datasets
GROUP BY 
    Country
ORDER BY 
    total_recovered_cases DESC
LIMIT 5;




 







