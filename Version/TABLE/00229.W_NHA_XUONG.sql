
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_NHA_XUONG'))
BEGIN
    ALTER TABLE dbo.W_NHA_XUONG ADD ID_LOG BIGINT
END   
GO

--SELECT * FROM dbo.W_NHA_XUONG  (frmBranch)
DECLARE @FormLog NVARCHAR(50) = 'frmBranch'
--SELECT * FROM dbo.MENU ORDER BY MENU_TEXT (mnuArea)
DECLARE @MenuLog NVARCHAR(50) = 'mnuArea'
DECLARE @TableLog NVARCHAR(50) = 'W_NHA_XUONG'
--update vao table CHI_TIET_FORMS 2 gia tri logview = 1 (= 1 là có coi log = null là kg có coi ) va menu moi tim ra 
UPDATE dbo.CHI_TIET_FORMS SET LOG_VIEW = 1, MENU_ID = @MenuLog WHERE FORM_NAME = @FormLog



--cap nhap IDLog (ID_LOG) vao table luu log 
-- nho coi store va cap nhap lai cach viết thêm thao tac và luu ID LOG theo dung store cap nhap log 
UPDATE W_NHA_XUONG SET	ID_LOG =  T2.ID FROM
	dbo.W_NHA_XUONG T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(ID_LOG ,'') = ''

 --cap nhập thao tac (THAOTAC) vào table log chung (W_LOG)
UPDATE W_LOG SET	THAOTAC =  T1.THAOTAC FROM
	dbo.W_CONG_VIEC T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(T2.THAOTAC ,0) = 0
