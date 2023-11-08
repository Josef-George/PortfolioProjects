select* 
from [Portfolio Project]..CovidDeaths
where continent is not null
order by 3,4



select*
from [Portfolio Project]..covidvaccinations
order by 3,4



select location, date, total_cases, new_cases, total_deaths, population
from [Portfolio Project]..coviddeaths
where continent is not null
order by 1,2



select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio Project]..coviddeaths
where location like '%state%'
and continent is not null
order by 1,2



select location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from [Portfolio Project]..coviddeaths
--where location like '%state%'
order by 1,2



select location, Population, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population))*100 as PercentPopulationInfected
from [Portfolio Project]..coviddeaths
Group by Location, Poulation
order by PercenPopulationInfected desc



select location,Max(cast(Total_deaths as int)) as TotaldeathCount
From [Portfolio Project]..CovidDeaths
--where location like '%state%'
where continent is not null
Group by location
Order by TotaldeathCount desc



select continent,Max(cast(Total_deaths as int)) as TotaldeathCount
From [Portfolio Project]..CovidDeaths
--where location like '%state%'
where continent is not null
Group by continent
Order by TotaldeathCount desc



select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
--where location like '%state%'
where continent is not null
--Group by date
Order by 1,2



select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From [Portfolio Project]..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3



with PopvsVac (Continent, Location, date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac



create view percentpopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3



select *
from percentpopulationVaccinated