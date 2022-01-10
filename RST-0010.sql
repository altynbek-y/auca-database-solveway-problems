select name from dishes where replace(replace(replace(name,' ','<>'),'><',''),'<>',' ') like '% % %'
