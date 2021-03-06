IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DanhSachGiamSatTinhTrangDinhTinh')
   exec('CREATE PROCEDURE sp_DanhSachGiamSatTinhTrangDinhTinh AS BEGIN SET NOCOUNT ON; END')
GO
--danh sách định tính từ database
ALTER PROC [dbo].[sp_DanhSachGiamSatTinhTrangDinhTinh]
    @STT INT = 3,
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
    BEGIN
        SELECT DISTINCT T1.MS_MAY ,
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
                T1.THOI_GIAN AS TG_XU_LY,
                T1.MS_TS_GSTT ,
                T1.TG_TT,
				T1.MS_TT,
				T1.STT,
				NULL AS CT_CVIEC,
				ISNULL(T3.DAT,0) AS DAT
FROM            dbo.GIAM_SAT_TINH_TRANG_TS AS T1 INNER JOIN
                         dbo.THONG_SO_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T4 ON T4.MS_BO_PHAN = T1.MS_BO_PHAN AND T4.MS_MAY = T1.MS_MAY INNER JOIN
                         dbo.MAY AS T5 ON T5.MS_MAY = T1.MS_MAY INNER JOIN
                         dbo.THONG_SO_GSTT AS T6 ON T6.MS_TS_GSTT = T1.MS_TS_GSTT INNER JOIN 
						 dbo.GIAM_SAT_TINH_TRANG_TS_DT T7 ON T7.STT = T1.STT AND T7.MS_MAY = T1.MS_MAY AND T7.MS_TS_GSTT = T1.MS_TS_GSTT AND T7.MS_BO_PHAN = T1.MS_BO_PHAN AND								T7.MS_TT = T1.MS_TT INNER JOIN dbo.GIA_TRI_TS_GSTT AS T3 ON T1.MS_TS_GSTT = T3.MS_TS_GSTT AND T3.STT = T7.STT_GT
        WHERE   T1.STT = @STT
                AND T2.LOAI_TS = 1
				ORDER BY TEN_MAY,T4.TEN_BO_PHAN,TEN_TS_GSTT
    END