declare @wait varchar(120) = 'ASYNC_NETWORK_IO'

select 
    req.session_id
    , command
    , req.database_id
    , sessao.host_name
    , conteudo.text
from sys.dm_exec_requests req
    inner join sys.dm_exec_sessions sessao on req.session_id = sessao.session_id
cross apply sys.dm_exec_sql_text(req.sql_handle) conteudo
where 
    1=1
    and wait_type = @wait or last_wait_type=@wait
