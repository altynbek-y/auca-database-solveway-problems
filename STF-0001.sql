select e.name as EmployeeName, 
(case when month(s.paymentdate)=3 then N'Март' when month(s.paymentdate)=4 then N'Апрель' else N'Май' end)as MonthName, 
year(s.paymentdate) as Year, cast(sum(s.amount) as decimal(9, 4)) as TotalSalary
from employees e
inner join salaries s
on e.id = s.employeeid
where year(s.paymentdate)=2018 and month(s.paymentdate) in (3,4,5)
group by e.name, month(s.paymentdate), year(s.paymentdate)
