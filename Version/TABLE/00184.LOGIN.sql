if not exists(select * from sys.columns 
            where Name = N'ID' and Object_ID = Object_ID(N'LOGIN'))
BEGIN
	DELETE	dbo.LOGIN
	
    ALTER TABLE [LOGIN] ADD ID INT NOT NULL;
END    

