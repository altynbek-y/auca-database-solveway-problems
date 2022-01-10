select name as 'Name' from dishes 
where name like 's%' 
order by right(name,len(name)-2) asc
