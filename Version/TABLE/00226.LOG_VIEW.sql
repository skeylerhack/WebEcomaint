--SELECT * FROM dbo.PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WO-202003000003'
--SELECT * FROM dbo.PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI = 'WO-202003000003'

----SELECT * FROM dbo.CHI_TIET_FORMS WHERE FORM_NAME = 'frmThongtinthietbi'
--SELECT * FROM dbo.W_HE_THONG
--SELECT * FROM dbo.W_NHA_XUONG

--SELECT * FROM dbo.W_CONG_VIEC
--SELECT * FROM dbo.MENU ORDER BY MENU_TEXT
--SELECT * FROM dbo.CHI_TIET_FORMS ORDER BY  TEN_FORMS_VIET

if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_CONG_VIEC'))
BEGIN
    ALTER TABLE dbo.W_CONG_VIEC ADD ID_LOG BIGINT
END   
GO
if exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_CONG_VIEC'))
BEGIN
    UPDATE W_CONG_VIEC SET	ID_LOG =  T2.ID FROM
		dbo.W_CONG_VIEC T1 INNER JOIN (
		SELECT * FROM dbo.W_LOG WHERE FORM_NAME = 'frmDanhmuccongviec') T2 ON T1.CREATEDATE = T2.NGAY 
		WHERE ISNULL(ID_LOG ,'') = ''
END   
GO

if not exists(select * from sys.columns 
            where Name = N'THAOTAC' and Object_ID = Object_ID(N'W_LOG'))
BEGIN
    ALTER TABLE dbo.W_LOG ADD THAOTAC INT
END   

GO
if exists(select * from sys.columns 
            where Name = N'THAOTAC' and Object_ID = Object_ID(N'W_LOG'))
BEGIN
    UPDATE W_LOG SET	THAOTAC =  T1.THAOTAC FROM
		dbo.W_CONG_VIEC T1 INNER JOIN (
		SELECT * FROM dbo.W_LOG WHERE FORM_NAME = 'frmDanhmuccongviec') T2 ON T1.CREATEDATE = T2.NGAY 
		WHERE ISNULL(T2.THAOTAC ,0) = 0
END   
GO


if not exists(select * from sys.columns 
            where Name = N'SO_NGUOI' and Object_ID = Object_ID(N'W_CONG_VIEC'))
BEGIN
    ALTER TABLE dbo.W_CONG_VIEC ADD SO_NGUOI INT
END   
GO
if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_NS' and Object_ID = Object_ID(N'W_CONG_VIEC'))
BEGIN
    ALTER TABLE dbo.W_CONG_VIEC ADD YEU_CAU_NS NVARCHAR(1000)
END   
GO
if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_DUNG_CU' and Object_ID = Object_ID(N'W_CONG_VIEC'))
BEGIN
    ALTER TABLE dbo.W_CONG_VIEC ADD YEU_CAU_DUNG_CU NVARCHAR(100)
END   
GO
if not exists(select * from sys.columns 
            where Name = N'LOG_VIEW' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
BEGIN
    ALTER TABLE dbo.CHI_TIET_FORMS ADD LOG_VIEW BIT DEFAULT (0)
END   
GO
if not exists(select * from sys.columns 
            where Name = N'MENU_ID' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
BEGIN
    ALTER TABLE dbo.CHI_TIET_FORMS ADD MENU_ID NVARCHAR(100)
END   
GO
if exists(select * from sys.columns 
            where Name = N'LOG_VIEW' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
BEGIN
    UPDATE dbo.CHI_TIET_FORMS SET	LOG_VIEW  = 1 WHERE  FORM_NAME = 'frmThongtinthietbi'
	UPDATE dbo.CHI_TIET_FORMS SET	LOG_VIEW  = 1 WHERE  FORM_NAME = 'frmDanhmuccongviec'
	UPDATE dbo.CHI_TIET_FORMS SET	LOG_VIEW  = 1 WHERE  FORM_NAME = 'frmBranch'
	UPDATE dbo.CHI_TIET_FORMS SET	LOG_VIEW  = 1 WHERE  FORM_NAME = 'frmDanhmuchethong'

END   
GO
if exists(select * from sys.columns 
            where Name = N'MENU_ID' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
BEGIN
    UPDATE dbo.CHI_TIET_FORMS SET MENU_ID = N'mnuEquipmentInformation' WHERE  FORM_NAME = 'frmThongtinthietbi'
    UPDATE dbo.CHI_TIET_FORMS SET MENU_ID = N'mnuWork' WHERE  FORM_NAME = 'frmDanhmuccongviec'
    UPDATE dbo.CHI_TIET_FORMS SET MENU_ID = N'mnuArea' WHERE  FORM_NAME = 'frmBranch'
    UPDATE dbo.CHI_TIET_FORMS SET MENU_ID = N'mnuHeThong' WHERE  FORM_NAME = 'frmDanhmuchethong'

END   




