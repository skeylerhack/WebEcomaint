--NHA_CUNG_CAP
if not exists(select * from sys.columns 
            where Name = N'NHA_CUNG_CAP' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD NHA_CUNG_CAP nvarchar(500)
END    
GO
--NGAY_GIAO_HANG	datetime	Checked
if not exists(select * from sys.columns 
            where Name = N'NGAY_GIAO_HANG' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD NGAY_GIAO_HANG datetime
END    
GO


--TEN_N_XUONG
if not exists(select * from sys.columns 
            where Name = N'TEN_N_XUONG' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD TEN_N_XUONG nvarchar(500)
END    
GO
--TEN_MAY
if not exists(select * from sys.columns 
            where Name = N'TEN_MAY' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD TEN_MAY nvarchar(500)
END    

GO
--LIFE_TIME
if not exists(select * from sys.columns 
            where Name = N'LIFE_TIME' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD LIFE_TIME FLOAT
END    

GO
--BUYING_NEW
if not exists(select * from sys.columns 
            where Name = N'BUYING_NEW' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD BUYING_NEW  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_DICH_VU] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_DICH_VU_BUYING_NEW]  DEFAULT ((0)) FOR [BUYING_NEW]

END 
GO
--REPLACING_FOR
if not exists(select * from sys.columns 
            where Name = N'REPLACING_FOR' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD REPLACING_FOR  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_DICH_VU] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_DICH_VU_REPLACING_FOR]  DEFAULT ((0)) FOR [REPLACING_FOR]
END 
GO
--SPARE
if not exists(select * from sys.columns 
            where Name = N'SPARE' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD SPARE  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_DICH_VU] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_DICH_VU_SPARE]  DEFAULT ((0)) FOR [SPARE]

END 
GO
--MAINTENANCE
if not exists(select * from sys.columns 
            where Name = N'MAINTENANCE' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD MAINTENANCE  BIT
    
    ALTER TABLE [dbo].[DE_XUAT_MUA_HANG_DICH_VU] ADD  CONSTRAINT [DF_DE_XUAT_MUA_HANG_DICH_VU_MAINTENANCE]  DEFAULT ((0)) FOR [MAINTENANCE]

END 
GO
--BY_WHOM
if not exists(select * from sys.columns 
            where Name = N'BY_WHOM' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD BY_WHOM nvarchar(500)
END    
GO
--TRANSFER_TO
if not exists(select * from sys.columns 
            where Name = N'TRANSFER_TO' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD TRANSFER_TO nvarchar(500)
END    
