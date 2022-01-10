select top 1 with ties i1.name as Ingredient1, i2.name as Ingredient2
from
(
    select distinct i1.dishid, i1.ingredientid as Ing1, i2.ingredientid as Ing2
    from dishesingredients as i1
    inner join dishesingredients as i2
    on i1.dishid = i2.dishid and i1.ingredientid <> i2.ingredientid
) a1
inner join Ingredients as i1
on i1.id = Ing1
inner join Ingredients as i2
on i2.id = Ing2
where i1.name < i2.name
group by Ing1, Ing2, i1.name, i2.name
order by count(*) desc
