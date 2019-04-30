BEGIN
SET NOCOUNT ON;
DECLARE @query nvarchar(max) =
    N'SELECT top(1000)
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
library(sqldf)
data =InputDataSet
date <- data[,7]
alldate <- data[,1:6]

result <- data.frame(date, cut_Date = cut(as.Date(date, format = "%d/%m/%Y %H:%M"), format = "%d/%m/%Y %H:%M", "week"),
  cut_POSIXt = cut(as.POSIXct(date, format = "%d/%m/%Y %H:%M"), "week"),
    stringsAsFactors = FALSE)

abc<- cbind.data.frame(alldate,result)

ndvalue<- subset.data.frame(abc, abc$WrapupCode == "NS")
ndvalue$WrapupCode <- 1
ndvalue <- ndvalue %>% filter(str_detect(ndvalue$WorkgroupID, "Pinergy"))

finalda<- sqldf("select  USERID,Date,cut_Date,WorkgroupID, sum(wrapupcode) from ndvalue group by date,USERID;")

OutputDataSet = finalda

',

@input_data_1 = @query
WITH RESULT SETS ((userid varchar(60),daily date,weekly date, workgroup varchar(60),totalcount int))
end


