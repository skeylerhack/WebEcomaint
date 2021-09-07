

-- exec GetrptVTPT_XUATKHO '04/12/2011','04/12/2016',-1,'1,2,3,4,9',0, 'Admin'
ALTER procedure [dbo].[GetrptVTPT_XUATKHO]
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME,
	@KHO int,
	@DANGXUAT NVARCHAR(50),
	@NNgu int,
	@USERNAME nvarchar(255)
AS
BEGIN

CREATE TABLE #DX_TMP (MS_DANG_XUAT INT  NULL)  
DECLARE @sSql NVARCHAR(4000)
SET @sSql = 'INSERT INTO #DX_TMP SELECT MS_DANG_XUAT FROM DANG_XUAT WHERE MS_DANG_XUAT IN ('+@DANGXUAT+')'
EXEC (@sSql)


		SELECT  distinct  IC_KHO.MS_KHO, IC_KHO.TEN_KHO INTO #KHO
		FROM         IC_KHO LEFT JOIN
							  IC_DON_HANG_NHAP ON IC_KHO.MS_KHO = IC_DON_HANG_NHAP.MS_KHO INNER JOIN
							  NHOM_KHO ON IC_KHO.MS_KHO = NHOM_KHO.MS_KHO INNER JOIN
							  NHOM ON NHOM_KHO.GROUP_ID = NHOM.GROUP_ID INNER JOIN
							  USERS ON NHOM.GROUP_ID = USERS.GROUP_ID
		WHERE     (USERS.USERNAME = @USERNAME) AND (IC_KHO.MS_KHO = @KHO OR @KHO = -1)

SELECT T1.* INTO #DX FROM DANG_XUAT T1 INNER JOIN #DX_TMP T2 ON T1.MS_DANG_XUAT = T2.MS_DANG_XUAT

SELECT    IDENTITY(INT, 1,1) AS STT,  dbo.IC_DON_HANG_XUAT.MS_DH_XUAT_PT AS SO_PHIEU_XN, dbo.IC_DON_HANG_XUAT.SO_CHUNG_TU, dbo.IC_DON_HANG_XUAT.NGAY,
                      dbo.IC_DON_HANG_XUAT.LY_DO_XUAT, CASE @NNgu WHEN 0 THEN DANG_XUAT.DANG_XUAT_VIET ELSE DANG_XUAT.DANG_XUAT_ANH END AS DANG_XUAT, dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT, dbo.IC_PHU_TUNG.TEN_PT, 
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_DH_NHAP_PT, dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.SL_VT, 
                      dbo.IC_DON_HANG_XUAT.MS_KHO, dbo.IC_KHO.TEN_KHO, 
					  CASE @NNgu WHEN 0 THEN DON_VI_TINH.TEN_1 ELSE DON_VI_TINH.TEN_2 END AS DVT,
					 (dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA) AS DON_GIA,
					 (dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.SL_VT * dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA) AS THANH_TIEN,
					 dbo.PHIEU_BAO_TRI.MS_MAY
into #tmp
FROM            dbo.IC_DON_HANG_XUAT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU ON dbo.IC_DON_HANG_XUAT.MS_DH_XUAT_PT = 
						 dbo.IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET ON dbo.IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT = 
						 dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_DH_XUAT_PT AND 
                         dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT = dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_PT INNER JOIN
                         dbo.IC_KHO ON dbo.IC_DON_HANG_XUAT.MS_KHO = dbo.IC_KHO.MS_KHO INNER JOIN
                         dbo.IC_PHU_TUNG ON dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT INNER JOIN
                         #DX AS DANG_XUAT ON dbo.IC_DON_HANG_XUAT.MS_DANG_XUAT = DANG_XUAT.MS_DANG_XUAT INNER JOIN
                         dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT AND 
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.MS_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT AND 
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET.ID_XUAT = dbo.IC_DON_HANG_NHAP_VAT_TU.ID LEFT OUTER JOIN
                         dbo.PHIEU_BAO_TRI ON dbo.IC_DON_HANG_XUAT.MS_PHIEU_BAO_TRI = dbo.PHIEU_BAO_TRI.MS_PHIEU_BAO_TRI INNER JOIN
						 #KHO ON #KHO.MS_KHO = dbo.IC_DON_HANG_XUAT.MS_KHO 

WHERE     (CONVERT(DATETIME,CONVERT(NVARCHAR(10),dbo.IC_DON_HANG_XUAT.NGAY,101)) BETWEEN @TU_NGAY  AND @DEN_NGAY)
		--AND  DANG_XUAT.MS_DANG_XUAT IN ('+@DANGXUAT+') AND dbo.IC_DON_HANG_XUAT.LOCK =1 ' 
	--AND (dbo.IC_DON_HANG_XUAT.MS_KHO = @KHO OR @KHO = -1)

ORDER BY  dbo.IC_DON_HANG_XUAT.NGAY 

select * from #tmp
drop table #tmp
DROP TABLE #KHO
END
