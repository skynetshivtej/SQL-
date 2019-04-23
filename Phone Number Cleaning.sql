BEGIN
  SET NOCOUNT ON;
  DECLARE @query nvarchar(max) =  
  N'SELECT top(100) RemoteID from InteractionSummary'  
  EXECUTE sp_execute_external_script @language = N'R',  
                                     @script = N'  

   #Plot histogram  
   a<- InputDataSet
   
    
   OutputDataSet <- data.frame(a);  
   ',  
   @input_data_1 = @query  
   WITH RESULT SETS ((plot varchar(max)));  
END
GO