select top 1 e.name Name, cast(2*sum(b.amount) as decimal(9,4)) Bonus 
from employees e
inner join bonuses b
on e.id = b.employeeid
where e.id not in (select employeeid from penalties)
group by e.name
order by count(e.name) desc
