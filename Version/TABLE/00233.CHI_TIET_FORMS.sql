if not exists(select * from sys.columns 
            where Name = N'AN_HIEN' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
begin
    ALTER TABLE dbo.CHI_TIET_FORMS ADD AN_HIEN BIT  DEFAULT (0)
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_HINH_THUC_BAO_TRI'))
begin
    ALTER TABLE dbo.W_HINH_THUC_BAO_TRI ADD ID_LOG bigint
END    
GO	

if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_LOAI_BAO_TRI'))
begin
    ALTER TABLE dbo.W_LOAI_BAO_TRI ADD ID_LOG bigint
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_NHA_XUONG'))
begin
    ALTER TABLE dbo.W_NHA_XUONG ADD ID_LOG bigint
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_HE_THONG'))
begin
    ALTER TABLE dbo.W_HE_THONG ADD ID_LOG bigint
END    
GO	


if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_LOAI_BAO_TRI_QH'))
begin
    ALTER TABLE dbo.W_LOAI_BAO_TRI_QH ADD ID_LOG bigint
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'MENU_ID' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
begin
    ALTER TABLE dbo.CHI_TIET_FORMS ADD MENU_ID NVARCHAR(255)
END    
go
if not exists(select * from sys.columns 
            where Name = N'LOG_VIEW' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
begin
    ALTER TABLE dbo.CHI_TIET_FORMS ADD LOG_VIEW NVARCHAR(255)
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'STT' and Object_ID = Object_ID(N'CHI_TIET_FORMS'))
begin
    ALTER TABLE dbo.CHI_TIET_FORMS ADD STT INT  
END    

GO	
if not exists(select * from sys.columns 
            where Name = N'THAOTAC' and Object_ID = Object_ID(N'W_LOG'))
begin
    ALTER TABLE dbo.W_LOG ADD THAOTAC INT  
END 
GO

if not exists(select * from sys.columns 
            where Name = N'ID_LOG' and Object_ID = Object_ID(N'W_CONG_VIEC'))
begin
    ALTER TABLE dbo.W_CONG_VIEC ADD [ID_LOG] [bigint] NULL  
	ALTER TABLE dbo.W_CONG_VIEC ADD [SO_NGUOI] [int] NULL  
	ALTER TABLE dbo.W_CONG_VIEC ADD [YEU_CAU_NS] [nvarchar] (1000)  
	ALTER TABLE dbo.W_CONG_VIEC ADD [YEU_CAU_DUNG_CU] [nvarchar] (100)  
END 
GO



WITH CHI_TIET_FORMSs AS
  (
    SELECT 
    ROW_NUMBER() OVER (ORDER BY TEN_FORMS_VIET ASC) AS RN,FORM_NAME, TEN_FORMS_VIET, TEN_FORMS_ANH, TEN_FORMS_HOA, CUSTUMER,
                                                           SHOW_IN, NOTE, LOG_VIEW, MENU_ID, AN_HIEN, STT
    FROM dbo.CHI_TIET_FORMS
  )
UPDATE CHI_TIET_FORMSs SET STT = CHI_TIET_FORMSs.RN WHERE CHI_TIET_FORMSs.STT IS NULL