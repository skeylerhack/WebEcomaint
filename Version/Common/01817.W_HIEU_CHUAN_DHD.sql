--SELECT * FROM dbo.W_HIEU_CHUAN_DHD
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_HIEU_CHUAN_DHD'))
BEGIN
    ALTER TABLE dbo.W_HIEU_CHUAN_DHD ADD ID_LOG BIGINT
END   
GO

--SELECT * FROM dbo.W_HIEU_CHUAN_DHD  (frmHieuchuan)
DECLARE @FormLog NVARCHAR(50) = 'frmHieuchuan'
--SELECT * FROM dbo.MENU ORDER BY MENU_TEXT (mnuHieuchuan)
DECLARE @MenuLog NVARCHAR(50) = 'mnuHieuchuan'

DECLARE @TableLog NVARCHAR(50) = 'W_HIEU_CHUAN_DHD'
--update vao table CHI_TIET_FORMS 2 gia tri logview = 1 (= 1 là có coi log = null là kg có coi ) va menu moi tim ra 
UPDATE dbo.CHI_TIET_FORMS SET LOG_VIEW = 1, MENU_ID = @MenuLog WHERE FORM_NAME = @FormLog




--cap nhap IDLog (ID_LOG) vao table luu log 
-- nho coi store va cap nhap lai cach viết thêm thao tac và luu ID LOG theo dung store cap nhap log 
UPDATE W_HIEU_CHUAN_DHD SET	ID_LOG =  T2.ID FROM
	dbo.W_HIEU_CHUAN_DHD T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(ID_LOG ,'') = ''

 --cap nhập thao tac (THAOTAC) vào table log chung (W_LOG)
UPDATE W_LOG SET	THAOTAC =  T1.THAO_TAC FROM
	dbo.W_HIEU_CHUAN_DHD T1 INNER JOIN (
	SELECT * FROM dbo.W_LOG WHERE FORM_NAME = @FormLog) T2 ON T1.CREATEDATE = T2.NGAY 
	WHERE ISNULL(T2.THAOTAC ,0) = 0
