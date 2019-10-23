declare @tcolunas table (NomeColuna varchar(100))
insert into @tcolunas (NomeColuna) values ('CODSEGMENTO'),('CODTURMA');

with qbase as (
	select 
		TABLE_SCHEMA
		, TABLE_NAME
		, COLUMN_NAME
	from INFORMATION_SCHEMA.COLUMNS
	where 
		COLUMN_NAME in (select NomeColuna from @tcolunas)
)

select 
	TABLE_SCHEMA
	, TABLE_NAME
	, count(1) QtColunas
from qbase
group by
	TABLE_SCHEMA
	, TABLE_NAME
having COUNT(1) = (select count(1) from @tcolunas)
order by TABLE_NAME
