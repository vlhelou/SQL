select 
	TABLE_SCHEMA
	, TABLE_NAME
	, COUNT(case when COLUMN_NAME in ('CODSEGMENTO','CODALUNO') then 1 else null end ) as qtColunas
from INFORMATION_SCHEMA.COLUMNS
group by 
	TABLE_SCHEMA
	, TABLE_NAME
having 
	COUNT(case when COLUMN_NAME in ('CODSEGMENTO','CODALUNO') then 1 else null end )=2
