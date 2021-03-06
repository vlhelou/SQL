select 
	tables.name
	, COUNT( distinct syscolumns.colid) colunas
	, avg(partitions.rows) Linhas
from sys.tables
	inner join sys.syscolumns on tables.object_id = syscolumns.id
	inner join sys.partitions on tables.object_id = partitions.object_id
group by 
	tables.name
order by colunas desc
