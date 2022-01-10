with boss_sub as
(
    select e1.id as Id1, 
    e1.name as BossName, 
    e1.education as Edu1, 
    (case when e1.education='Master' then 4.0 when e1.education='Baccalaureate' then 3.0 when e1.education='Specialist' then 2.0 when e1.education='Incomplete HE' then 1.0 else 0 end) as Rank1,
    e2.id as Id2, 
    e2.leaderid as leaderid,
    e2.name as SubName, 
    e2.education as Edu2,
    (case when e2.education='Master' then 4.0 when e2.education='Baccalaureate' then 3.0 when e2.education='Specialist' then 2.0 when e2.education='Incomplete HE' then 1.0 else 0 end) as Rank2
    from employees e1
    inner join employees e2
    on e2.leaderid = e1.id and e2.leaderid is not null
    group by e1.id, e1.name, e1.education, e2.id, e2.leaderid, e2.name, e2.education, e2.leaderid
)

select 
b.bossname as Name, 
cast((b.rank1 - avg(b.rank2))*100 as decimal(10,2)) as Bonus
from boss_sub as b
where b.rank2 > 0 
group by b.bossname, b.rank1, b.id1, b.edu1
having b.rank1 > avg(b.rank2)
