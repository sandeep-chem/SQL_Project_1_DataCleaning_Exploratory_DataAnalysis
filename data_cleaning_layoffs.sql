-- Data Cleaning

select *
from layoffs;

-- 1. Remove Duplicates if there are any
-- 2. Standardize the data
-- 3. Take care of NULL or Blank values
-- 4. Remove rows/columns that are unnecessary

drop table layoffs_staging;

-- create a new table same as the old table

create table layoffs_staging
LIKE layoffs;

-- check the new table schema
select *
from layoffs_staging;

-- insert all the data points from old/raw table
INSERT layoffs_staging
select *
from layoffs;

-- check the new table
select * from layoffs_staging;

-- we created a new table for staging as we are making changes in the staging stage
-- and we do no want to change the raw data. safe play.

-- no unique identifier rows such as layoff_id, hence removing duplicates won't be easy

with duplicates as (select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) as rn
from layoffs_staging)

select * 
from duplicates
where rn > 1;

-- we cannot directly use the delete statement in MySQL CTEs. It works like an update statement.

drop table layoffs_staging_2;

CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rn` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging_2;

INSERT INTO layoffs_staging_2
select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage,
country, funds_raised_millions) as rn
from layoffs_staging;

select * 
from layoffs_staging_2
where rn > 1;

SET SQL_SAFE_UPDATES = 0;

delete
from layoffs_staging_2
where rn > 1;

select * 
from layoffs_staging_2;

-- we have removed all duplicates

-- now we move on to standardizing data
-- finding issues in data and fixing it

select company, trim(company) -- trim removes whitespace in the ends
from layoffs_staging_2;

update layoffs_staging_2
set company = trim(company);

update layoffs_staging_2 -- we need to update the similar crypto industries into one.
set industry = "Crypto"
where industry like "Crypto%";

select distinct industry
from layoffs_staging_2
order by industry;

select distinct location
from layoffs_staging_2
order by 1;

select distinct country, trim(trailing '.' from country) -- specifiy trim to remove '.' at the end instead of white spaces
from layoffs_staging_2
order by 1;

update layoffs_staging_2
set country = trim(trailing '.' from country)
where country like 'United States%';

select date,
STR_TO_DATE(`date`, '%m/%d/%Y')  -- changing the date to the default SQL format, also converting its type
from layoffs_staging_2;

update layoffs_staging_2
set `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

select `date`
from layoffs_staging_2;

alter table layoffs_staging_2
modify column `date` DATE;

select *
from layoffs_staging_2;

-- working with null/blank values

select *
from layoffs_staging_2
where total_laid_off is null and percentage_laid_off is null;

update layoffs_staging_2
set industry = NULL
where industry = '';

select *
from layoffs_staging_2
where industry is null or
industry = '';

select *
from layoffs_staging_2
where company like 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging_2 as t1
join layoffs_staging_2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

select *
from layoffs_staging_2;

-- we cannot update the total_laid_off or percentage_laid_off values as we do not have enough data to populate those.
-- Similarly for funds_raised.

-- 4. Removing unnecessary rows/columns

select *
from layoffs_staging_2
where total_laid_off is null and percentage_laid_off is null;

delete
from layoffs_staging_2
where total_laid_off is null and percentage_laid_off is null;

select *
from layoffs_staging_2;

alter table layoffs_staging_2
drop column rn;

-- 1. Remove Duplicates if there are any
-- 2. Standardize the data
-- 3. Take care of NULL or Blank values
-- 4. Remove rows/columns that are unnecessary












