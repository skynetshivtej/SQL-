/* You can create table in SQL by using Create statement but the main 
   important part during creating the table is to assiging the variable type/ length and 
   attached contraint to that variable */

   CREATE TABLE DEMO
   (
   id int,
   ename varchar(50),
   dob date,
   comments nvarchar(50), -- If text is in huge amount then us can use text or image data type. (data is more than 1GB)
   );