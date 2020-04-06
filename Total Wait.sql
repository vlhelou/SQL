declare @antes table (wait varchar(120), qt bigint, duracao bigint);
declare @depois table (wait varchar(120), qt bigint, duracao bigint);
declare @total bigint;

--coleta antes
insert into @antes
select wait_type, waiting_tasks_count, wait_time_ms 
from sys.dm_os_wait_stats
where waiting_tasks_count>0

WAITFOR DELAY '00:00:05';  

--coleta depois
insert into @depois
select wait_type, waiting_tasks_count, wait_time_ms 
from sys.dm_os_wait_stats
where waiting_tasks_count>0


--decobre o total
select 
    @total =sum( depois.duracao - antes.duracao) 
from @antes antes
    inner join @depois depois on antes.wait = depois.wait
where depois.duracao - antes.duracao >0



select 
    antes.wait
    , format(depois.qt - antes.qt,'N0','pt-br') QT
    , format(depois.duracao - antes.duracao, 'N0', 'pt-br') Duracao
    , FORMAT( ((depois.duracao - antes.duracao) / (@total*1.0)*100),'N2','pt-br') as pct
    , format(@total,'N0','pt-br') Total
from @antes antes
    inner join @depois depois on antes.wait = depois.wait
where depois.duracao - antes.duracao >0
order by depois.duracao - antes.duracao desc
-- sp_help 'sys.dm_os_wait_stats'
--select * from sys.dm_os_waiting_tasks