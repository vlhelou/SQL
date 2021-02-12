--Origem https://blog.sqlauthority.com/2021/02/12/sql-server-list-tables-with-size-and-row-counts/?utm_source=rss&utm_medium=rss&utm_campaign=sql-server-list-tables-with-size-and-row-counts

SELECT
t.NAME AS TableName,
SUM(p.rows) AS RowCounts,
(SUM(a.total_pages) * 8)/1024 as TotalSpaceMB,
(SUM(a.used_pages) * 8)/1024 as UsedSpaceMB,
(SUM(a.data_pages) * 8)/1024 as DataSpaceMB
FROM sys.tables t
INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE i.OBJECT_ID > 255
AND i.index_id IN (0,1)
GROUP BY t.NAME
ORDER BY TotalSpaceMB DESC
