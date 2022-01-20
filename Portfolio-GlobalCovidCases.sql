-- select *
select *
from acoviddeath_csv 
where continent is not NULL
order by location,date


-- select data to use
select location,date,total_cases,new_cases,total_deaths,population
from acoviddeath_csv 
where continent is not NULL
order by location,date

-- Looking at Total Cases vs Total Deaths
select location,date,total_cases,total_deaths,
(total_deaths/total_cases)*100 as deathpercentage
from acoviddeath_csv 


-- Looking at Total Cases vs Population
select location,total_cases,population,
(total_cases/population)*100 as infectedpercentage
from acoviddeath_csv
order by location

-- Looking at countries with highest infection rate compared to population
select location,max(total_cases)as higest_infection_count,population,
max((total_cases/population))*100 as percent_population_infected
from acoviddeath_csv 
group by continent,location,population 
order by percent_population_infected desc

-- Looking at countries with highest death count per population
select location,max(total_deaths)as MaxTotalDeathCount
from acoviddeath_csv 
where continent is not NULL
group by location,continent
order by MaxTotalDeathCount desc

-- Looking at continents with highest death count per population
select continent,max(total_deaths)as MaxTotalDeathCount
from acoviddeath_csv 
where continent is not NULL
group by continent
order by MaxTotalDeathCount DESC

-- looking at global numbers by date
select date, sum(new_cases)as TotalCases,sum(new_deaths) as TotalDeaths,
sum(new_deaths)/sum(new_cases)*100 as deathpercentage
from acoviddeath_csv 
where continent is not null
group by date

-- looking at grand total global numbers
select sum(new_cases)as TotalCases,sum(new_deaths) as TotalDeaths,
sum(new_deaths)/sum(new_cases)*100 as deathpercentage
from acoviddeath_csv 
where continent is not null

-- Looking at Total Population vs Vaccination
select dea.location,dea.date,dea.population,acv.new_vaccinations
from acoviddeath_csv dea
join acovidvaccination_csv  acv
on dea.location = acv.location
and dea.date = acv.date
where dea.continent is not null
order by date desc

-- creating views
create view percentagedeath as
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from acoviddeath_csv 
