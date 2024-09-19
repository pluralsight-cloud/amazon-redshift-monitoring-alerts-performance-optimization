-- Create a function to evaluate the greater of two numbers
create function bigger_of_two_values (a float, b float)
  returns float
stable
as $$
  if a > b:
    return a
  return b
$$ language plpythonu;

-- Figure out what the commission would be for each sale when
-- the team meets a monthly goal. They get 20% of the price paid
-- or the contracted commission, whichever is greater
select
    which_is_bigger (commission, pricepaid*0.20) as team_goal_commission,
    commission as conracted_commission,
    pricepaid * 0.20 as premium_commission
from sales;

