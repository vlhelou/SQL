select 
    db.name
    , db.create_date
    , db.modify_date 
    , case when EXISTS(select * from sys.server_principals pr where pr.name collate Latin1_General_CI_AI = db.name collate Latin1_General_CI_AI)  then 'Tem no Servidor' else 'Somente na base' end
from sys.database_principals db
    left outer join sys.server_principals principal on db.sid = principal.sid
WHERE
    principal.sid is null
    and authentication_type_desc='INSTANCE'
