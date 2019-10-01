--select OBJECT_ID('cursos')


select 
	cl.name
	, cl.isnullable
	, tp.name
	, cl.prec
	, cl.scale
	, 'public '+
		case tp.name 
			when 'numeric' then 'decimal' 
			when 'varchar' then 'string' 
			when 'char' then 'string'
			when 'nvarchar' then 'string' 
			when 'nchar' then 'string'
			when 'datetime' then 'DateTime'
			when 'decimal' then 'decimal'
			when 'int' then 'int'
			when 'bit' then 'bool'
			end +
		case when cl.isnullable=1 and tp.name not in ('varchar','char','nvarchar','nchar') then '?' else '' end
		+ ' '+cl.name+ ' { get; set; }' as c#
	, cl.name +
		case when cl.isnullable=1 and tp.name not in ('varchar','char','nvarchar','nchar') then '?' else '' end
		+': '+
		case 
		when tp.name in ('numeric', 'decimal','int') then 'number;'
		when tp.name in ('bit') then 'boolean;'
		when tp.name in ('char', 'nchar','varchar','nvarchar') then 'string;'
		when tp.name in ('datetime', 'date','time') then 'Date;'
		end as Angular
from sys.syscolumns cl
	inner join sys.systypes tp on 
		cl.xtype = tp.xtype
where cl.id=OBJECT_ID('cursos')
	--and tp.name='datetime'
order by cl.colid
