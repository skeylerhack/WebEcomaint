
-- EXEC GetBCVatTuDeXuatChuaNhapKho '06/01/2012' , '06/30/2016' , N'ALL', 'trungnv'

ALTER procedure [dbo].[GetBCVatTuDeXuatChuaNhapKho]
	@TNgay as datetime,
	@DNgay as datetime, 
	@PBan as NVARCHAR(256),
	@Username as NVARCHAR(256)
As	



		SELECT DISTINCT T1.GROUP_ID, T2.MS_DON_VI,T1.MS_TO as MS_PB,T2.TEN_TO AS TEN_PB INTO #PB_USER
		FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
								 dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
								 dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
		WHERE        (T3.USERNAME = @Username) AND (T2.TEN_TO = @PBan OR @PBan = 'ALL')


		SELECT DISTINCT MS_KHO INTO #SKHO_VTDX FROM KHO_VTDX WHERE CHON = 1

		UPDATE #SKHO_VTDX SET MS_KHO = NULL WHERE MS_KHO = -1
		--DROP TABLE SKHO_VTDX

		SELECT CONVERT(INT,NULL) AS STT,MS_PT, TEN_PT, MS_PT_CTY, MS_PT_NCC, QUY_CACH, MS_DE_XUAT, SO_DE_XUAT, NGAY_DE_XUAT, NGAY_GIAO, 
		PHONG_BAN, 
		NGUOI_DE_XUAT, SL_DA_DUYET, SL_NHAP , ISNULL(SL_DA_DUYET,0) -  ISNULL(SL_NHAP,0) AS SL_CL 
		FROM 
		(
		SELECT     C.MS_PT, C.TEN_PT, C.MS_PT_CTY, C.MS_PT_NCC, C.QUY_CACH, B.MS_DE_XUAT, A.SO_DE_XUAT, A.NGAY_DE_XUAT, A.NGAY_GIAO, A.PHONG_BAN, A.NGUOI_DE_XUAT, B.SL_DA_DUYET, 
							  dbo.GetSLNhapTheoDeXuat(A.MS_DE_XUAT, B.MS_PT) AS SL_NHAP
		FROM         dbo.DE_XUAT_MUA_HANG AS A INNER JOIN
							  dbo.DE_XUAT_MUA_HANG_CHI_TIET AS B ON A.MS_DE_XUAT = B.MS_DE_XUAT INNER JOIN
							  dbo.IC_PHU_TUNG AS C ON B.MS_PT = C.MS_PT INNER JOIN  
								#SKHO_VTDX T1 ON ISNULL(A.MS_KHO,'') = ISNULL(T1.MS_KHO,'') 
					INNER JOIN #PB_USER T2 ON  T2.TEN_PB  =  A.PHONG_BAN
		WHERE     (A.TRANG_THAI = 3) AND 
			(A.NGAY_LAP BETWEEN @TNgay AND @DNgay)
		) A
		WHERE (ISNULL(SL_DA_DUYET, 0) - ISNULL(SL_NHAP, 0) > 0)
		ORDER BY MS_PT, TEN_PT, MS_PT_CTY


		drop table #PB_USER