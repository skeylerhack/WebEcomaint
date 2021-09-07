if not exists(select * from sys.columns 
            where Name = N'KHONG_DC' and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY_SO_LAN'))
begin
    ALTER TABLE THOI_GIAN_NGUNG_MAY_SO_LAN ADD KHONG_DC BIT	DEFAULT (0) 
END    

GO
UPDATE THOI_GIAN_NGUNG_MAY_SO_LAN SET KHONG_DC = 0 WHERE  KHONG_DC IS NULL
