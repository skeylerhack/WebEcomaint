IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'INSPBTTinhTrang')
   exec('CREATE PROCEDURE [dbo].[INSPBTTinhTrang] AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC INSPBTTinhTrang 'WO-201506000001','TTBTadmin'
ALTER PROC [dbo].[INSPBTTinhTrang]
	@MSPBT nvarchar(20),
	@BTam nvarchar(50)
AS

CREATE TABLE #PBTTT(
	[ID] [int] NOT NULL,
	[MS_PHIEU_BAO_TRI] [nvarchar](20) NULL,
	[THONG_SO_DO] [nvarchar](500) NULL,
	[THIET_BI_DO] [nvarchar](500) NULL,
	[TT_TRUOC_BT] [nvarchar](500) NULL,
	[TT_SAU_BT] [nvarchar](500) NULL,
	[MS_DV_DO] [smallint] NULL,
	[XAC_NHAN] [bit] NULL,
	[GHI_CHU] [nvarchar](500) NULL,
	[USER_XN] [nvarchar](50) NULL,
)

DECLARE @SQL NVARCHAR(4000)
SET @SQL = 'INSERT INTO #PBTTT ([ID],[MS_PHIEU_BAO_TRI],[THONG_SO_DO],[THIET_BI_DO],[TT_TRUOC_BT],[TT_SAU_BT],[MS_DV_DO],[XAC_NHAN],[GHI_CHU],[USER_XN])
				SELECT [ID],[MS_PHIEU_BAO_TRI],[THONG_SO_DO],[THIET_BI_DO],[TT_TRUOC_BT],[TT_SAU_BT],[MS_DV_DO],[XAC_NHAN],[GHI_CHU],[USER_XN] FROM ' + @BTam
EXEC (@SQL)
 

SET @SQL = ' DROP TABLE ' + @BTam
EXEC (@SQL)

SELECT IDENTITY(int, 1,1) as STT,ID,[MS_PHIEU_BAO_TRI],[THONG_SO_DO],[THIET_BI_DO],[TT_TRUOC_BT],[TT_SAU_BT],[MS_DV_DO],[XAC_NHAN],[GHI_CHU],[USER_XN] INTO #AAA
FROM #PBTTT ORDER BY ID





INSERT INTO [PHIEU_BAO_TRI_TINH_TRANG] (ID,[MS_PHIEU_BAO_TRI],[THONG_SO_DO],[THIET_BI_DO],[TT_TRUOC_BT],[TT_SAU_BT],[MS_DV_DO],[XAC_NHAN],[GHI_CHU],[USER_XN])
SELECT (SELECT ISNULL(MAX(ID),0)  FROM PHIEU_BAO_TRI_TINH_TRANG WHERE MS_PHIEU_BAO_TRI = @MSPBT) + STT,
[MS_PHIEU_BAO_TRI],[THONG_SO_DO],[THIET_BI_DO],[TT_TRUOC_BT],[TT_SAU_BT],[MS_DV_DO],[XAC_NHAN],[GHI_CHU],[USER_XN] FROM #AAA 
WHERE ISNULL([ID],-1) = -1 AND MS_PHIEU_BAO_TRI = @MSPBT

UPDATE [PHIEU_BAO_TRI_TINH_TRANG]
   SET [MS_PHIEU_BAO_TRI] = B.MS_PHIEU_BAO_TRI
      ,[THONG_SO_DO] = B.THONG_SO_DO
      ,[THIET_BI_DO] = B.THIET_BI_DO
      ,[TT_TRUOC_BT] = B.TT_TRUOC_BT
      ,[TT_SAU_BT] = B.TT_SAU_BT
      ,[MS_DV_DO] = B.MS_DV_DO
      ,[XAC_NHAN] = B.XAC_NHAN
      ,[GHI_CHU] = B.GHI_CHU
      ,[USER_XN] = B.USER_XN
FROM [PHIEU_BAO_TRI_TINH_TRANG] A INNER JOIN #PBTTT B ON A.ID = B.ID
 WHERE ISNULL(B.[ID],-1) <> -1 AND A.MS_PHIEU_BAO_TRI = @MSPBT


