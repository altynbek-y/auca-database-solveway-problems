select e.name Name, e.cardnumber as CardNumber, 
Sort = stuff((
        select '' + value from string_split(substring(e.cardnumber, 0, 1) + ' ' + substring(e.cardnumber, 1, 1)
        + ' ' + substring(e.cardnumber, 2, 1)+ ' ' + substring(e.cardnumber, 3, 1)
        + ' ' + substring(e.cardnumber, 4, 1)+ ' ' + substring(e.cardnumber, 5, 1)
        + ' ' + substring(e.cardnumber, 6, 1)+ ' ' + substring(e.cardnumber, 7, 1)
        + ' ' + substring(e.cardnumber, 8, 1)+ ' ' + substring(e.cardnumber, 9, 1)
        + ' ' + substring(e.cardnumber, 10, 1)+ ' ' + substring(e.cardnumber, 11, 1)
        + ' ' + substring(e.cardnumber, 12, 1)+ ' ' + substring(e.cardnumber, 13, 1)
        + ' ' + substring(e.cardnumber, 14, 1)+ ' ' + substring(e.cardnumber, 15, 1)
        + ' ' + substring(e.cardnumber, 16, 1), ' ')
        order by value
for XML PATH ('')), 1, 0,'')
from employees e
where e.education like 'Incomplete HE'
order by e.name

