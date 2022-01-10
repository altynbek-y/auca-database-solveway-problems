with ingredient_sections as 
(
    select i.id as ingr_id, i.name as IngredientName, s.name as SectionName
    from ingredients i
    left join dishesingredients di
    on di.ingredientid = i.id
    left join dishes d
    on d.id = di.dishid 
    left join sections s
    on s.id = d.sectionid
    group by i.id, i.name, s.name
    having count(d.id) = 1
)

select distinct  
    i.ingredientname as IngredientName,
    Sections = stuff((
        select ',' + s.sectionname from ingredient_sections as s where i.ingr_id = s.ingr_id
        for XML PATH ('')), 1, 1,'') 
from ingredient_sections as i
