if not exists(select * from sys.columns 
            where Name = N'NGAY_KH' and Object_ID = Object_ID(N'HIEU_CHUAN_MAY'))
begin

    ALTER TABLE HIEU_CHUAN_MAY ADD NGAY_KH datetime
END    
go
UPDATE HIEU_CHUAN_MAY SET NGAY_KH = NGAY_HC WHERE ISNULL(NGAY_KH ,'') = ''