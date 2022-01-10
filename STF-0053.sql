select d.name as Name,
(select count(id) from employees as e where e.sex='m' and e.departmentid=d.id) as Males,
(select count(id) from employees as e where e.sex='f' and e.departmentid=d.id) as Females,
ISNULL(sum(case e.sex when 'm' then (case when s.type='s' then s.amount when s.type='b' then s.amount else -s.amount end) else 0 end), 0) as MalesPayments,
ISNULL(sum(case e.sex when 'f' then (case when s.type='s' then s.amount when s.type='b' then s.amount else -s.amount end) else 0 end), 0) as FemalesPayments
from employees as e
left join (
    select 's' as [type], employeeid, amount, paymentdate from salaries
    union all
    select 'b' as [type], employeeid, amount, paymentdate from bonuses
    union all
    select 'p' as [type], employeeid, amount, paymentdate from penalties
) as s
on s.employeeid = e.id and (s.paymentdate between '2018-07-01' and '2018-07-31') 
left join departments as d
on e.departmentid = d.id
group by d.name, d.id
order by d.name
