/* 1.

Select every columns in my table where the continent columns doesn't have any
null value and then, order it by the thirht and fouthr columns */

SELECT *
FROM covid_deaths
WHERE continent IS NOT null
ORDER BY 3,4

/* 2. 

Looking at total cases vs total deaths (death_rate) */ 

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_rate
FROM covid_deaths
WHERE location like '%States%' and continent IS NOT null
ORDER BY 2  


/* 3.

Looking at total cases vs population */

SELECT location, date, total_cases, population, (total_cases/population)*100 AS death_population_rate
FROM covid_deaths
WHERE location like '%States%' and continent IS NOT null
ORDER BY death_population_rate DESC

/* 4.
	
What country have the highest infection rate compared to population */
	
SELECT location, population, MAX(total_cases) AS highestinfectioncount, 
	MAX(total_cases/population)*100 AS perecentpopulationinfected
FROM covid_deaths
WHERE continent IS NOT null
GROUP BY location, population
ORDER BY perecentpopulationinfected DESC

/* 4.
	
Showing countreis with the highest death count per population */

SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS null
GROUP BY location
ORDER BY total_death_count DESC

/* 5.
	
Showing countreis with the highest death count per continent */

SELECT continent, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NOT null
GROUP BY continent
ORDER BY total_death_count DESC

/* 6.
	
Global numbers of new cases and total cases */

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,
		(SUM(new_deaths)/SUM(new_cases))*100 AS deathpercentage
FROM covid_deaths
WHERE continent IS NOT null
GROUP BY date
HAVING SUM(new_cases) <> 0
ORDER BY 3 ASC