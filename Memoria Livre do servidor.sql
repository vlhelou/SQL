SELECT 
    object_name, counter_name, format(cntr_value,'N0','pt-br') valor
FROM sys.dm_os_performance_counters
where counter_name like 'Free Memory (KB)%'


select
(physical_memory_in_use_kb/1024)Phy_Memory_usedby_Sqlserver_MB,
(locked_page_allocations_kb/1024 )Locked_pages_used_Sqlserver_MB,
(virtual_address_space_committed_kb/1024 )Total_Memory_UsedBySQLServer_MB,
process_physical_memory_low,
process_virtual_memory_low
from sys. dm_os_process_memory