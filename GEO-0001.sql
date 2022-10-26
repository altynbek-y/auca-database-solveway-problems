select id as ID,
case when sidea + sideb > sidec and sidea + sidec > sideb and sideb+  sidec > sidea 
then 'YES' else 'NO' 
end as Answer
from trianglesides
