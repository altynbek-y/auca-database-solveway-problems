;with salary as 
(
    select s.employeeid as empl_id, month(s.paymentdate) as m, sum(s.amount) as total from salaries as s
    group by month(s.paymentdate),s.employeeid
)

select distinct e.name as 'Employee name', e.position as Position
from employees as e
inner join salary as s
on s.empl_id = e.id and s.total >= 2800
where (year(e.dateofbirth) between 1964 and 1980)
order by e.name, position
