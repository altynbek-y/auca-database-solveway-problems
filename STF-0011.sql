select name from employees
where charindex(',', name) > 0 and right(name, len(name)-charindex(',', name)-1) = reverse(right(name, len(name)-charindex(',', name)-1))
