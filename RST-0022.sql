select top 25 name as Name,
len(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '))-len(replace(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '),' ',''))+1 as Qty
from dishes
order by len(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '))-len(replace(replace(replace(replace(name,' ','<>'),'><',''),'<>',' '),' ',''))+1 desc, name asc
