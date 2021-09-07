if not exists(select * from sys.columns 
            where Name = N'AN_HIEN' and Object_ID = Object_ID(N'DS_REPORT'))
begin
    ALTER TABLE dbo.DS_REPORT ADD AN_HIEN BIT  DEFAULT (0)
END    
GO	
	--UPDATE dbo.CHI_TIET_FORMS SET AN_HIEN = 0 WHERE AN_HIEN IS NULL

	if not exists(select * from sys.columns 
            where Name = N'STT' and Object_ID = Object_ID(N'DS_REPORT'))
begin
    ALTER TABLE dbo.DS_REPORT ADD STT INT  
END    
GO	
