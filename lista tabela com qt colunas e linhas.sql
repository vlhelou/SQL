select 
	schemas.name+'.'+tables.name Nome
	, COUNT( distinct syscolumns.colid) colunas
	, avg(partitions.rows) Linhas
from sys.tables
   inner join sys.schemas on tables.schema_id = schemas.schema_id
	inner join sys.syscolumns on tables.object_id = syscolumns.id
	inner join sys.partitions on tables.object_id = partitions.object_id
group by 
	schemas.name+'.'+tables.name
order by linhas desc
