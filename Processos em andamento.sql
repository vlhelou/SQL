select 
    DATEDIFF( SECOND, sn.last_request_start_time, getdate()) passados
    , host_name
    -- , transaction_id
    , isnull(wait_type, last_wait_type) wait
    , conteudo.text
    , sn.row_count
    , req.session_id
    , req.status  
    , blocking_session_id Bloqueio
    , login_name
    , req.parallel_worker_count
    , req.cpu_time
    , req.reads
from sys.dm_exec_requests req
    inner join sys.dm_exec_sessions sn on req.session_id = sn.session_id
    cross apply sys.dm_exec_sql_text(req.sql_handle) conteudo
where 
    req.session_id>50
    and req.session_id != @@SPID
    and req.status not in ('sleeping')
    and login_name not in ('WEBAULADC\WADB01NODE02$','WEBAULADC\WADB01NODE03$')
order by passados desc
    

--sp_who2 129