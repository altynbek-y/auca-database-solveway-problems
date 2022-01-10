select name as Name from dishes
where
  id in (
    select dishid
    from dishesingredients
    where 
      dishid in (
        select dishid from dishestags
        where 
          tagid in (
            select id from tags where name='Vegetarian'
          )
      ) 
      and 
      ingredientid in (
        select id from ingredients
        where name like '%turkey%'
      )
)
