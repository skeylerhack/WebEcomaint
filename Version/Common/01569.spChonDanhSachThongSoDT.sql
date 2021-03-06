IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spChonDanhSachThongSoDT')
   exec('CREATE PROCEDURE spChonDanhSachThongSoDT AS BEGIN SET NOCOUNT ON; END')
GO
--load danh sách tham số định tính từ bảng tạm
ALTER PROCEDURE [dbo].[spChonDanhSachThongSoDT]
	@BT NVARCHAR(100) = 'GIA_TRI_TMPADMIN',
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
BEGIN

CREATE TABLE #BTGT 
(
	[CHON] [BIT] NULL,
	[TEN_GIA_TRI] [NVARCHAR](255) NOT NULL,
	[DAT] [BIT] NULL,
	[GHI_CHU] [NVARCHAR](255) NULL,
	[STT] [INT] NOT NULL,
	[MS_MAY] [NVARCHAR](30) NOT NULL,
	[MS_TS_GSTT] [NVARCHAR](10) NOT NULL,
	[MS_BO_PHAN] [NVARCHAR](50) NOT NULL,
	[MS_TT] [INT] NOT NULL,
	[THOI_GIAN] FLOAT,
	[TG_TT] FLOAT
)
DECLARE @sSql	NVARCHAR(MAX)
SET @sSql	= 'INSERT INTO #BTGT ([CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT]) SELECT [CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT] FROM ' + @BT 
EXEC (@sSql)
SELECT DISTINCT  T1.MS_MAY ,
                CASE @NNgu
                  WHEN 0 THEN T5.TEN_MAY
                  WHEN 1 THEN ISNULL(NULLIF(T5.TEN_MAY_ANH, ''), T5.TEN_MAY)
                  ELSE ISNULL(NULLIF(T5.TEN_MAY_HOA, ''), T5.TEN_MAY)
                END AS TEN_MAY ,
                T1.MS_BO_PHAN ,
                T4.TEN_BO_PHAN ,
                CASE @NNgu
                  WHEN 0 THEN T6.TEN_TS_GSTT
                  WHEN 1
                  THEN ISNULL(NULLIF(T6.TEN_TS_GSTT_ANH, ''), T6.TEN_TS_GSTT)
                  ELSE ISNULL(NULLIF(T6.TEN_TS_GSTT_HOA, ''), T6.TEN_TS_GSTT)
                END AS TEN_TS_GSTT ,
                T1.THOI_GIAN AS TG_XU_LY ,
                T1.MS_TS_GSTT ,
                T1.TG_TT,
				T1.MS_TT,
				-99 AS  STT,
				NULL AS CT_CVIEC,
				ISNULL(T1.DAT,0) AS DAT
        FROM    #BTGT AS T1
                INNER JOIN dbo.THONG_SO_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT
                JOIN CAU_TRUC_THIET_BI T4 ON T4.MS_BO_PHAN = T1.MS_BO_PHAN
                                             AND T4.MS_MAY = T1.MS_MAY
                JOIN dbo.MAY T5 ON T5.MS_MAY = T1.MS_MAY 
                JOIN THONG_SO_GSTT T6 ON T6.MS_TS_GSTT = T1.MS_TS_GSTT       
				WHERE   T1.CHON =1
				ORDER BY TEN_MAY,T4.TEN_BO_PHAN,TEN_TS_GSTT
END

