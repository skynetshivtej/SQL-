IF OBJECT_ID('tempdb..#TemperedFileList') IS NOT NULL DROP TABLE #TemperedFileList
GO
Declare @FileName varChar(255)
Declare @cmdText varChar(255)
Declare @BKFolder varchar(255)
Declare @DBFolder varchar(255)

set @FileName = null

set @BKFolder = 'C:\Database\'
set @DBFolder = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\'

declare @FileList table (FileName varchar(255), DepthFlag int, FileFlag int)
insert into @FileList exec xp_dirtree @BKFolder,0,1

create table #TemperedFileList (FileName varchar(255),DBName varchar(255))

insert into #TemperedFileList (FileName,DBName) select FileName, 'Core' from @FileList WHERE Filename like '%.bak'

declare @RowCnt int
declare @MaxRows int
declare @tmpFileName varchar(255)
declare @tmpDBName varchar(255)
declare @sql nvarchar(3000)

select @RowCnt = 1

declare @Import table (rownum int IDENTITY (1, 1) Primary key NOT NULL , FileName varchar(255),DBName varchar(255))
insert into @Import (FileName,DBName) SELECT FileName,DBName FROM  (SELECT FileName,DBName,rank() over (partition by DBName order by FileName desc) r FROM  #TemperedFileList ) ilv where r=1

select @MaxRows=count(*) from @Import

select * from @Import

select @MaxRows=count(*) from @Import
while @RowCnt <= @MaxRows
begin
    select @tmpFileName=FileName from @Import where rownum = @RowCnt
    select @tmpDBName=DBName from @Import where rownum = @RowCnt

    

    set @sql ='RESTORE DATABASE ['+@tmpDBName+'] FROM  DISK=''' + @BKFolder + @tmpFileName + ''' WITH REPLACE'
    print @sql
    exec(@sql)

    

    Set @RowCnt = @RowCnt + 1
end
