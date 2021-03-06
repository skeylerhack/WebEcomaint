
--EXEC SP_NHU_Y_GET_DS_PT_EXPORT 0,'ADMIN'
ALTER PROC [dbo].[SP_NHU_Y_GET_DS_PT_EXPORT]
	@TYPELANG INT,
	@UserName NVARCHAR(50)
AS
SELECT DISTINCT 
                      A.MS_PT, A.MS_PT_CTY AS ITEM_CODE, A.MS_PT_NCC AS PART_NO, A.TEN_PT, A.QUY_CACH, 
                      CASE WHEN @TYPELANG = 0 THEN B.TEN_LOAI_VT_TV ELSE B.TEN_LOAI_VT_TA END AS LOAI_VAT_TU, CASE WHEN @TYPELANG = 0 THEN C.TEN_1 ELSE C.TEN_2 END AS DV_TINH, 
                      CONVERT(VARCHAR, A.DUNG_CU_DO) AS DUNG_CU_DO, D.CACH_DAT_HANG AS CACH_DH, A.SO_NGAY_DAT_MUA_HANG, A.TON_TOI_THIEU AS SL_TOI_THIEU, A.TON_KHO_MAX AS TON_TOI_DA,
                       F.TEN_CONG_TY AS NHA_CUNG_CAP_UT, E.TEN_HSX AS HANG_SX_GOC, G.TEN_CLASS, dbo.GET_LOAI_MAY(A.MS_PT) AS LOAI_TB_SD, dbo.GET_NOI_SD_PT(A.MS_PT) AS NOI_SU_DUNG, 
                      I.TEN_KHO, H.TEN_VI_TRI, CONVERT(NVARCHAR(1), ISNULL(A.HANG_NGOAI, 0)) AS HANG_NGOAI
FROM         dbo.IC_PHU_TUNG AS A LEFT OUTER JOIN
                      dbo.LOAI_VT AS B ON A.MS_LOAI_VT = B.MS_LOAI_VT LEFT OUTER JOIN
                      dbo.DON_VI_TINH AS C ON A.DVT = C.DVT LEFT OUTER JOIN
                      dbo.CACH_DAT_HANG AS D ON A.MS_CACH_DAT_HANG = D.MS_CACH_DAT_HANG LEFT OUTER JOIN
                      dbo.HANG_SAN_XUAT AS E ON A.MS_HSX = E.MS_HSX LEFT OUTER JOIN
                      dbo.KHACH_HANG AS F ON A.MS_KH = F.MS_KH LEFT OUTER JOIN
                      dbo.CLASS_VT AS G ON A.MS_CLASS = G.MS_CLASS LEFT OUTER JOIN
                      dbo.VI_TRI_KHO AS H ON A.MS_VI_TRI = H.MS_VI_TRI LEFT OUTER JOIN
                      dbo.IC_KHO AS I ON H.MS_KHO = I.MS_KHO LEFT OUTER JOIN
                      dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS K ON A.MS_PT = K.MS_PT INNER JOIN
                      dbo.NHOM_LOAI_PHU_TUNG AS L ON K.MS_LOAI_PT = L.MS_LOAI_PT INNER JOIN
                      dbo.USERS AS M ON L.GROUP_ID = M.GROUP_ID
WHERE     (M.USERNAME = @UserName) AND (A.THEO_KHO = 0)

UNION
SELECT DISTINCT 
                      A.MS_PT, A.MS_PT_CTY AS ITEM_CODE, A.MS_PT_NCC AS PART_NO, A.TEN_PT, A.QUY_CACH, 
                      CASE WHEN @TYPELANG = 0 THEN B.TEN_LOAI_VT_TV ELSE B.TEN_LOAI_VT_TA END AS LOAI_VAT_TU, CASE WHEN @TYPELANG = 0 THEN C.TEN_1 ELSE C.TEN_2 END AS DV_TINH, 
                      CONVERT(VARCHAR, A.DUNG_CU_DO) AS DUNG_CU_DO, D.CACH_DAT_HANG AS CACH_DH, A.SO_NGAY_DAT_MUA_HANG, X.TON_TOI_THIEU AS SL_TOI_THIEU, 
                      X.TON_KHO_MAX AS TON_TOI_DA, F.TEN_CONG_TY AS NHA_CUNG_CAP_UT, E.TEN_HSX AS HANG_SX_GOC, G.TEN_CLASS, dbo.GET_LOAI_MAY(A.MS_PT) AS LOAI_TB_SD, 
                      dbo.GET_NOI_SD_PT(A.MS_PT) AS NOI_SU_DUNG, I.TEN_KHO, H.TEN_VI_TRI, CONVERT(NVARCHAR(1), ISNULL(A.HANG_NGOAI, 0)) AS HANG_NGOAI
FROM         dbo.VI_TRI_KHO AS H LEFT OUTER JOIN
                      dbo.IC_PHU_TUNG AS A LEFT OUTER JOIN
                      dbo.LOAI_VT AS B ON A.MS_LOAI_VT = B.MS_LOAI_VT LEFT OUTER JOIN
                      dbo.DON_VI_TINH AS C ON A.DVT = C.DVT LEFT OUTER JOIN
                      dbo.CACH_DAT_HANG AS D ON A.MS_CACH_DAT_HANG = D.MS_CACH_DAT_HANG LEFT OUTER JOIN
                      dbo.HANG_SAN_XUAT AS E ON A.MS_HSX = E.MS_HSX LEFT OUTER JOIN
                      dbo.KHACH_HANG AS F ON A.MS_KH = F.MS_KH LEFT OUTER JOIN
                      dbo.CLASS_VT AS G ON A.MS_CLASS = G.MS_CLASS INNER JOIN
                      dbo.IC_PHU_TUNG_KHO AS X ON A.MS_PT = X.MS_PT INNER JOIN
                      dbo.IC_KHO AS I ON X.MS_KHO = I.MS_KHO ON H.MS_KHO = I.MS_KHO LEFT OUTER JOIN
                      dbo.NHOM_LOAI_PHU_TUNG AS L INNER JOIN
                      dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS K ON L.MS_LOAI_PT = K.MS_LOAI_PT INNER JOIN
                      dbo.USERS AS M ON L.GROUP_ID = M.GROUP_ID ON A.MS_PT = K.MS_PT
WHERE     (M.USERNAME = @UserName) AND (A.THEO_KHO = 1)

ORDER BY A.MS_PT,MS_PT_CTY ,MS_PT_NCC ,TEN_PT,QUY_CACH
