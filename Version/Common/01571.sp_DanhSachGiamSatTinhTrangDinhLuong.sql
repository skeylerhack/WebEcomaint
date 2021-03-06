IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DanhSachGiamSatTinhTrangDinhLuong')
   exec('CREATE PROCEDURE sp_DanhSachGiamSatTinhTrangDinhLuong AS BEGIN SET NOCOUNT ON; END')
GO
--danh sách định lượng
ALTER PROCEDURE [dbo].[sp_DanhSachGiamSatTinhTrangDinhLuong]
    @STT INT = 6156 ,
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
BEGIN
    SELECT  T1.MS_MAY,
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
            T2.TEN_TS_GSTT,
            T1.GIA_TRI_DO ,
			T5.TEN_GT,
			T6.TEN_DV_DO,
            T1.THOI_GIAN ,
            T1.TG_TT,
			T1.MS_TT,	
			NULL AS CT_CVIEC

    FROM    dbo.GIAM_SAT_TINH_TRANG_TS AS T1
            INNER JOIN dbo.THONG_SO_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT
            INNER JOIN dbo.CAU_TRUC_THIET_BI AS T3 ON T1.MS_MAY = T3.MS_MAY
                                                      AND T1.MS_BO_PHAN = T3.MS_BO_PHAN
            INNER JOIN dbo.MAY AS T4 ON T3.MS_MAY = T4.MS_MAY
            INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT T5 ON T5.MS_MAY = T1.MS_MAY
                                                       AND T5.MS_BO_PHAN = T1.MS_BO_PHAN
                                                       AND T5.MS_TS_GSTT = T1.MS_TS_GSTT
                                                       AND T5.MS_TT = T1.MS_TT
            INNER JOIN dbo.DON_VI_DO T6 ON T6.MS_DV_DO = T2.MS_DV_DO
    WHERE   T1.STT = @STT
            AND T2.LOAI_TS = 0
    ORDER BY T1.MS_MAY ,
            T4.TEN_MAY 
   end