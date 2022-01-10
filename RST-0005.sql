select count(s.id) as Cnt from sections as s
where (
  select count(distinct d.id) 
  from dishes as d
  where d.sectionid = s.id
) = 5
