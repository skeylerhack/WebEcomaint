
--exec SP_NHU_Y_GET_DON_HANG_NHAP 'Admin',-1,'08-01-2016','08-30-2019',0
ALTER procedure [dbo].[SP_NHU_Y_GET_DON_HANG_NHAP]
@USERNAME NVARCHAR (50),
@Kho int,
@TuNgay datetime,
@DenNgay datetime,
@IsLock bit
as
begin

SELECT     T1.MS_KHO INTO #KHO_USER 
FROM         dbo.NHOM_KHO AS T1 INNER JOIN
                      dbo.USERS AS T2 ON T1.GROUP_ID = T2.GROUP_ID 
WHERE     (T2.USERNAME = N'admin')


SELECT     TOP (100) PERCENT T1.MS_DH_NHAP_PT, T1.SO_PHIEU_XN, T1.GIO, T1.NGAY, T1.MS_KHO, T2.TEN_KHO, T1.MS_DANG_NHAP, T1.NGUOI_NHAP, T1.NGAY_CHUNG_TU, T1.SO_CHUNG_TU, 
                      T1.DIEM, T1.DANH_GIA, T1.GHI_CHU, T1.LOCK, T1.STT, T1.DA_HET, T1.THU_KHO, T1.MS_DDH,
                       T1.SO_DE_XUAT, T1.NGUOI_GIAO, T1.BSXE, T1.DIEM1, T1.DIEM2, T1.LY_DO, T1.CAN_CU, 
                      T1.THU_KHO_KY, T1.NGUOI_LAP, T1.MS_DHX, 
                      T1.CP_NHAP_KHAU, T1.CP_KHAC, T1.MS_LY_DO_NHAP_KT,
CASE ISNULL(RTRIM(T1.MS_DDH), '') WHEN '' THEN CASE T1.MS_DHX WHEN '-1' THEN '' ELSE T1.MS_DHX END ELSE T1.MS_DDH END AS MS_DON_HANG                      
                      
FROM         dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                      dbo.IC_KHO AS T2 ON T1.MS_KHO = T2.MS_KHO INNER JOIN
                      #KHO_USER AS T3 ON T1.MS_KHO = T3.MS_KHO
WHERE ('-1' = @KHO  or T1.MS_KHO=@Kho)
--AND ( CONVERT(NVARCHAR(10),T1.NGAY,101) >=@TuNgay AND T1.NGAY<@DenNgay )
AND ( CONVERT(DATETIME,CONVERT(NVARCHAR(10),T1.NGAY,101)) BETWEEN @TuNgay AND @DenNgay )
and (T1.LOCK=@IsLock)
ORDER BY T1.NGAY DESC, T1.MS_DH_NHAP_PT DESC
END
