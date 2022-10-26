;with empl as
(
    select e.id as id, 
    (case when month(e.startdate) > 2 then year(e.startdate)+1 else year(e.startdate) end) as y, 
    e.cardnumber as cardnumber from employees as e
),

temp as
(
    select e.id as id, e.y as y  
    from empl as e

    union all

    select t.id, t.y + 1 from temp as t
    where t.y + 1 < 2020
)

select sum(case when (t.y % 400 = 0 or t.y % 4 = 0 and t.y % 100 > 0) then 10 else 0 end) as Payment
from temp as t
