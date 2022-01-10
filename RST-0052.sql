select top 1 i.name as Name, count(di.dishid) as DependentDishes, 
sum(di.weight) as TotalWeight
from ingredients i
inner join dishesingredients di
on i.id = di.ingredientid
group by i.name
order by DependentDishes desc, TotalWeight  desc,  i.name asc
