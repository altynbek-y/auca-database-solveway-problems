select distinct
    a.name as IngredientA,
    b.name as IngredientB
from 
    ingredients a,
    ingredients b
 where (left(a.name,1) in ('a','e','i','o','u') or left(b.name,1) in ('a','e','i','o','u')) and len(a.name)+len(b.name) <=8 and a.name <> b.name
