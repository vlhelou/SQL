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
			when 'xml' then 'string'
			when 'datetime' then 'DateTime'
			when 'decimal' then 'decimal'
			when 'int' then 'int'
			when 'bigint' then 'long'
			when 'bit' then 'bool'
			when 'uniqueidentifier' then 'Guid'
			end +
		case when cl.isnullable=1 and tp.name not in ('varchar','char','nvarchar','nchar') then '?' else '' end
		+ ' '+cl.name+ ' { get; set; }' as c#
	, cl.name +
		case when cl.isnullable=1 and tp.name not in ('varchar','char','nvarchar','nchar') then '?' else '' end
		+': '+
		case 
		when tp.name in ('numeric', 'decimal','int', 'bigint') then 'number;'
		when tp.name in ('bit') then 'boolean;'
		when tp.name in ('char', 'nchar','varchar','nvarchar','uniqueidentifier','xml') then 'string;'
		when tp.name in ('datetime', 'date','time') then 'Date;'
		end as AngularInterface
	, cl.name+': new FormControl(),' as AngularFormControl
from sys.syscolumns cl
	inner join sys.systypes tp on 
		cl.xtype = tp.xtype
where 
	cl.id=OBJECT_ID('LMSE_FBKRESPOSTADEPERGUNTA')
	and tp.name!='sysname'
order by cl.colid
