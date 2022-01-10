select d.name as DishName, d.weight as DishWeight, sum(di.weight) as TotalIngredientsWeight
from dishes as d 
inner join dishesingredients as di
on di.dishid = d.id
group by d.name, d.weight
having d.weight <> sum(di.weight)
order by d.name asc
