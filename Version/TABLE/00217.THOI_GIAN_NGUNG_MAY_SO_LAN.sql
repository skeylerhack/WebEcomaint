if not exists(select * from sys.columns 
            where Name = N'MS_TO' and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY_SO_LAN'))
begin
    ALTER TABLE dbo.THOI_GIAN_NGUNG_MAY_SO_LAN ADD MS_TO INT;
END    
GO	

