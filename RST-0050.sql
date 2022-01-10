select name as DishName
from dishes d
inner join dishesingredients di
on d.id = di.dishid
where di.ingredientid
in (
    (select id from ingredients where name = 'Cheese')
)
except
select name as DishName
from dishes d
inner join dishesingredients di
on d.id = di.dishid
where di.ingredientid in (
    select id from ingredients where name  = 'Tomato'
)
