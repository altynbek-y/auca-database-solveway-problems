select d1.name as 'First dish', d2.name as 'Second dish' from dishes as d1
inner join dishes as d2
on left(d1.name,1) = left(d2.name,1) and right(d1.name, 1) = right(d2.name, 1) and d1.name != d2.name
where d1.weight = 300 and d1.id not in (
    select dt.dishid from dishestags as dt
    inner join tags as t
    on dt.tagid = t.id and t.name like '%Vegetarian%'
)
order by d1.name, d2.name
