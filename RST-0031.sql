select d.name as 'Dish name' from dishes as d
--where d.name like 'M%'and 
where (d.weight between 200 and 400) and d.id in (
    select dt.dishid from dishestags as dt
    inner join tags as t
    on dt.tagid = t.id and t.name like '%Vegetarian%'
)
order by d.name
