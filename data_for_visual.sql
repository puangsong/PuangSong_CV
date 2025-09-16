select Location, date, total_cases, new_cases, total_deaths, population
from portfolioproject.coviddeaths
ORDER BY location,
         STR_TO_DATE(date, '%m/%e/%Y');
-- ssdddddd
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolioproject.coviddeaths
where location like '%China%'
order by location,
         STR_TO_DATE(date, '%m/%e/%Y');
         
select Location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
from portfolioproject.coviddeaths
where location like '%China%'
order by location,
         STR_TO_DATE(date, '%m/%e/%Y');

select Location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentagePopulationInfected
from portfolioproject.coviddeaths
group by location, population
order by PercentagePopulationInfected desc;

select Location, max(total_deaths) as TotalDeathCount
from portfolioproject.coviddeaths
where continent is not null
group by location
order by TotalDeathCount desc;

select location, date, total_cases
from portfolioproject.coviddeaths
order by str_to_date(date, '%m/%e/%Y');

Select  SUM(new_cases) as total_cases, 
	SUM(cast(new_deaths as signed)) as total_deaths, SUM(cast(new_deaths as signed))/SUM(New_Cases)*100 as DeathPercentage, continent
From portfolioproject.coviddeaths
where continent is not null 
group by continent
order by 1, 2;




--- some SQL for data visualisation
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as signed)) as total_deaths, SUM(cast(new_deaths as signed)) / SUM(New_Cases)*100 as DeathPercentage
From portfolioproject.coviddeaths
where continent is not null 
order by 1,2;
--- all global deaths situation

Select location, SUM(cast(new_deaths as signed)) as TotalDeathCount
From portfolioproject.coviddeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;

--- specifically!!!
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolioproject.coviddeaths
Group by Location, Population
order by PercentPopulationInfected desc;


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max(total_cases)/population*100 as PercentPopulationInfected
From portfolioproject.coviddeaths
WHERE continent IS NOT NULL     
Group by Location, Population, date
order by PercentPopulationInfected desc;

SELECT
  location,
  MAX(population) OVER (PARTITION BY location)                                 AS population,
  `date`,
  CAST(total_cases AS SIGNED)                                                  AS total_cases,
  ROUND(
    CAST(total_cases AS SIGNED)
    / NULLIF(MAX(population) OVER (PARTITION BY location), 0) * 100
  , 4)                                                                          AS PercentPopulationInfected,
  -- 可选：该国历史峰值（方便对比）
  MAX(CAST(total_cases AS SIGNED)) OVER (PARTITION BY location)                 AS HighestInfectionCount
FROM portfolioproject.coviddeaths
WHERE continent IS NOT NULL
ORDER BY location, `date`;








