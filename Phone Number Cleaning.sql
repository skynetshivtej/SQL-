BEGIN
  SET NOCOUNT ON;
  DECLARE @query nvarchar(max) =  
  N'SELECT top(100) RemoteID from [dbo].[InteractionSummary] '  
  EXECUTE sp_execute_external_script @language = N'R',  
                                     @script = N'  

  require(gsubfn) 
   a<- InputDataSet

   print(class(a))
   
    
   OutputDataSet <- data.frame(a);  
   ',  
   @input_data_1 = @query  
   WITH RESULT SETS ((plot varchar(max)));  
END
GO