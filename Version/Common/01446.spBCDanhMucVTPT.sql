
ALTER PROC [dbo].[spBCDanhMucVTPT]
	@LBaoCao INT = 0,
	@UName NVARCHAR(50) = 'admin',
	@NNgu INT = 0,
	@LMay NVARCHAR(50) = '-1',
	@LVTu NVARCHAR(50) = '-1',
	@LPTung INT = -1
as
-- @LBaoCao = 0 BC report
-- @LBaoCao = 1 xuat excel

SELECT DISTINCT T1.MS_LOAI_PT INTO #USERLPT FROM NHOM_LOAI_PHU_TUNG T1 INNER JOIN USERS T2 ON T1.GROUP_ID = T2.GROUP_ID WHERE USERNAME = @UName
SELECT DISTINCT T1.MS_LOAI_MAY INTO  #USERLMAY FROM NHOM_LOAI_MAY T1 INNER JOIN USERS T2 ON T1.GROUP_ID = T2.GROUP_ID WHERE USERNAME = @UName
SELECT MS_PT, SUM(SL_VT) AS SL_VT INTO #TONPT FROM VI_TRI_KHO_VAT_TU WHERE ISNULL(SL_VT,0) > 0 GROUP BY MS_PT



SELECT        ROW_NUMBER() OVER (ORDER BY  T1.MS_PT, T1.MS_PT_NCC, T1.MS_PT_CTY, T1.TEN_PT, T1.QUY_CACH, T6.TEN_1, T6.TEN_2, T9.MS_LOAI_VT) AS STT,
T1.MS_PT, T1.MS_PT_CTY, T1.MS_PT_NCC, T10.TEN_CLASS, T1.TEN_PT, T1.TEN_PT_VIET, T1.QUY_CACH, T1.ANH_PT,T9.MS_LOAI_VT, 
						CASE 0 WHEN 0 THEN T9.TEN_LOAI_VT_TV WHEN 1 THEN ISNULL(NULLIF (T9.TEN_LOAI_VT_TA, ''), 
                         T9.TEN_LOAI_VT_TV) ELSE ISNULL(NULLIF (T9.TEN_LOAI_VT_TH, ''), T9.TEN_LOAI_VT_TV) END AS TEN_LOAI_VT, CASE 0 WHEN 0 THEN T6.TEN_1 ELSE ISNULL(NULLIF (T6.TEN_2, ''), T6.TEN_1) END AS TEN_DVT, T6.TEN_1, 
                         T6.TEN_2, dbo.CACH_DAT_HANG.CACH_DAT_HANG, T11.SERVICE_LEVEL, T12.TEN_HSX, T13.TEN_CONG_TY, 
						 CASE ISNULL(T1.HANG_NGOAI,0) WHEN 0 THEN NULL ELSE 'x' END AS HANG_NGOAI, 
						 CASE ISNULL(T1.DUNG_CU_DO,0) WHEN 0 THEN NULL ELSE 'x' END AS DUNG_CU_DO,  
						 CASE ISNULL(T1.VAT_TU_PT,0) WHEN 0 THEN NULL ELSE 'x' END AS VAT_TU_PT,
						 CASE ISNULL(T1.ACTIVE_PT,0) WHEN 0 THEN NULL ELSE 'x' END AS ACTIVE_PT,
						 T4.MS_LOAI_MAY, 
                         CASE 0 WHEN 0 THEN T4.TEN_LOAI_MAY WHEN 1 THEN ISNULL(NULLIF (T4.TEN_LOAI_MAY_ANH, ''), T4.TEN_LOAI_MAY) ELSE ISNULL(NULLIF (T4.TEN_LOAI_MAY_HOA, ''), T4.TEN_LOAI_MAY) END AS TEN_LOAI_MAY, 
                         T5.MS_LOAI_PT, T5.TEN_LOAI_PT, T1.TON_TOI_THIEU, T1.TON_KHO_MAX,
						 SL_VT AS TON_HT,
						 T1.SO_NGAY_DAT_MUA_HANG
FROM            dbo.IC_PHU_TUNG AS T1 INNER JOIN
                         dbo.IC_PHU_TUNG_LOAI_MAY AS T2 ON T1.MS_PT = T2.MS_PT INNER JOIN
                         dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T3 ON T1.MS_PT = T3.MS_PT INNER JOIN
                         dbo.LOAI_MAY AS T4 ON T2.MS_LOAI_MAY = T4.MS_LOAI_MAY INNER JOIN
                         dbo.LOAI_PHU_TUNG AS T5 ON T3.MS_LOAI_PT = T5.MS_LOAI_PT INNER JOIN
                         dbo.DON_VI_TINH AS T6 ON T1.DVT = T6.DVT INNER JOIN
                         dbo.LOAI_VT AS T9 ON T1.MS_LOAI_VT = T9.MS_LOAI_VT INNER JOIN
                         #USERLPT AS T7 ON T3.MS_LOAI_PT = T7.MS_LOAI_PT INNER JOIN
                         #USERLMAY AS T8 ON T2.MS_LOAI_MAY = T8.MS_LOAI_MAY LEFT OUTER JOIN
                         dbo.KHACH_HANG AS T13 ON T1.MS_KH = T13.MS_KH LEFT OUTER JOIN
                         dbo.HANG_SAN_XUAT AS T12 ON T1.MS_HSX = T12.MS_HSX LEFT OUTER JOIN
                         dbo.SERVICE_LEVEL AS T11 ON T1.SERVICE_ID = T11.SERVICE_ID LEFT OUTER JOIN
                         dbo.CACH_DAT_HANG ON T1.MS_CACH_DAT_HANG = dbo.CACH_DAT_HANG.MS_CACH_DAT_HANG LEFT OUTER JOIN
                         dbo.CLASS_VT AS T10 ON T1.MS_CLASS = T10.MS_CLASS 
						 LEFT JOIN #TONPT AS T14 ON T1.MS_PT = T14.MS_PT
WHERE        (T2.MS_LOAI_MAY = @LMay OR @LMay = '-1') AND (T3.MS_LOAI_PT = @LPTung OR @LPTung = -1) AND (T1.MS_LOAI_VT = @LVTu OR @LVTu = '-1')
ORDER BY  T1.MS_PT, T1.MS_PT_NCC, T1.MS_PT_CTY, T1.TEN_PT, T1.QUY_CACH, T6.TEN_1, T6.TEN_2, T9.MS_LOAI_VT