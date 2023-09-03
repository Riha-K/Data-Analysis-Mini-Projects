
create database jobdata;
use jobdata;
-- ques 1: Calculate the number of jobs reviewed per hour per day for November 2020?

select ds as Date_,count(job_id) as Job_count, sum(time_spent)/3600 as Hours_spent 
from data_table  
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by ds;

-- ques 2:Calculate 7 day rolling average of throughput? 
SELECT ds, time_spent,
avg(time_spent) over(order by ds rows between 6 preceding and current row) as rolling_avg
FROM data_table
order by ds;

-- ques 3:Calculate the percentage share of each language in the last 30 days?
select ds as date_, language, time_spent, time_spent * 100/(select sum(time_spent) from data_table)  
as 'percentage share of language'
from data_table
where ds >='2020-11-01'  and ds <='2020-11-30'  
order by date_;


select  language, 
sum(time_spent) as total_time_per_language,
sum(time_spent) over(order by language rows between unbounded preceding and unbounded following ) as total_time,
'total_time_per_language'*100/ 'total_time' as 'percentage share of language'
from data_table
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by language;

select  language, 
sum(time_spent) as 'languaget',
sum(time_spent) over(order by language rows between unbounded preceding and unbounded following ) as total_time,
'languaget' * 100/ (select sum(time_spent) over(order by language rows between unbounded preceding and unbounded following )) as 'percentage share of language'
from data_table
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by language;

SELECT language,
sum(time_spent) as total_time_per_language,
sum(time_spent) over(order by language rows between unbounded preceding and unbounded following ) as total_time,
sum(time_spent)* 100.0 / sum(time_spent) Over() as 'percentage share of language'
FROM data_table
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by language;

-- que 4:Rows that have the same value present in them.
-- Your task: Let’s say you see some duplicate rows in the data. How will you display duplicates from the table?







