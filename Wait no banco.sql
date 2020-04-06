set rowcount 0
declare @antes table (id smallint, wait int)
declare @depois table (id smallint, wait int)



insert into @antes
select session_id, wait_time 
from sys.dm_exec_requests
where session_id>50 and session_id!=@@SPID


WAITFOR DELAY '00:00:01';  

insert into @depois
select session_id, wait_time 
from sys.dm_exec_requests
where session_id>50 and session_id!=@@SPID

select 
	depois.id 
	, depois.wait-antes.wait wait
	, conteudo.text
	, wait_type
from @antes antes
	inner join @depois depois on antes.id = depois.id and depois.wait-antes.wait>0
	inner join sys.dm_exec_requests req on antes.id = req.session_id
	cross apply sys.dm_exec_sql_text(req.sql_handle) conteudo
order by wait desc