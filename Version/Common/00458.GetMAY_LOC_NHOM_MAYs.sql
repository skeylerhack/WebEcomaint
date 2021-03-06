
--EXEC GetMAY_LOC_NHOM_MAYs '-1','-1','ADMIN',0

ALTER PROCEDURE [dbo].[GetMAY_LOC_NHOM_MAYs] 
    @MS_NHOM_MAY NVARCHAR(20),
    @MS_LOAI_MAY NVARCHAR(20),
    @USERNAME NVARCHAR(50),
	@ORDER INT			--0: MS_MAY		1: TEN_MAY
AS

DECLARE @NgayHT DATETIME
SET @NgayHT = GETDATE()

SELECT A.*
INTO #MAY FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,'-1',-1,-1,@MS_LOAI_MAY,@MS_NHOM_MAY,'-1',0) A 

SELECT MS_HE_THONG AS MS_HT, MS_MAY, TEN_MAY, A.MS_HIEN_TRANG, TEN_HIEN_TRANG,TEN_HSX,TEN_CONG_TY, TEN_NHOM_MAY,
	TEN_LOAI_MAY, SO_NAM_KHAU_HAO,MO_TA, NHIEM_VU_THIET_BI, MODEL, SERIAL_NUMBER, NGAY_SX, NUOC_SX, NGAY_MUA, NGAY_BD_BAO_HANH, 
	NGAY_DUA_VAO_SD, SO_THE, SO_NGAY_LV_TRONG_TUAN, SO_GIO_LV_TRONG_NGAY, T6.TEN_DVT_RT, TY_LE_CON_LAI, MUC_UU_TIEN, SO_THANG_BH, GIA_MUA, 
	A.NGOAI_TE, T4.TEN_NGOAI_TE, Anh_TB, T5.TEN_UU_TIEN, CHU_KY_HC_TB, LUU_Y_SU_DUNG, SO_CT, TI_GIA_VND, TI_GIA_USD, DON_VI_THOI_GIAN, 
	CHU_KY_HIEU_CHUAN_TB_NGOAI, CHU_KY_KD_TB, USER_INSERT, USER_UPDATE, NGAY_INSERT, NGAY_UPDATE, DINH_MUC_SL, DVT_SL
FROM #MAY A LEFT OUTER JOIN
	dbo.HIEN_TRANG_SU_DUNG_MAY AS B ON A.MS_HIEN_TRANG = B.MS_HIEN_TRANG  LEFT OUTER JOIN
	dbo.HANG_SAN_XUAT AS C ON A.MS_HSX = C.MS_HSX  LEFT OUTER JOIN
	dbo.KHACH_HANG AS D ON A.MS_KH = D.MS_KH LEFT OUTER JOIN
	dbo.NGOAI_TE AS T4 ON A.NGOAI_TE = T4.NGOAI_TE INNER JOIN
	dbo.MUC_UU_TIEN AS T5 ON A.MUC_UU_TIEN = T5.MS_UU_TIEN LEFT OUTER JOIN
	dbo.DON_VI_TINH_RUN_TIME AS T6 ON A.MS_DVT_RT = T6.MS_DVT_RT 
ORDER BY A.MS_MAY, A.TEN_MAY  	


--SELECT DISTINCT MS_HT=dbo.[Get_MSHT_MAY](D.MS_MAY),
--		D.MS_MAY, D.TEN_MAY, E.MS_HIEN_TRANG, E.TEN_HIEN_TRANG, F.TEN_HSX, G.TEN_CONG_TY, B.TEN_NHOM_MAY, T3.TEN_LOAI_MAY, D.SO_NAM_KHAU_HAO, D.MO_TA, 
--		D.NHIEM_VU_THIET_BI, D.MODEL, D.SERIAL_NUMBER, D.NGAY_SX, D.NUOC_SX, D.NGAY_MUA, D.NGAY_BD_BAO_HANH, D.NGAY_DUA_VAO_SD, D.SO_THE, D.SO_NGAY_LV_TRONG_TUAN, 
--		D.SO_GIO_LV_TRONG_NGAY, H.TEN_DVT_RT, D.TY_LE_CON_LAI, D.MUC_UU_TIEN, D.SO_THANG_BH, D.GIA_MUA, C.NGOAI_TE, C.TEN_NGOAI_TE, T3.STT_MAY AS NGAY_NHAP_MAX, D.Anh_TB, 
--		K.TEN_UU_TIEN, D.CHU_KY_HC_TB, D.LUU_Y_SU_DUNG, D.SO_CT, D.TI_GIA_VND, D.TI_GIA_USD, D.DON_VI_THOI_GIAN, D.CHU_KY_HIEU_CHUAN_TB_NGOAI, D.CHU_KY_KD_TB, 
--		D.USER_INSERT, D.USER_UPDATE,D.NGAY_INSERT, D.NGAY_UPDATE
--FROM [dbo].[MashjGetMayUser]('ADMIN') D INNER JOIN 
--	NHOM_MAY AS B ON D.MS_NHOM_MAY = B.MS_NHOM_MAY INNER JOIN
--	dbo.LOAI_MAY AS T3 ON D.MS_LOAI_MAY = T3.MS_LOAI_MAY LEFT JOIN
--	dbo.NGOAI_TE AS C ON C.NGOAI_TE = D.NGOAI_TE LEFT OUTER JOIN
--	dbo.HIEN_TRANG_SU_DUNG_MAY AS E ON D.MS_HIEN_TRANG = E.MS_HIEN_TRANG LEFT OUTER JOIN
--	dbo.HANG_SAN_XUAT AS F ON D.MS_HSX = F.MS_HSX LEFT OUTER JOIN
--	dbo.KHACH_HANG AS G ON D.MS_KH = G.MS_KH  LEFT OUTER JOIN
--	dbo.DON_VI_TINH_RUN_TIME AS H ON D.MS_DVT_RT = H.MS_DVT_RT LEFT JOIN
--	dbo.MUC_UU_TIEN AS K ON D.MUC_UU_TIEN = K.MS_UU_TIEN 
--WHERE  (D.MS_NHOM_MAY=@MS_NHOM_MAY OR @MS_NHOM_MAY  = '-1') 
--			AND (D.MS_LOAI_MAY = @MS_LOAI_MAY OR @MS_LOAI_MAY = '-1')	
--ORDER BY D.MS_MAY,D.TEN_MAY	