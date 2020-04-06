set ROWCOUNT 50
select 
    conteudo.text
    ,'qt' = req.execution_count
    ,'worktime' = total_worker_time/req.execution_count
    ,'reads' = total_logical_reads/req.execution_count
    ,'writes' = total_logical_writes/req.execution_count
    ,'elapsed' = total_elapsed_time/req.execution_count
    ,'rows' = total_rows/req.execution_count
    ,'drop' = total_dop/req.execution_count
    ,'grant kb' = total_grant_kb/req.execution_count
    ,'threads' = total_reserved_threads/req.execution_count
    ,'used threads' = total_used_threads/req.execution_count
    
from sys.dm_exec_query_stats req
cross apply sys.dm_exec_sql_text(req.sql_handle) conteudo
order by total_logical_reads desc