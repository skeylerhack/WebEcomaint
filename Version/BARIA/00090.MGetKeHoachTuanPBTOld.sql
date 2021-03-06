

-- exec MGetKeHoachTuanPBT '07/01/2000','08/01/2013','-1',-1,'-1',0,'administrator',0,0,0,1,1
ALTER PROC		[dbo].[MGetKeHoachTuanPBT]
	@TNgay datetime,
	@DNgay datetime,
	@NXuong NVARCHAR(50),
	@HThong int,
	@LMay NVARCHAR(20),
	@NNgu int,
	@USERNAME NVARCHAR(50),
	@DangSoan bit,
	@DangTHien bit,
	@HoanThanh bit,
	@NghiemThu bit,
	@Khoa bit
as
--SET	@TNgay = '10/01/2009'
--SET	@DNgay = '11/01/2010'
--SET	@NXuong = '-1'
--SET	@HThong = -1
--SET	@LMay = '-1'
SET	@NNgu = 0
--SET	@USERNAME = 'ADMINISTRATOR'


declare @tbTinhTrangBT TABLE (STT INT)
IF	@DangSoan  = 1 
	INSERT INTO @tbTinhTrangBT VALUES (1)
IF	@DangTHien = 1
	INSERT INTO @tbTinhTrangBT VALUES (2)
IF	@HoanThanh = 1
	INSERT INTO @tbTinhTrangBT VALUES (3)
IF	@NghiemThu = 1
	INSERT INTO @tbTinhTrangBT VALUES (4)
IF	@Khoa = 1
	INSERT INTO @tbTinhTrangBT VALUES (5)
	
SELECT * INTO #PHIEU_BAO_TRI_TT FROM PHIEU_BAO_TRI WHERE TINH_TRANG_PBT IN ( SELECT DISTINCT STT FROM @tbTinhTrangBT) 

		
SELECT  DISTINCT
                      CONVERT(INT, NULL) AS STT, A.MS_MAY, B.TEN_MAY, A.MS_PHIEU_BAO_TRI, X.TEN_LOAI_BT, C.TEN_BO_PHAN, 
                      CASE @NNgu WHEN 0 THEN E.MO_TA_CV WHEN 1 THEN E.MO_TA_CV_ANH ELSE E.MO_TA_CV_HOA END AS CONG_VIEC, F.TEN_CN, 
                      CONVERT(nvarchar, dbo.MGetNgayPBTCVCT(A.MS_PHIEU_BAO_TRI, D.MS_CV, D.MS_BO_PHAN),103) AS NGAY_HT, E.THOI_GIAN_DU_KIEN, 
                      A.TINH_TRANG_PBT 
FROM         #PHIEU_BAO_TRI_TT AS A INNER JOIN
                      dbo.MAY AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.CAU_TRUC_THIET_BI AS C ON B.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.PHIEU_BAO_TRI_CONG_VIEC AS D ON A.MS_PHIEU_BAO_TRI = D.MS_PHIEU_BAO_TRI AND C.MS_BO_PHAN = D.MS_BO_PHAN INNER JOIN
                      dbo.CONG_VIEC AS E ON E.MS_CV = D.MS_CV LEFT JOIN
                          (SELECT DISTINCT MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN, CONVERT(NVARCHAR(4000), dbo.MGetListCongNhanPBT(MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN)) AS TEN_CN
                            FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU) AS F ON D.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI AND D.MS_CV = F.MS_CV AND D.MS_BO_PHAN = F.MS_BO_PHAN INNER JOIN
                          (SELECT     MS_MAY, MS_N_XUONG, NGAY, MS_CHA
                            FROM          dbo.MashjGetMayNXCha(@NXuong, GETDATE()) AS MashjGetMayNXCha_1) AS K ON K.MS_MAY = A.MS_MAY INNER JOIN
                          (SELECT     dbo.MGetHTTheoNgay(MS_MAY, GETDATE()) AS MSHT, MS_MAY, MS_NHOM_MAY, MS_HSX, MS_HIEN_TRANG, MS_KH, SO_NAM_KHAU_HAO, MO_TA, NHIEM_VU_THIET_BI, MODEL, 
                                                   SERIAL_NUMBER, NGAY_SX, NUOC_SX, NGAY_MUA, NGAY_BD_BAO_HANH, NGAY_DUA_VAO_SD, SO_THE, SO_NGAY_LV_TRONG_TUAN, SO_GIO_LV_TRONG_NGAY, MS_DVT_RT, 
                                                   TY_LE_CON_LAI, MUC_UU_TIEN, SO_THANG_BH, GIA_MUA, NGOAI_TE, LUU_Y_SU_DUNG, Anh_TB, CHU_KY_HC_TB, TEN_MAY, AN_TOAN, MS_HO_SO, TEN_HO_SO, 
                                                   NGAY_HIEU_LUC_HO_SO, SO_CT, TI_GIA_VND, TI_GIA_USD, CHU_KY_HIEU_CHUAN_TB_NGOAI, CHU_KY_KD_TB, DON_VI_THOI_GIAN
                            FROM          dbo.MAY) AS L ON L.MS_MAY = A.MS_MAY INNER JOIN
                      dbo.NHOM_MAY AS M ON B.MS_NHOM_MAY = M.MS_NHOM_MAY INNER JOIN
                          (SELECT DISTINCT MS_N_XUONG
                            FROM          dbo.MashjGetNXUser(@USERNAME, @NXuong) AS MashjGetNXUser_1) AS N ON K.MS_N_XUONG = N.MS_N_XUONG INNER JOIN
                      dbo.LOAI_BAO_TRI AS X ON A.MS_LOAI_BT = X.MS_LOAI_BT INNER JOIN
(SELECT A.MS_PHIEU_BAO_TRI, dbo.MGetNgayPBTCVCT(A.MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN) AS NGAY_HT
FROM #PHIEU_BAO_TRI_TT A INNER JOIN PHIEU_BAO_TRI_CONG_VIEC B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI) AS Y ON A.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI 
WHERE NGAY_HT BETWEEN @TNgay AND @DNgay 
AND (@LMay = '-1' OR M.MS_LOAI_MAY = @LMay)
AND (@HThong = '-1' OR MSHT = @HThong)  


UNION


SELECT  DISTINCT
                      CONVERT(INT, NULL) AS STT, A.MS_MAY, B.TEN_MAY, A.MS_PHIEU_BAO_TRI, X.TEN_LOAI_BT, '' AS TEN_BO_PHAN, 
                      D.TEN_CONG_VIEC AS CONG_VIEC, F.TEN_CN, 
                      CONVERT(nvarchar, dbo.MGetNgayPBTCVCT(A.MS_PHIEU_BAO_TRI, -1, '-1'),103) AS NGAY_HT, SO_GIO_KH AS THOI_GIAN_DU_KIEN,
                      A.TINH_TRANG_PBT 
FROM         #PHIEU_BAO_TRI_TT AS A INNER JOIN
                      dbo.MAY AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.PHIEU_BAO_TRI_CV_PHU_TRO AS D ON A.MS_PHIEU_BAO_TRI = D.MS_PHIEU_BAO_TRI LEFT JOIN
(SELECT DISTINCT MS_PHIEU_BAO_TRI, CONVERT(NVARCHAR(4000), dbo.MGetListCongNhanPBT(MS_PHIEU_BAO_TRI, -1, '-1')) AS TEN_CN
	FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO) AS F ON D.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI INNER JOIN
                          (SELECT     MS_MAY, MS_N_XUONG, NGAY, MS_CHA
                            FROM          dbo.MashjGetMayNXCha(@NXuong, GETDATE()) AS MashjGetMayNXCha_1) AS K ON K.MS_MAY = A.MS_MAY INNER JOIN
                          (SELECT     dbo.MGetHTTheoNgay(MS_MAY, GETDATE()) AS MSHT, MS_MAY, MS_NHOM_MAY, MS_HSX, MS_HIEN_TRANG, MS_KH, SO_NAM_KHAU_HAO, MO_TA, NHIEM_VU_THIET_BI, MODEL, 
                                                   SERIAL_NUMBER, NGAY_SX, NUOC_SX, NGAY_MUA, NGAY_BD_BAO_HANH, NGAY_DUA_VAO_SD, SO_THE, SO_NGAY_LV_TRONG_TUAN, SO_GIO_LV_TRONG_NGAY, MS_DVT_RT, 
                                                   TY_LE_CON_LAI, MUC_UU_TIEN, SO_THANG_BH, GIA_MUA, NGOAI_TE, LUU_Y_SU_DUNG, Anh_TB, CHU_KY_HC_TB, TEN_MAY, AN_TOAN, MS_HO_SO, TEN_HO_SO, 
                                                   NGAY_HIEU_LUC_HO_SO, SO_CT, TI_GIA_VND, TI_GIA_USD, CHU_KY_HIEU_CHUAN_TB_NGOAI, CHU_KY_KD_TB, DON_VI_THOI_GIAN
                            FROM          dbo.MAY) AS L ON L.MS_MAY = A.MS_MAY INNER JOIN
                      dbo.NHOM_MAY AS M ON B.MS_NHOM_MAY = M.MS_NHOM_MAY INNER JOIN
                          (SELECT DISTINCT MS_N_XUONG
                            FROM          dbo.MashjGetNXUser(@USERNAME, @NXuong) AS MashjGetNXUser_1) AS N ON K.MS_N_XUONG = N.MS_N_XUONG INNER JOIN
                      dbo.LOAI_BAO_TRI AS X ON A.MS_LOAI_BT = X.MS_LOAI_BT INNER JOIN
(SELECT A.MS_PHIEU_BAO_TRI, dbo.MGetNgayPBTCVCT(A.MS_PHIEU_BAO_TRI, -1, '-1') AS NGAY_HT
FROM #PHIEU_BAO_TRI_TT A INNER JOIN PHIEU_BAO_TRI_CV_PHU_TRO B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI) AS Y ON A.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI 
WHERE NGAY_HT BETWEEN @TNgay AND @DNgay 
AND (@LMay = '-1' OR M.MS_LOAI_MAY = @LMay)
AND (@HThong = '-1' OR MSHT = @HThong) 
ORDER BY NGAY_HT, A.MS_MAY, B.TEN_MAY, A.MS_PHIEU_BAO_TRI




