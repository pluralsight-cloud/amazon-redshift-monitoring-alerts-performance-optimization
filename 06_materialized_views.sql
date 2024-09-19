-- Creates a materialized view that contains all the cities
create materialized view user_cities_mv as
select distinct city
from users;

-- Refreshes the materialized view
refresh materialized view user_cities_mv;

-- Check current number of cities
select distinct count(*) from user_cities_mv;

-- Add new users with a new city
insert into users values (
    49991,
    'FMC2024A',
    'Fernando',
    'MC',
    'Bogota',
    'WA',
    'pluralsight.fernando@gmail.com',
    '(206) 555-1234',
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
);

-- Refresh the materialized view
refresh materialized view user_cities_mv;

-- See one more city added
select distinct count(*) from user_cities_mv;