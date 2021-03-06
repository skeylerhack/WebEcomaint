
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetPhieuBTPSDV')
   exec('CREATE PROCEDURE [dbo].[spGetPhieuBTPSDV] AS BEGIN SET NOCOUNT ON; END')
GO
--SELECT TOP 1 MS_PHIEU_BAO_TRI INTO  AAA3A FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WOS-201507001067'
--EXEC spGetPhieuBTPSDV 'ADMIN','AAA3A'
--SELECT * FROM AAA   WO-201401000001

ALTER PROC spGetPhieuBTPSDV
	@UName NVARCHAR(100),
	@BTAM NVARCHAR(100)
AS
DECLARE @DNgay DATETIME
SET @DNgay = GETDATE()

SELECT * INTO #MAY_USER FROM [dbo].[MGetMayUserNgay]( @DNgay,@UName,'-1',-1,-1,'-1','-1','-1',0)

CREATE TABLE #PBT (MS_PHIEU_BAO_TRI NVARCHAR(50))
DECLARE @sSql NVARCHAR (4000)
SET @sSql = 'INSERT INTO #PBT (MS_PHIEU_BAO_TRI) SELECT DISTINCT MS_PHIEU_BAO_TRI FROM ' + @BTAM
EXEC (@sSQL)

SELECT     T1.MS_PHIEU_BAO_TRI, T1.MS_MAY, T2.TEN_MAY, TEN_BP_CHIU_PHI
FROM         dbo.PHIEU_BAO_TRI AS T1 INNER JOIN
                      #MAY_USER AS T2 ON T1.MS_MAY = T2.MS_MAY 
WHERE  NOT EXISTS (SELECT * FROM #PBT AS T3 WHERE T3.MS_PHIEU_BAO_TRI = T1.MS_PHIEU_BAO_TRI)
AND TINH_TRANG_PBT < 3
ORDER BY NGAY_LAP,MS_PHIEU_BAO_TRI                      


--select id from Table1 where tid not in (select tid from Table2)
--select a.id from Table1 a inner join Table2 b on a.tid<>b.tid