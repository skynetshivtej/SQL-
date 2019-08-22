declare @nu nvarchar(50)
execute sp_executesql  N'SELECT current_value FROM sys.sequences',@nu OUTput
print @nu
