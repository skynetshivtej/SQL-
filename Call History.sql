BEGIN
SET NOCOUNT ON;
DECLARE @query nvarchar(max) =
    N'SELECT [campaignname]
      ,[phonenumber]
	  ,cast([callplacedtimeUTC] as date) AS calldate
      ,cast([callansweredtimeUTC] as smalldatetime) AS callanswered
      ,[messageplaytimeUTC]
      ,cast([callconnectedtimeUTC] as smalldatetime) AS callconnected
      ,[agentid]
      ,cast([calldisconnectedtimeUTC] as smalldatetime) AS callended
      ,[length]
      ,[isabandoned]
      ,[iscontact]
      ,[wrapupcategory]
      ,[wrapupcode]
  FROM [Core].[ININ_DIALER_40].[CallHistory];'

EXECUTE sp_execute_external_script
@language = N'R'
,@script = N'  
library(lubridate)
library(sqldf)
data =InputDataSet



',

@input_data_1 = @query
end