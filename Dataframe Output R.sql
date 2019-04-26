BEGIN
  SET NOCOUNT ON;
  DECLARE @query nvarchar(max) =  
  N'SELECT a.[InteractionIDKey]
     ,[UserID]
     
      ,cast([WrapupStartDateTimeUTC] as datetime) 
	 
	   
      FROM [Core].[dbo].[InteractionSummary] a JOIN [Core].[dbo].[InteractionWrapup] b ON a.InteractionIDKey = b.InteractionIDKey; '  
  EXECUTE sp_execute_external_script @language = N'R',  
                                     @script = N'  
									 
									 data =InputDataSet
									 print(class(data))
									 OutputDataSet = data.frame(data[,1:3])
									 ',
									 @input_data_1 = @query
									 with result SETS ((interaction varchar(40), id varchar(50),dob datetime ))
END