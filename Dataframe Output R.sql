BEGIN
  SET NOCOUNT ON;
  DECLARE @query nvarchar(max) =  
  N'SELECT a.[InteractionIDKey]
     ,[UserID]
   
      FROM [Core].[dbo].[InteractionSummary] a JOIN [Core].[dbo].[InteractionWrapup] b ON a.InteractionIDKey = b.InteractionIDKey; '  
  EXECUTE sp_execute_external_script @language = N'R',  
                                     @script = N'  
									 
									 data =InputDataSet
									 OutputDataSet = data.frame(data[,1:2])
									 ',
									 @input_data_1 = @query
									 with result SETS ((interaction varchar(40), id varchar(50)))
END