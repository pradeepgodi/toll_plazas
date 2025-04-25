select * from toll_plaza limit 15;
select count(*) from toll_plaza;

select state , count(*) from toll_plaza
group by 1
order by 2 desc;

select toll_plaza_name , count(*) from toll_plaza
group by 1
having count(*) >1
order by 2 desc;

###


CREATE EXTENSION IF NOT EXISTS postgis;