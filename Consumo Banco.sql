set rowcount 0
declare @antes table (id smallint, cpu int)
declare @depois table (id smallint, cpu int)



insert into @antes
select session_id, cpu_time 
from sys.dm_exec_requests
where session_id>50 and session_id!=@@SPID


WAITFOR DELAY '00:00:01';  

insert into @depois
select session_id, cpu_time 
from sys.dm_exec_requests
where session_id>50 and session_id!=@@SPID

select 
	depois.id 
	, depois.cpu-antes.cpu Consumo
	, conteudo.text
from @antes antes
	inner join @depois depois on antes.id = depois.id and depois.cpu-antes.cpu>0
	inner join sys.dm_exec_requests req on antes.id = req.session_id
	cross apply sys.dm_exec_sql_text(req.sql_handle) conteudo
order by Consumo desc