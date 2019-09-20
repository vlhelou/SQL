select 
    db.name
    , sum(indice.user_seeks+user_scans+user_lookups) leituras
    , sum(user_updates) escritas
    , DATEDIFF(day, max(last_user_update), getdate())  DiasUltimaEscrita
    , max(last_user_seek) UltimoSeek
    , max(last_user_scan) UltimoScan
    , max(last_user_lookup) UltimoLoockup
from sys.databases DB
    inner join sys.dm_db_index_usage_stats indice on indice.database_id = DB.database_id
where db.database_id>4
group by
    db.name

order by leituras desc






