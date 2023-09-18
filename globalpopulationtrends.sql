#POPULATION GROWTH

# Population growth rate from 2018 to 2021
SELECT
	p1.Country,
    ((p2.`Total Population` - p1.`Total Population`) / p1.`Total Population`) AS `2018-2021 Growth Rate`
FROM
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2018) AS p1
INNER JOIN
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2021) AS p2
ON p1.Country = p2.Country
ORDER BY (p2.`Total Population` - p1.`Total Population`) / p1.`Total Population` DESC;

# Countries with highest growth rate between 2018 and 2021
SELECT
	p1.Country,
    CONCAT((p2.`Total Population` - p1.`Total Population`) / p1.`Total Population`) AS `2018-2021 Growth Rate`
FROM
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2018) AS p1
INNER JOIN
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2021) AS p2
ON p1.Country = p2.Country
ORDER BY (p2.`Total Population` - p1.`Total Population`) / p1.`Total Population` DESC
LIMIT 10;

# Countries with lowest growth rate between 2018 and 2021
SELECT
	p1.Country,
    CONCAT((p2.`Total Population` - p1.`Total Population`) / p1.`Total Population`) AS `2018-2021 Growth Rate`
FROM
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2018) AS p1
INNER JOIN
	(SELECT Country, `Total Population` FROM population.trends WHERE Year = 2021) AS p2
ON p1.Country = p2.Country
ORDER BY (p2.`Total Population` - p1.`Total Population`) / p1.`Total Population` ASC
LIMIT 10;

#RURAL-URBAN TRENDS

# Urban vs. rural living between 2018 and 2021
SELECT
	Year,
    AVG(`Rural Population`) AS avg_rur_pop,
    AVG(`Urban Population`) AS avg_urb_pop,
    AVG(`Urban Population`)/AVG(`Rural Population`) AS urban_to_rural_ratio
FROM population.trends
GROUP BY Year
HAVING Year BETWEEN 2018 AND 2021;

# Urban growth rate between 2018 and 2021
SELECT
	Country,
    Urban_Population_2018,
    Urban_Population_2021,
    four_year_urban_growth
FROM(
	SELECT
		Country,
		#2018 urban population
		SUM(CASE WHEN Year = 2018 THEN `Urban Population` ELSE NULL END) AS Urban_Population_2018,
		#2021 urban population
		SUM(CASE WHEN Year = 2021 THEN `Urban Population` ELSE NULL END) AS Urban_Population_2021,
        #Urban growth rate
		(SUM(CASE WHEN Year = 2021 THEN `Urban Population` ELSE NULL END) /
         SUM(CASE WHEN Year = 2018 THEN `Urban Population` ELSE NULL END) - 1) AS four_year_urban_growth
	FROM population.trends
	GROUP BY Country)
AS subquery;

# Countries experiencing rapid urbanization (8% growth between 2018 and 2021)
SELECT
	Country,
    Urban_Population_2018,
    Urban_Population_2021,
    four_year_urban_growth
FROM(
	SELECT
		Country,
		#2018 urban population
		SUM(CASE WHEN Year = 2018 THEN `Urban Population` ELSE NULL END) AS Urban_Population_2018,
		#2021 urban population
		SUM(CASE WHEN Year = 2021 THEN `Urban Population` ELSE NULL END) AS Urban_Population_2021,
        #Urban growth rate
		(SUM(CASE WHEN Year = 2021 THEN `Urban Population` ELSE NULL END) /
         SUM(CASE WHEN Year = 2018 THEN `Urban Population` ELSE NULL END) - 1) AS four_year_urban_growth
	FROM population.trends
	GROUP BY Country)
AS subquery
WHERE four_year_urban_growth > .08;

#LIFE EXPECTANCY

# Life expectancy in 2017 compared to 2020
SELECT
	Country,
    2017_Life_Expectancy,
    2020_Life_Expectancy,
    2020_Life_Expectancy - 2017_Life_Expectancy AS Life_Expectancy_Change
FROM(SELECT
		Country,
        MAX(CASE WHEN Year = 2017 THEN `Life Expectancy` ELSE NULL END) AS 2017_Life_Expectancy,
        MAX(CASE WHEN Year = 2020 THEN `Life Expectancy` ELSE NULL END) AS 2020_Life_Expectancy
	 FROM population.trends
     GROUP BY Country
	)
AS subquery;

# Life expectancy compared to population density in 2017 vs. 2020
SELECT
	Country,
    2020_Life_Expectancy - 2017_Life_Expectancy AS Life_Expectancy_Change,
    2020_Population_Density - 2017_Population_Density AS Population_Density_Change
FROM(SELECT
		Country,
        MAX(CASE WHEN Year = 2017 THEN `Life Expectancy` ELSE NULL END) AS 2017_Life_Expectancy,
        MAX(CASE WHEN Year = 2020 THEN `Life Expectancy` ELSE NULL END) AS 2020_Life_Expectancy,
        MAX(CASE WHEN Year = 2017 THEN `Population Density` ELSE NULL END) AS 2017_Population_Density,
        MAX(CASE WHEN Year = 2020 THEN `Population Density` ELSE NULL END) AS 2020_Population_Density
	 FROM population.trends
     GROUP BY Country
	)
AS subquery;

#BIRTH AND DEATH RATES

# Comparison of birth rates, death rates, and total population in 2018 vs. 2021
SELECT
	Country,
    `Birth Rate`,
    `Death Rate`,
    `Birth Rate`/`Death Rate` AS `Births to Deaths Ratio`,
    `2021 Population` - `2018 Population` AS `2018-2021 Population Change`
FROM
	(SELECT
		Country,
		AVG(`Birth Rate`) AS `Birth Rate`,
		AVG(`Death Rate`) AS `Death Rate`,
		MAX(CASE WHEN Year = 2018 THEN `Total Population` ELSE NULL END) AS `2018 Population`,
        MAX(CASE WHEN Year = 2021 THEN `Total Population` ELSE NULL END) AS `2021 Population`
	FROM population.trends
    GROUP BY Country)
	AS subquery;

#Countries with the highest birth rates
SELECT
	Country,
    AVG(`Birth Rate`) AS Avg_Birth_Rate,
    AVG(`Death Rate`) AS Avg_Death_Rate
FROM population.trends
GROUP BY Country
ORDER BY Avg_Birth_Rate DESC
LIMIT 10;

#Countries with the highest death rates
SELECT
	Country,
    AVG(`Birth Rate`) AS Avg_Birth_Rate,
    AVG(`Death Rate`) AS Avg_Death_Rate
FROM population.trends
GROUP BY Country
ORDER BY Avg_Death_Rate DESC
LIMIT 10;

#FERTILITY AND INFANT MORTALITY RATES

#Comparison of fertility rates and infant mortality rates
SELECT
	Country,
	AVG(`Fertility Rate`) AS Avg_Fertility_Rate,
	AVG(`Infant Mortality Rate`) AS Avg_Infant_Mortality_Rate,
	AVG(`Infant Mortality Rate`)/AVG(`Fertility Rate`) AS Infant_Mortality_to_Fertility_Rate_Ratio
FROM population.trends
GROUP BY Country;
    
#Countries with highest fertility rates
SELECT
	Country,
    AVG(`Fertility Rate`) AS Avg_Fertility_Rate,
    AVG(`Infant Mortality Rate`) AS Avg_Infant_Mortality_Rate
FROM population.trends
GROUP BY Country
ORDER BY Avg_Fertility_Rate DESC
LIMIT 10;

#Countries with highest infant mortality rates
SELECT
	Country,
    AVG(`Fertility Rate`) AS Avg_Fertility_Rate,
    AVG(`Infant Mortality Rate`) AS Avg_Infant_Mortality_Rate
FROM population.trends
GROUP BY Country
ORDER BY Avg_Infant_Mortality_Rate DESC
LIMIT 10;

#POPULATION DENSITY

#Population density
SELECT Country, AVG(`Population Density`) AS Avg_Pop_Density
FROM population.trends
GROUP BY Country
ORDER BY Avg_Pop_Density DESC;