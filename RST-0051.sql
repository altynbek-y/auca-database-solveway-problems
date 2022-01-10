select name as Name, weight as Weight
from dishes
group by name, weight
having weight>(select avg(weight) from dishes)
