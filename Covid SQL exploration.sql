SELECT * FROM Covid_deaths WHERE continent is not null order by 3, 4; 
SELECT * FROM Covid_vaccine order by 3, 4; 

--Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population from Covid_deaths WHERE continent is not null order by 1,2;

--Looking at total cases vs total deaths
-- Shows likelihood of diying if you contract covid in your country
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100.0 as "Death percentage" from Covid_deaths WHERE location like'%Nicaragua%' order by 5 DESC;

--Looking at total cases vs Population
--Shows what percentage of population was infected with Covid
Select location, date, total_cases, population, (total_cases/population)*100 as "InfectedPopulationPercentage" 
from Covid_deaths 
WHERE continent is not null ORDER BY 1,2;


--Looking at countries with the highest infection rate compared to population
SELECT location, population, MAX(total_cases) as HighesInfectionRate, MAX((total_cases/population))*100 as PercentPopulationInfected 
FROM Covid_deaths WHERE continent is not null
--WHERE location like'%Nicaragua%'
group by location, population order by PercentPopulationInfected DESC;


--Showing countries with the Highest Death Count per Population

SELECT location, MAX(cast(total_deaths as int)) as TotalDeaths
FROM Covid_deaths
WHERE continent is not null
group by location
order by TotalDeaths DESC;


--Showing continents with the Highest Death Count per Population


SELECT continent, MAX(cast(total_deaths as int)) as TotalDeaths
FROM Covid_deaths
WHERE continent is not null
group by continent
order by TotalDeaths DESC;



--GLOBAL NUMBERS

--Death percentage around the world grouped by dates
SELECT date, SUM(new_cases) as Total_cases_Global, SUM(CAST(new_deaths AS int)) as Total_deaths_Global, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as Death_percentage_Global
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;


--Total death percentage around the world

SELECT SUM(new_cases) as Total_cases_Global, SUM(CAST(new_deaths AS int)) as Total_deaths_Global, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as Death_percentage_Global
FROM Covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


--Looking at total population vs vaccinations

--USE CTE

With PopulationVsVacc (continent, location, date, population, new_vaccinations, TotalVaccinations)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(new_vaccinations as bigint)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) as TotalVaccinations
FROM Covid_deaths dea 
JOIN  Covid_vaccine vac on dea.location=vac.location and dea.date=vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *, (TotalVaccinations/population)*100 as VaccinatedPeoplePercentage FROM PopulationVsVacc;


--TEMP TABLE
DROP TABLE IF exists PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
TotalVaccinations numeric
)

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(new_vaccinations as bigint)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) as TotalVaccinations
FROM Covid_deaths dea 
JOIN  Covid_vaccine vac on dea.location=vac.location and dea.date=vac.date
WHERE dea.continent IS NOT NULL

SELECT *, (TotalVaccinations/population)*100 as VaccinatedPeoplePercentage FROM PercentPopulationVaccinated


--Creating view to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(new_vaccinations as bigint)) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) as TotalVaccinations
FROM Covid_deaths dea 
JOIN  Covid_vaccine vac on dea.location=vac.location and dea.date=vac.date
WHERE dea.continent IS NOT NULL;