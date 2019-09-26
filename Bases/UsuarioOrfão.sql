select db.*
from sys.database_principals db
    left join sys.server_principals principal on db.sid = principal.sid
WHERE
    principal.sid is null
    and authentication_type_desc='INSTANCE'
