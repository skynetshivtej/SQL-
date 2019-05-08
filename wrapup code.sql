USE [master]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[sp_Wrapup]
AS
BEGIN
SET NOCOUNT ON;
DECLARE @query nvarchar(max) =
    N'SELECT 
     [UserID],
     b.[WorkgroupID]
      ,b.[WrapupCode]
      ,b.[WrapupCategory],
	  b.[tConnected]
      ,   
	   a.[Direction],
	   cast([WrapupStartDateTimeUTC] as Date)
	  FROM [Core].[dbo].[InteractionSummary] a JOIN [Core].[dbo].[InteractionWrapup] b ON a.InteractionIDKey = b.InteractionIDKey
	  where [WrapupStartDateTimeUTC] is not null;'

EXECUTE sp_execute_external_script
@language = N'R'
,@script = N'  
library(lubridate)
library(dplyr)
library(stringr)
library(sqldf)
library(xts)
library(data.table)
data =InputDataSet

data <- InputDataSet




date <- as.Date(data[,7])
alldate <- data[,1:6]


result <- data.frame(date,cut_Date = cut(as.Date(date), "week"),cut_POSIXt = cut(as.POSIXct(date), "week"), stringsAsFactors = FALSE)
abc <- cbind.data.frame(alldate, result)

ndvalue <- subset.data.frame(abc, abc$WrapupCode == "NS")


ndvalue$WrapupCode <- 1
ddd<- ndvalue%>%filter(str_detect(ndvalue$WorkgroupID,"Pinergy"))
print(ddd)

finalda <- sqldf("select  UserID,Date,cut_Date,WorkgroupID, sum(wrapupcode) from ndvalue group by date,UserID;")

OutputDataSet = finalda

',

@input_data_1 = @query
WITH RESULT SETS ((userid varchar(60),daily float,weekly date, workgroup varchar(60),totalcount int))
end


USE Core 
Go 

Select icuserid, WrapupCode,cast(convert(varchar, WrapupStartDateTimeUTC, 101) AS Date ) AS WrDate, WorkgroupID  from [Core ].[dbo].[wrapup] where WorkgroupID like 'Piner%' AND WrapupCode like 'NS';
