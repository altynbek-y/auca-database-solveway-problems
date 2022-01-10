select name as Name from ingredients
where id in (
    select ingredientid from dishesingredients
    where dishid in (
        select dishid from dishestags
            where tagid in (
                select id from tags where name = 'Spicy' 
            )
      )
)
intersect
select name as Name from ingredients
where id in (
    select ingredientid from dishesingredients
    where dishid in (
        select dishid from dishestags
            where tagid in (
                select id from tags where name = 'Vegetarian' 
            )
      )
)
order by name asc
