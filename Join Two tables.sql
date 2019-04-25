/****** Script for SelectTopNRows command from SSMS  ******/
SELECT a.[InteractionIDKey]
     ,[UserID],
     b.[WorkgroupID]
      ,b.[WrapupCode]
      ,b.[WrapupCategory],
	  b.[tConnected]
      ,[WrapupStartDateTimeUTC],
	   a.[Direction]
      FROM [Core].[dbo].[InteractionSummary] a JOIN [Core].[dbo].[InteractionWrapup] b ON a.InteractionIDKey = b.InteractionIDKey;