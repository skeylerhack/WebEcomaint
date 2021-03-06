IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DSGiamSatTinhTrangDinhLuongByBT')
   exec('CREATE PROCEDURE sp_DSGiamSatTinhTrangDinhLuongByBT AS BEGIN SET NOCOUNT ON; END')
GO
--danh sách định lượng theo bang tam
ALTER PROCEDURE [dbo].[sp_DSGiamSatTinhTrangDinhLuongByBT]
    --@STT INT = 120 ,
	@BT NVARCHAR(100) = 'GIA_TRI_TMPDLAdmin',
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
BEGIN

CREATE TABLE #BTGT 
(
	[MS_MAY] [NVARCHAR](30) NOT NULL,
	[MS_TS_GSTT] [NVARCHAR](10) NOT NULL,
	[MS_BO_PHAN] [NVARCHAR](50) NOT NULL,
	[MS_TT] [INT] NOT NULL,
	[THOI_GIAN] FLOAT,
	[TG_TT] FLOAT,
	[GIA_TRI_DO] FLOAT,
	--[TEN_GT] NVARCHAR(150),
	--[GIA_TRI_TREN] FLOAT,
	--[GIA_TRI_DUOI] FLOAT,
)

DECLARE @sSql	NVARCHAR(MAX)
SET @sSql	= 'INSERT INTO #BTGT ([MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT],[GIA_TRI_DO]) SELECT [MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT],[GIA_TRI_DO] FROM ' + @BT
EXEC (@sSql)
    SELECT  DISTINCT T1.MS_MAY,
            CASE @NNgu
              WHEN 1 THEN T4.TEN_MAY
              WHEN 2 THEN ISNULL(NULLIF(T4.TEN_MAY_ANH, ''), T4.TEN_MAY)
              ELSE ISNULL(NULLIF(T4.TEN_MAY_HOA, ''), T4.TEN_MAY)
            END AS TEN_MAY ,
            T3.MS_BO_PHAN ,
            CASE @NNgu
              WHEN 1 THEN TEN_BO_PHAN
              WHEN 2 THEN ISNULL(NULLIF(T3.TEN_BO_PHAN_ANH, ''), TEN_BO_PHAN)
              ELSE ISNULL(NULLIF(T3.TEN_BO_PHAN_HOA, ''), TEN_BO_PHAN)
            END AS TEN_BO_PHAN ,
			T1.MS_TS_GSTT,	
            T2.TEN_TS_GSTT ,
            T1.GIA_TRI_DO,
			T5.TEN_GT,
			T6.TEN_DV_DO,
            T1.THOI_GIAN ,
            T1.TG_TT,	
			T1.MS_TT,
			NULL AS CT_CVIEC
    FROM    #BTGT AS T1
            INNER JOIN dbo.THONG_SO_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT
            INNER JOIN dbo.CAU_TRUC_THIET_BI AS T3 ON T1.MS_MAY = T3.MS_MAY
                                                      AND T1.MS_BO_PHAN = T3.MS_BO_PHAN
            INNER JOIN dbo.MAY AS T4 ON T3.MS_MAY = T4.MS_MAY
            INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT T5 ON T5.MS_MAY = T1.MS_MAY
                                                       AND T5.MS_BO_PHAN = T1.MS_BO_PHAN
                                                       AND T5.MS_TS_GSTT = T1.MS_TS_GSTT
                                                       AND T5.MS_TT = T1.MS_TT
            INNER JOIN dbo.DON_VI_DO T6 ON T6.MS_DV_DO = T2.MS_DV_DO
    WHERE    T2.LOAI_TS = 0 AND T1.GIA_TRI_DO IS NOT NULL

	ORDER BY T1.MS_MAY,TEN_MAY
END
            