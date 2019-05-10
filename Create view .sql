create or alter view callhistv
as
SELECT [campaignname] 

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

	  ,CONTACT,
	  DMC,
	  SALE

  FROM [Core].[ININ_DIALER_40].[CallHistory] ch 

INNER JOIN   

[Important].[dbo].[outcome] ot on ch. Wrapupcode = ot. LocalizedWrapUpCode where campaignname like 'my%'   ;
