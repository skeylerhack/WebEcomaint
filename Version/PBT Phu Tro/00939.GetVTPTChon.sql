
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetVTPTChon')
   exec('CREATE PROCEDURE GetVTPTChon AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC GetVTPTChon 'ADMIN',"CVPTVTPT_CHONAdmin",0
ALTER procedure [dbo].[GetVTPTChon]
	@UserName NVARCHAR(50),
	@VTuPTung NVARCHAR(50),
	@NNgu INT
AS

IF OBJECT_ID('tempdb..#PhuTung') IS NOT NULL
	DROP TABLE #PhuTung  

CREATE TABLE #PhuTung(
	[MS_PT] [nvarchar](250) NULL
)
DECLARE @Sql NVARCHAR(4000)

SET @Sql = 'INSERT INTO #PhuTung SELECT DISTINCT [MS_PT] FROM ' + @VTuPTung
EXEC (@Sql)


SELECT DISTINCT CONVERT(BIT, 0) AS CHON, T4.MS_PT, T4.MS_PT_NCC, 
CASE @NNgu WHEN 0 THEN T4.TEN_PT WHEN 1 THEN ISNULL(T4.TEN_PT_ANH,TEN_PT) ELSE T4.TEN_PT_HOA END TEN_PT, T4.QUY_CACH
FROM            dbo.USERS AS T1 INNER JOIN
                         dbo.NHOM_LOAI_PHU_TUNG AS T2 ON T1.GROUP_ID = T2.GROUP_ID INNER JOIN
                         dbo.LOAI_PHU_TUNG AS T3 ON T2.MS_LOAI_PT = T3.MS_LOAI_PT INNER JOIN
                         dbo.IC_PHU_TUNG AS T4 INNER JOIN
                         dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T5 ON T4.MS_PT = T5.MS_PT ON T3.MS_LOAI_PT = T5.MS_LOAI_PT
WHERE        (T1.USERNAME = @UserName) AND NOT EXISTS (SELECT * FROM #PhuTung T6 WHERE T4.MS_PT = T6.MS_PT)
ORDER BY T4.MS_PT, T4.MS_PT_NCC
