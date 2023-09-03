create database case2;
use case2;
drop database case2;


select count(user_id) from events;

-- ques 1
select extract(week from occurred_at) as week_ , count(distinct user_id) as active_users
from events
where event_type = 'engagement' and event_name = 'login'
group by 1
order by 1;

-- ques 2
select extract(day from created_at) as day_,
count(*) as user_count,
count(case when activated_at is not null then user_id else null end) as activated_user_count
from users
where created_at >= '2012-04-01'and created_at < '2012-04-30'
group by 1
order by 1;

-- ques 3

select extract(week from a.occurred_at) as week_, avg (a.age_at_event) as avg_age_durig_week,
count(distinct case when a.user_age > 70 then a.user_id else null end) as '10+ weeks', 
count(distinct case when a.user_age < 70 and a.user_age >=63 then a.user_id else null end) as '9 weeks', 
count(distinct case when a.user_age < 63 and a.user_age >-56 then a.user_id else null end) as '8 weeks', 
count(distinct case when a.user_age < 56 and a.user_age >-49 then a.user_id else null end) as '17 weeks',
count(distinct case when a.user_age < 49 and a.user_age >=42 then a.user_id else null end) as '16 weeks',
count(distinct case when a.user_age < 42 and a.user_age >=35 then a.user_id else null end) as '5 weeks',
count(distinct case when a.user_age < 35 and a.user_age >=28 then a.user_id else null end) as '4 weeks',
count(distinct case when a.user_age < 28 and a.user_age >=21 then a.user_id else null end) as '3 weeks',
count(distinct case when a.user_age < 21 and a.user_age >-14 then a.user_id else null end) as '12 weeks',
count(distinct case when a.user_age < 14 and a.user_age >=7 then a.user_id else null end) as '1 weeks',
count(distinct case when a.user_age < 7 and a.user_age >=63 then a.user_id else null end) as 'less than a week'
from
(select b.occurred_at, c.user_id, 
extract(week from c.activated_at) as activation_week, 
extract(day from b.occurred_at - c.activated_at) as age_at_event, 
extract(day from '2014-09-01' - c.activated_at) as user_age
from case2.users c
join case2.events b
on b.user_id = c.user_id
and b.event_type = 'engagement'
and b.event_name= 'login' 
and b.occurred_at > 2014-05-01 and occurred_at <2014-09-01 
where c.activated_at is not null) a
group by 1
order by 1;

-- ques 4

select extract(week from occurred_at) as week_,
count(distinct user_id) as weekly_active_users, 

count(distinct case when device in
('macbook pro', 'lenovo thinkpad', 'macbook air',' dell inspiron notebook', 
'asus chromebook', 'dell inspiron desktop', 'acer aspire notebook', 
'hp pavilion desktop', 'acer aspire desktop', 'mac mini') 
then user_id else null end) as computer,

count(distinct case when device in('iphone 5','samsung galaxy s4', 
'nexus 5','iphone 5s', 'iphone 4s', 'nokia lumia 635',
 'htc one','samsung galaxy note', 'amazon fire phone') 
 then user_id else null end) as phone,
 
count(distinct case when device in('ipad air', 'nexus 7','ipad mini', 
'nexus 10', 'kindle fire', 'windows surface', 'samsung galaxy tablet') 
then user_id else null end) as tablet

from events 
where event_type = 'engagement'
and event_name = 'login'
group by 1
order by 1;


-- ques 5
select extract(week from occurred_at) as week_,
count(case when action = 'sent_weekly_digest' then user_id else null end) as weekly_email_count,
count(case when action= 'email_open' then user_id else null end) as email_open_count,
count(case when action = 'email_clickthrough' then user_id else null end) as email_clickthroughs_count
from email_events 
group by 1;

