-- set statement_timeout = 1000;

select
    event.eventname,
    sum(sales.pricepaid) as total_revenue,
    sum(sales.qtysold) as total_tickets
from event
join sales on sales.eventid = event.eventid
group by event.eventname;
