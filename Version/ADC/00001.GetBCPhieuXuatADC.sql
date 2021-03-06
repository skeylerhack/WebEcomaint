IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetBCPhieuXuatADC')
   exec('CREATE PROCEDURE [dbo].[GetBCPhieuXuatADC] AS BEGIN SET NOCOUNT ON; END')
GO
--SELECT * FROM IC_DON_HANG_XUAT_VAT_TU WHERE MS_DH_XUAT_PT = N'PX-1409-0005'
--EXEC GetBCPhieuXuatADC 'PX-1406-0009',0
ALTER PROC [dbo].[GetBCPhieuXuatADC]
	@MS_DH_XUAT_PT NVARCHAR(50),
	@NNgu INT
AS

SELECT     T1.SO_PHIEU_XN, T1.MS_DH_XUAT_PT, T1.NGAY, T5.TEN_KHO, T1.LY_DO_XUAT, T6.TEN AS HO_TEN, T1.GHI_CHU AS GC_PX, T9.MS_PHIEU_BAO_TRI, T9.SO_PHIEU_BAO_TRI, T8.TEN_MAY, 
      T4.MS_PT, T4.TEN_PT, T4.QUY_CACH, T4.MS_PT_NCC, CASE @NNgu WHEN 0 THEN T7.TEN_1 WHEN 2 THEN T7.TEN_2 ELSE T7.TEN_3 END AS DVT,
      SUM(T2.SO_LUONG_THUC_XUAT) AS SL_XUAT, AVG(T3.DON_GIA) AS DON_GIA , SUM(ISNULL(T2.SO_LUONG_THUC_XUAT, 0) * T3.DON_GIA) AS TTIEN, T2.GHI_CHU 
FROM         dbo.DON_VI_TINH AS T7 INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT INNER JOIN
                          (SELECT     TOP (100) PERCENT T2.MS_DH_XUAT_PT, T2.MS_PT, AVG(ISNULL(T1.DON_GIA_GOC, 0) * ISNULL(T1.TY_GIA, 0)) AS DON_GIA
                            FROM          dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T2 INNER JOIN
                                                   dbo.IC_DON_HANG_NHAP_VAT_TU AS T1 ON T2.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND T2.MS_PT = T1.MS_PT AND T2.ID_XUAT = T1.ID
                            GROUP BY T2.MS_DH_XUAT_PT, T2.MS_PT
                            ORDER BY T2.MS_DH_XUAT_PT, T2.MS_PT) AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT AND T2.MS_PT = T3.MS_PT INNER JOIN
                      dbo.IC_KHO AS T5 ON T1.MS_KHO = T5.MS_KHO INNER JOIN
                      dbo.IC_PHU_TUNG AS T4 ON T2.MS_PT = T4.MS_PT ON T7.DVT = T4.DVT LEFT OUTER JOIN
                      (SELECT MS_CONG_NHAN AS MA, HO + ' ' + TEN AS TEN   FROM         dbo.CONG_NHAN UNION SELECT    MS_KH, TEN_RUT_GON FROM         dbo.KHACH_HANG)
                      AS T6 ON T1.NGUOI_NHAN = T6.MA LEFT OUTER JOIN
                      dbo.MAY AS T8 INNER JOIN
                      dbo.PHIEU_BAO_TRI AS T9 ON T8.MS_MAY = T9.MS_MAY ON T1.MS_PHIEU_BAO_TRI = T9.MS_PHIEU_BAO_TRI
WHERE     (T1.MS_DH_XUAT_PT = @MS_DH_XUAT_PT)                      
GROUP BY T1.SO_PHIEU_XN, T1.MS_DH_XUAT_PT, T1.NGAY, T5.TEN_KHO, T1.LY_DO_XUAT, T6.TEN, T1.GHI_CHU, T9.MS_PHIEU_BAO_TRI, T9.SO_PHIEU_BAO_TRI, T8.TEN_MAY, T4.MS_PT, 
                      T4.TEN_PT, T4.QUY_CACH, T4.MS_PT_NCC, T7.TEN_1, T7.TEN_2, T7.TEN_3,T2.GHI_CHU
ORDER BY   T1.SO_PHIEU_XN, T1.MS_DH_XUAT_PT, T1.NGAY, T5.TEN_KHO, T1.LY_DO_XUAT, T6.TEN , T1.GHI_CHU , T9.MS_PHIEU_BAO_TRI, T9.SO_PHIEU_BAO_TRI, T8.TEN_MAY, 
      T4.MS_PT, T4.TEN_PT, T4.QUY_CACH, T4.MS_PT_NCC, CASE @NNgu WHEN 0 THEN T7.TEN_1 WHEN 2 THEN T7.TEN_2 ELSE T7.TEN_3 END                       
                      


