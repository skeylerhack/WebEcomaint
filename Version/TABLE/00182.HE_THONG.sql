
IF not exists(select * from sys.columns 
            where Name = N'NHOM_IN' and Object_ID = Object_ID(N'HE_THONG'))
begin
    ALTER TABLE HE_THONG ADD NHOM_IN INT;
END    
GO	
IF not exists(select * from sys.columns 
            where Name = N'NHOM_LINE' and Object_ID = Object_ID(N'HE_THONG'))
begin
    ALTER TABLE HE_THONG ADD NHOM_LINE INT;
END   
