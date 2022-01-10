select distinct d.name as DishName
from dishes d
inner join sections s
on d.sectionid = s.id
where s.name like '%Soup%' 
and d.id not in (
    select dishid from dishesingredients
    where ingredientid in (
        select id from ingredients where name like '%Onion%'
    )
)
order by d.name
