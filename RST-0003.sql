select name as Name from ingredients
where
  id in (
    select ingredientid from dishesingredients
    where 
      dishid in (
        select id from dishes
        where name='Burrito'
      )
)
order by name asc
