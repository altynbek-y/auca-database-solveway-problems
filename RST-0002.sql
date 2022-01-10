select sum(di.weight) from dishesingredients di -
inner join dishes d
on d.id = di.dishid
where d.name = 'Caesar salad'
