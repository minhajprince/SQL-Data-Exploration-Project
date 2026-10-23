# 🦠 COVID-19 Data Exploration using SQL (SSMS)

**A T-SQL project that imports raw COVID-19 Excel data into SQL Server and explores cases, deaths, and vaccinations across countries and continents.**

## Preview

![Data Exploration Queries](data%20exploration%20queries%20image.png)

![View in SQL](view%20in%20sql%20image.png)

## Project Overview

I imported two Excel files into a new SQL Server database and wrote queries to answer simple questions:

- How likely is death if someone gets COVID in a country (for example, India)?
- What percentage of a country's population got infected?
- Which countries and continents had the highest death counts?
- How many people were vaccinated over time?

## Key Insights

Based on data from **1 Jan 2020 to 30 Apr 2021** (210 countries, 81,060 rows):

| Metric | Result |
|---|---|
| Global cases | **about 150.6 million** |
| Global deaths | **about 3.18 million** |
| Global death percentage | **about 2.11%** |
| Highest infection rate | **Andorra**, about 17.1% of its population |
| Highest death count | **United States** (576,232), then Brazil and Mexico |
| India death percentage | **about 1.11%** (19.2M cases, 211,853 deaths) |

## How It Was Built

1. **Import:** Used the SSMS **Import and Export Wizard** to load `CovidDeaths.xlsx` and `CovidVaccinations.xlsx`.
2. **New database:** Created a new database, `PortfolioProject`, and loaded both files as tables (`CovidDeaths`, `CovidVaccinations`).
3. **Explore:** Wrote T-SQL queries on each table, then joined them on `location` and `date`.
4. **Store:** Saved the final vaccination query as a view, `PercentPopulationVaccinated`, for later use in dashboards.

### Source Data

![Data Table 1](data%20table%201.png)

![Data Table 2](data%20table%202.png)

## SQL Skills Used

- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`
- Aggregates: `SUM`, `MAX`
- `JOIN` across two tables
- Window function: `SUM() OVER (PARTITION BY ... ORDER BY ...)` for rolling vaccinations
- CTE (`WITH PopVsVac`)
- `CAST` / `CONVERT`, `ROUND`, `FORMAT`
- `CREATE VIEW`

## Files Included

| File | Description |
|---|---|
| `COVID Portfolio Project Data Exploratory using SQL.sql` | All T-SQL queries |
| `CovidDeaths.xlsx` | Cases, deaths, population (85,171 rows) |
| `CovidVaccinations.xlsx` | Vaccinations and tests (85,171 rows) |
| `data table 1.png`, `data table 2.png` | Source data previews |
| `data exploration queries image.png` | Queries running in SSMS |
| `view in sql image.png` | Output of the saved view |

## How to Use

1. Open SSMS and create a database named `PortfolioProject`.
2. Import both Excel files with **Tasks > Import Data**.
3. Open the `.sql` file and run the queries one by one.

## Tools

Microsoft SQL Server, SQL Server Management Studio (SSMS), T-SQL, Excel

## Author

**Minhaj Khan**
Data Analyst | SQL · Power BI · Excel

[LinkedIn](https://www.linkedin.com/in/minhaj-khan/) · [Portfolio](https://github.com/minhajprince)
