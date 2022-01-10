select 
case when name like '%,%' 
then substring(name, charindex(',', name)+2, len(name)) + ' ' + substring(name, 0, charindex(',', name))
else '!'+name
end as NewName
from employees
