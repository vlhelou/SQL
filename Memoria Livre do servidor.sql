SELECT *
FROM sys.dm_os_performance_counters
where counter_name like 'Free Memory (KB)%'
