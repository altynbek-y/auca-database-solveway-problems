select replace(name, 'l', 'r') from dishes as d
where (len(name)-len(replace(name, 'a', '')))<=2 
and sectionid in (select id from sections where name not like '%Drink%')
