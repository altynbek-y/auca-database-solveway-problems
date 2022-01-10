select name as Name, dateofbirth as DateOfBirth,
case 
	when datepart(month, dateofbirth)=12 and datepart(day, dateofbirth)<22 
	then 'Sagittarius' 

	when datepart(month, dateofbirth)=12 and datepart(day, dateofbirth)>=22 
	then 'Capricorn'

	when datepart(month, dateofbirth)=1 and datepart(day, dateofbirth)<20
	then 'Capricorn' 

	when datepart(month, dateofbirth)=1 and datepart(day, dateofbirth)>=20
	then 'Aquarius'

	when datepart(month, dateofbirth)=2 and datepart(day, dateofbirth)<19
	then 'Aquarius' 

	when datepart(month, dateofbirth)=2 and datepart(day, dateofbirth)>=19
	then 'Pisces'

	when datepart(month, dateofbirth)=3 and datepart(day, dateofbirth)<21
	then 'Pisces' 

	when datepart(month, dateofbirth)=3 and datepart(day, dateofbirth)>=21
	then 'Aries'

	when datepart(month, dateofbirth)=4 and datepart(day, dateofbirth)<20
	then 'Aries' 

	when datepart(month, dateofbirth)=4 and datepart(day, dateofbirth)>=20
	then 'Taurus'

	when datepart(month, dateofbirth)=5 and datepart(day, dateofbirth)<21 
	then 'Taurus' 

	when datepart(month, dateofbirth)=5 and datepart(day, dateofbirth)>=21 
	then 'Gemini'

	when datepart(month, dateofbirth)=6 and datepart(day, dateofbirth)<21
	then 'Gemini' 

	when datepart(month, dateofbirth)=6 and datepart(day, dateofbirth)>=21 
	then 'Cancer'

	when datepart(month, dateofbirth)=7 and datepart(day, dateofbirth)<23 
	then 'Cancer' 

	when datepart(month, dateofbirth)=7 and datepart(day, dateofbirth)>=23 
	then 'Leo'

	when datepart(month, dateofbirth)=8 and datepart(day, dateofbirth)<23 
	then 'Leo' 

	when datepart(month, dateofbirth)=8 and datepart(day, dateofbirth)>=23 
	then 'Virgo'

	when datepart(month, dateofbirth)=9 and datepart(day, dateofbirth)<23
	then 'Virgo' 

	when datepart(month, dateofbirth)=9 and datepart(day, dateofbirth)>=23 
	then 'Libra'

	when datepart(month, dateofbirth)=10 and datepart(day, dateofbirth)<24
	then 'Libra' 

	when datepart(month, dateofbirth)=10 and datepart(day, dateofbirth)>=24 
	then 'Scorpio'

	when datepart(month, dateofbirth)=11 and datepart(day, dateofbirth)<22 
	then 'Scorpio' 

	when datepart(month, dateofbirth)=11 and datepart(day, dateofbirth)>=22 
	then 'Sagittarius'
end as Zodiac
	
from employees 
where id not in (select leaderid from employees where leaderid is not null)
