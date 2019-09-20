select
    tables.object_id
    , tables.name
    , format(avg(rows),'N0','pt-br') as Registros
    , format( sum(user_seeks+user_scans+user_lookups),'N0','pt-br') as Leituras
    , format( sum(user_updates),'N0','pt-br') as Escritas
from sys.tables
    inner join sys.indexes on 
        tables.object_id = indexes.object_id
        --and indexes.is_primary_key=1
    inner join sys.partitions on 
        indexes.object_id = partitions.object_id
        and indexes.index_id = partitions.index_id
    inner join sys.dm_db_index_usage_stats ON
        indexes.object_id = dm_db_index_usage_stats.object_id
        and indexes.index_id = dm_db_index_usage_stats.index_id

--where [rows]=0
group BY
    tables.object_id
    , tables.name
having avg(rows)>0
order BY avg(rows) desc