


--TEN_MAY
if not exists(select * from sys.columns 
            where Name = N'TEN_N_XUONG' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD TEN_N_XUONG nvarchar(500)
END 
if not exists(select * from sys.columns 
            where Name = N'TEN_MAY' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD TEN_MAY nvarchar(500)
END    
if not exists(select * from sys.columns 
            where Name = N'TEN_N_XUONG' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD TEN_N_XUONG nvarchar(500)
END 

--LIFE_TIME
if not exists(select * from sys.columns 
            where Name = N'LIFE_TIME' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD LIFE_TIME FLOAT
END    


--BUYING_NEW
if not exists(select * from sys.columns 
            where Name = N'BUYING_NEW' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD BUYING_NEW  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_CHI_TIET] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_CHI_TIET_BUYING_NEW]  DEFAULT ((0)) FOR [BUYING_NEW]

END 

--REPLACING_FOR
if not exists(select * from sys.columns 
            where Name = N'REPLACING_FOR' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD REPLACING_FOR  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_CHI_TIET] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_CHI_TIET_REPLACING_FOR]  DEFAULT ((0)) FOR [REPLACING_FOR]
END 

--SPARE
if not exists(select * from sys.columns 
            where Name = N'SPARE' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD SPARE  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_CHI_TIET] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_CHI_TIET_SPARE]  DEFAULT ((0)) FOR [SPARE]

END 

--MAINTENANCE
if not exists(select * from sys.columns 
            where Name = N'MAINTENANCE' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD MAINTENANCE  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_CHI_TIET] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_CHI_TIET_MAINTENANCE]  DEFAULT ((0)) FOR [MAINTENANCE]

END 

--DUONG_DAN_TL
if not exists(select * from sys.columns 
            where Name = N'DUONG_DAN_TL' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD DUONG_DAN_TL nvarchar(500)
END    
--BY_WHOM
if not exists(select * from sys.columns 
            where Name = N'BY_WHOM' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD BY_WHOM nvarchar(500)
END    
GO
--TRANSFER_TO
if not exists(select * from sys.columns 
            where Name = N'TRANSFER_TO' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD TRANSFER_TO nvarchar(500)
END    
