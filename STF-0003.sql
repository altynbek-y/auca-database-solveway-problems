with fired as (
    select employeeid from (
        select a.employeeid, count(a.employeeid) as cnt from (
            select employeeid from penalties where severitycategory='skip'
        ) as a
        group by a.employeeid
    ) as c where c.cnt > 2
),
expenses ([type], empid, amount, pdate) as (
    select 's' as [type], employeeid, amount, paymentdate from salaries union all
    select 'b' as [type], employeeid, amount, paymentdate from bonuses union all    
    select 'p' as [type], employeeid, amount, paymentdate from penalties 
)
select top 1 d.name as DepartmentName, 
isnull(sum(case when s.type='s' then s.amount when s.type= 'b' then s.amount else -s.amount end),0) as ExpensesAmount,
d.city as City, d.building as Building, d.buildingfloor as BuildingFloor
from employees as e inner join expenses as s
on s.empid = e.id and datepart(year, s.pdate) = 2018 and datepart(month, s.pdate) in (6,7,8) and s.empid not in (select employeeid from fired)
inner join departments as d on e.departmentid = d.id 
group by d.name, d.city, d.building, d.buildingfloor
order by ExpensesAmount desc, DepartmentName asc
