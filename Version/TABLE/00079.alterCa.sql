IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CA_ANH') and Object_ID = Object_ID(N'CA'))
BEGIN
  ALTER TABLE CA ADD CA_ANH NVARCHAR(250)  
END