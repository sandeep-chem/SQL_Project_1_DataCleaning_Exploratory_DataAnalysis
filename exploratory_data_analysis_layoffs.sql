select *
from layoffs_staging_2;

-- Exploratory Data Analysis

select max(total_laid_off), max(percentage_laid_off) -- Finding the maximum laid_offs and companies which went under completely
from layoffs_staging_2;

select *
from layoffs_staging_2 
where percentage_laid_off = 1
order by total_laid_off desc; -- companies which completely went under, ordered by the no of people they laid off

select *
from layoffs_staging_2
where percentage_laid_off = 1
order by funds_raised_millions desc; -- companies which completely went under, ordered by the amount of funds raised

select company, sum(total_laid_off) -- finding the total amount of lay offs based on the company
from layoffs_staging_2
group by company
order by 2 desc;

select min(`date`), max(`date`) -- finding the date range of the data
from layoffs_staging_2;

select industry, sum(total_laid_off) -- finding the total lay offs based on the industry
from layoffs_staging_2
group by industry
order by 2 desc;

select *
from layoffs_staging_2;

select country, sum(total_laid_off) -- finding the total lay offs based on the country
from layoffs_staging_2
group by country
order by 2 desc;

select year(`date`), sum(total_laid_off) -- 
from layoffs_staging_2
group by year(`date`) 
order by 1 desc;

select stage, sum(total_laid_off) -- 
from layoffs_staging_2
group by stage
order by 2 desc;

select company, avg(percentage_laid_off) -- finding the total amount of lay offs based on the company
from layoffs_staging_2
group by company
order by 2 desc;

select SUBSTRING(`date`, 1, 7) as `month`, sum(total_laid_off)
from layoffs_staging_2
where SUBSTRING(`date`, 1, 7) is not null
group by `month`
order by 1;

with rolling_total as (select SUBSTRING(`date`, 1, 7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging_2
where SUBSTRING(`date`, 1, 7) is not null
group by `month`
order by 1)
select `month`, total_off, sum(total_off) over (order by `month`) as total_rolling_lay_off
from rolling_total;

select company, year(`date`) as `year`, sum(total_laid_off) -- finding the total amount of lay offs based on the company
from layoffs_staging_2
group by company, `year`
order by 2;

select company, year(`date`) as `year`, sum(total_laid_off) -- finding the total amount of lay offs based on the company
from layoffs_staging_2
group by company, `year`
order by 3 desc;

with company_year (company, years, total_laid_off) as
(select company, year(`date`) as `year`, sum(total_laid_off) -- finding the total amount of lay offs based on the company
from layoffs_staging_2
group by company, `year`
order by 3 desc),

company_year_rank as(
select *, 
dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null)

select * 
from company_year_rank
where ranking <= 5;
