select * from CovidDeaths
order by 3,4

--select * from CovidVaccinations
--order by 3,4

--Data Overview
SELECT location, date, total_cases, new_cases, total_deaths, FORMAT(population,'N0') AS population
from CovidDeaths
WHERE continent is not null
order by 1,2



--Looking at Total Cases Vs Total Deaths
--Showing likelihood of dying if any one contract covid in the respected countries
SELECT location, date, total_cases, new_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2,3)  AS [Death%]
from CovidDeaths
WHERE Location = 'India'
AND continent is not null
order by 1,2


--Looking at total Cases Vs Population
--shows what % of population got covid
SELECT location, date, FORMAT(population,'N0') AS population, total_cases, ROUND((total_cases/population)*100,2,3)  AS PercentPopulationInfected
from CovidDeaths
WHERE continent is not null
--WHERE Location = 'India'
order by 1,2


-- Looking countries with highest infected rate to population
SELECT location, FORMAT(population,'N0') AS population, MAX(total_cases) AS HighestInfectionCount, ROUND((MAX(total_cases/population))*100,2,3)  AS PercentPopulationInfected
from CovidDeaths
group by location, population

--WHERE Location = 'India'
order by PercentPopulationInfected DESC


-- Showing Continent with highest death count per Population
SELECT location, MAX(cast(total_deaths as INT)) AS TotalDealthCount
from CovidDeaths
WHERE continent IS null
GROUP BY location
ORDER BY TotalDealthCount DESC

-- Showing Countries with highest death count per Population
SELECT location, MAX(cast(total_deaths as INT)) AS TotalDealthCount
from CovidDeaths
WHERE continent is not null
group by location
order by TotalDealthCount DESC



--GLOBAL NUMBERS
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS  DeathPercentage --total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2,3)  AS [Death%]
from CovidDeaths
--WHERE Location = 'India'
WHERE continent is not null
--group by date
order by 1,2



--New Table exploration (joining the tables together)
--Looking at Total Population vs Vaccinations

SELECT dea.location, FORMAT(SUM(dea.population),'N0') AS TotalPopulation , SUM(cast(vac.People_vaccinated AS BIGINT)) AS TotalVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
group by dea.location

--Rolling Total of vaccinations
SELECT dea.continent,  dea.location, dea.date, FORMAT(dea.population,'N0') AS Population, vac.new_vaccinations
,SUM(CAST(vac.new_vaccinations AS INT))  OVER (PARTITION BY  dea.location order by dea.date)  AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
order by 2,3
--group by dea.location


-- USE CTE
WITH PopVsVac  (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS (
SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations))  OVER (PARTITION BY  dea.location order by dea.date)  AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
--order by 2,3
)
select *, (RollingPeopleVaccinated / Population) * 100
from PopVsVac


--Creating view to store data later for Visualizations
create view  PercentPopulationVaccinated as 
SELECT dea.continent,  dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations))  OVER (PARTITION BY  dea.location order by dea.date)  AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 

--Results of View
select * 
from PercentPopulationVaccinated
