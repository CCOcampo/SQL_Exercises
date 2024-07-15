/* 1.
How many people per country are vaccinated in different dates 
and what percentage of the population do they represent?
*/

WITH popvsvac (continent, location, date, population, new_vaccinations, vac_population)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) 
	AS vac_population
	
	
FROM covid_deaths dea
JOIN covid_vaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent IS NOT null
ORDER BY 2,3
)

SELECT *, (vac_population/population)*100 AS total_vac_pop
FROM popvsvac
WHERE new_vaccinations IS NOT null AND location = 'Colombia';