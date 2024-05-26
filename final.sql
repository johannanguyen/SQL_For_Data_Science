/* Scenario: 
Data Scientist at USDA (United States Department of Agriculture)

Context: 
You are a Data Scientist working at the USDA. Your department has been tracking the production of various agricultural commodities across different states. 

Your datasets include:
`milk_production`, `cheese_production`, `coffee_production`, `honey_production`, `yogurt_production`, and a `state_lookup` table. 
The data spans multiple years and states, with varying levels of production for each commodity.
Your manager has requested that you generate insights from this data to aid in future planning and decision-making. You'll need to use SQL queries to answer the questions that come up in meetings, reports, or strategic discussions.

Objectives:
Assess state-by-state production for each commodity.
Identify trends or anomalies.
Offer data-backed suggestions for areas that may need more attention.

NOTE: All answer entries are numeric and only numbers and periods. The autograder does not accept commas for the final project.
*/

/*
Question 1
Can you find out the total milk production for 2023? Your manager wants this information for the yearly report.
What is the total milk production for 2023?

Answer: 91812000000
*/
SELECT SUM(Value) AS Total_Production
FROM milk_production
WHERE Year='2023'

/*
Question 2
Which states had cheese production greater than 100 million in April 2023? The Cheese Department wants to focus their marketing efforts there. 
How many states are there?
Answer: 2
*/
SELECT COUNT(DISTINCT State_ANSI) AS Num_States
FROM cheese_production
WHERE Value > 100000000 
AND Period = 'APR'
AND Year = '2023'
AND State_ANSI <> ""

/*
Question 3
Your manager wants to know how coffee production has changed over the years. 
What is the total value of coffee production for 2011?
Answer: 7600000
*/
SELECT SUM(Value) from coffee_production
WHERE Year=2011

/*
Question 4
There's a meeting with the Honey Council next week. Find the average honey production for 2022 so you're prepared.
Answer: 3133275
*/
SELECT AVG(Value) as Average
FROM honey_production
WHERE Year=2022

/*
Question 5
The State Relations team wants a list of all states names with their corresponding ANSI codes. Can you generate that list?
What is the State_ANSI code for Florida?
Answer: 12
*/
SELECT State_ANSI
FROM state_lookup
WHERE State='FLORIDA'

/*
Question 6
For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
What is the total for NEW JERSEY?
Answer: 4889000
*/
SELECT sl.State, cp.Value
FROM state_lookup sl
LEFT JOIN cheese_production cp
ON sl.State_ANSI = cp.State_ANSI AND cp.Year = 2023 AND cp.Period = 'APR'
WHERE cp.Value NOTNULL
ORDER BY sl.State_ANSI;

/*
Question 7
Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? This will help the Dairy Division in their planning.
Answer: 1171095000
*/
SELECT yp.Value
FROM yogurt_production yp
JOIN cheese_production cp ON yp.State_ANSI = cp.State_ANSI
WHERE yp.Year = 2022 AND cp.Year = 2023
GROUP BY yp.State_ANSI 

/*
Question 8
List all states from state_lookup that are missing from milk_production in 2023.
How many states are there?
Answer: 26
*/
SELECT COUNT(sl.State) AS Count
FROM state_lookup sl
LEFT JOIN milk_production mp
ON sl.State_ANSI = mp.State_ANSI 
AND mp.Year = 2023
WHERE mp.State_ANSI IS NULL

/*
Question 9
List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
Did Delaware produce any cheese in April 2023?
Answer: No
*/
SELECT sl.State,  cp.Value
FROM state_lookup sl
LEFT JOIN cheese_production cp
ON sl.State_ANSI = cp.State_ANSI 
AND cp.Year = 2023

/*
INCORRECT
Find the average coffee production for all years where the honey production exceeded 1 million.
Answer: 7,170,000
*/
SELECT AVG(cp.Value) AS average_coffee_production
FROM coffee_production cp
JOIN honey_production hp ON cp.Year = hp.Year
WHERE hp.Value > 1000000;