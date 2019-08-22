declare @column varchar(50) =  NEXT VALUE FOR CountBy1, @sql varchar(max)
set @sql = 'alter table test2 add Week19'+@column+ ' int'
exec (@sql)
