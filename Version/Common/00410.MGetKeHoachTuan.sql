
-- EXEC MGetKeHoachTuan '2016/06/06' , '2016/06/12' , '-1',-1,'-1',1, 'trungnv'
ALTER procedure [dbo].[MGetKeHoachTuan]
	@TNgay datetime,
	@DNgay datetime,
	@NXuong NVARCHAR(50),
	@HThong int,
	@LMay NVARCHAR(20), 
	@NNgu int,
	@USERNAME NVARCHAR(50)
AS



SELECT DISTINCT MS_MAY,TEN_MAY, TEN_LOAI_MAY,MS_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,MS_N_XUONG,MS_NHOM_MAY, MS_HE_THONG,TEN_HE_THONG INTO #MAY_USER 
	FROM dbo.MGetMayUserNgay(@DNgay,@USERNAME,@NXuong,@HThong,-1,@LMay,'-1','-1',@NNgu) A
		
SELECT T1.* INTO #PHIEU_BAO_TRI_TT FROM PHIEU_BAO_TRI T1 INNER JOIN #MAY_USER T2 ON T1.MS_MAY = T2.MS_MAY
	WHERE  ((TINH_TRANG_PBT = 1) OR (TINH_TRANG_PBT = 2)) AND (NGAY_BD_KH <= @DNgay) AND (NGAY_KT_KH >= @TNgay)




DECLARE @NGAY DATETIME
SET @NGAY=GETDATE ()
SELECT DISTINCT CONVERT(INT,NULL) AS STT ,B.TEN_MAY, A.MS_PHIEU_BAO_TRI, C.TEN_BO_PHAN, 
CASE @NNgu WHEN 0 THEN E.MO_TA_CV
			WHEN 1 THEN E.MO_TA_CV_ANH
			ELSE E.MO_TA_CV_HOA END AS MO_TA_CV
, F.TEN_CN, A.NGAY_BD_KH, H.TEN_PT
, CONVERT(NVARCHAR(1),NULL) AS NGUOI_THUC_HIEN
, CONVERT(NVARCHAR(1),NULL) AS THOI_GIAN_THUC_HIEN
, CONVERT(NVARCHAR(1),NULL) AS PHU_TUNG_THAY_THE
, CONVERT(NVARCHAR(1),NULL) AS NGUOI_KIEM_TRA
, CONVERT(NVARCHAR(1),NULL) AS KET_QUA_THUC_HIEN

FROM         dbo.PHIEU_BAO_TRI AS A INNER JOIN
                      #MAY_USER AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.CAU_TRUC_THIET_BI AS C ON B.MS_MAY = C.MS_MAY INNER JOIN
                      dbo.PHIEU_BAO_TRI_CONG_VIEC AS D ON A.MS_PHIEU_BAO_TRI = D.MS_PHIEU_BAO_TRI AND C.MS_BO_PHAN = D.MS_BO_PHAN INNER JOIN
                      dbo.CONG_VIEC AS E ON E.MS_CV = D.MS_CV LEFT JOIN
                          (SELECT DISTINCT 
                                                   MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN, CONVERT(NVARCHAR(4000), dbo.MGetListCongNhanPBT(MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN)) 
                                                   AS TEN_CN
                            FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU) AS F ON D.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI AND D.MS_CV = F.MS_CV AND 
                      D.MS_BO_PHAN = F.MS_BO_PHAN LEFT JOIN
                          (SELECT DISTINCT 
                                                   MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN, CONVERT(NVARCHAR(4000), dbo.MGetListPhuTungPBT(MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN,@NNgu)) 
                                                   AS TEN_PT
                            FROM          dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG) AS H ON D.MS_PHIEU_BAO_TRI = H.MS_PHIEU_BAO_TRI AND D.MS_CV = H.MS_CV AND 
                      D.MS_BO_PHAN = H.MS_BO_PHAN                       
                      
WHERE     ((A.TINH_TRANG_PBT = 1) OR (A.TINH_TRANG_PBT = 2)) 
AND (NGAY_BD_KH <= @DNgay) AND (NGAY_KT_KH >= @TNgay)

ORDER BY B.TEN_MAY, A.MS_PHIEU_BAO_TRI, C.TEN_BO_PHAN


--NGAY_BDKH <=DEN_NGAY (23H59). VÀ NGAY_KTKH>=TU_NGAY (00:00)		
--DEN NGAY là ngày cuối tuần		
--Từ ngày là ngày đầu tuần		
--Tuần tính từ chủ nhật đến hết thứ 7 (theo mặc định của SQL)		
--Where nha xuon và dây chuyền lọc theo NGAY_BDKH		
