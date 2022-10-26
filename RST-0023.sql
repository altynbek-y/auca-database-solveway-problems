select top 20 name as Name,
replace(replace(replace(name,' ','<>'),'><',''),'<>',' ') as NewName,
len(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '))-len(replace(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '),' ',''))+1 as Qty,
len(replace(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '),' ','')) as Ln
from dishes
order by len(replace(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '),' ','')) desc, name asc
