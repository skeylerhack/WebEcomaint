if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_LOAI_BAO_TRI_QH'))
BEGIN
    ALTER TABLE dbo.W_LOAI_BAO_TRI_QH ADD ID_LOG BIGINT
END   
GO
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_LOAI_BAO_TRI'))
BEGIN
    ALTER TABLE dbo.W_LOAI_BAO_TRI ADD ID_LOG BIGINT
END   
GO
if not exists(select * from sys.columns  
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_HINH_THUC_BAO_TRI'))
BEGIN
    ALTER TABLE dbo.W_HINH_THUC_BAO_TRI ADD ID_LOG BIGINT
END   
GO
-- tim ten menu trong table menu va form trong chi tiet form
DECLARE @FormLog NVARCHAR(50) = 'frmBaoTri'
DECLARE @MenuLog NVARCHAR(50) = 'mnuMaintenanceForm'
DECLARE @TableLog NVARCHAR(50) = 'W_HINH_THUC_BAO_TRI'

--update vao table CHI_TIET_FORMS 2 gia tri logview = 1 (= 1 là có coi log = null là kg có coi ) va menu moi tim ra 
UPDATE dbo.CHI_TIET_FORMS SET LOG_VIEW = 1, MENU_ID = @MenuLog WHERE FORM_NAME = @FormLog

--cap nhap IDLog (ID_LOG) vao table luu log 
-- nho coi store va cap nhap lai cach viết thêm thao tac và luu ID LOG theo dung store cap nhap log 
UPDATE W_HINH_THUC_BAO_TRI SET	ID_LOG =  T2.ID FROM
	dbo.W_HINH_THUC_BAO_TRI T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(ID_LOG ,'') = ''

 --cap nhập thao tac (THAOTAC) vào table log chung (W_LOG)
UPDATE W_LOG SET	THAOTAC =  T1.THAO_TAC FROM
	dbo.W_HINH_THUC_BAO_TRI T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(T2.THAOTAC ,0) = 0
	

--W_LOAI_BAO_TRI

--cap nhap IDLog (ID_LOG) vao table luu log 
-- nho coi store va cap nhap lai cach viết thêm thao tac và luu ID LOG theo dung store cap nhap log 
UPDATE dbo.W_LOAI_BAO_TRI SET	ID_LOG =  T2.ID FROM
	dbo.W_LOAI_BAO_TRI T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = '') T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(ID_LOG ,'') = ''

 --cap nhập thao tac (THAOTAC) vào table log chung (W_LOG)
UPDATE W_LOG SET	THAOTAC =  T1.THAO_TAC FROM
	dbo.W_LOAI_BAO_TRI T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = 'frmBaoTri') T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(T2.THAOTAC ,0) = 0


--W_LOAI_BAO_TRI_QH

--cap nhap IDLog (ID_LOG) vao table luu log 
-- nho coi store va cap nhap lai cach viết thêm thao tac và luu ID LOG theo dung store cap nhap log 
UPDATE dbo.W_LOAI_BAO_TRI_QH SET	ID_LOG =  T2.ID FROM
	dbo.W_LOAI_BAO_TRI_QH T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = 'FrmLoaiBTQH') T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(ID_LOG ,'') = ''

 --cap nhập thao tac (THAOTAC) vào table log chung (W_LOG)
UPDATE W_LOG SET	THAOTAC =  T1.THAO_TAC FROM
	dbo.W_LOAI_BAO_TRI_QH T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = 'FrmLoaiBTQH') T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(T2.THAOTAC ,0) = 0