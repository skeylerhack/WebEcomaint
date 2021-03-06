
 --exec SP_Y_GET_BTDK_NHAC_VIEC 'administrator' , '01/01/2021','04/28/2021','-1','-1',-1,'lkb-003'

ALTER procedure [dbo].[SP_Y_GET_BTDK_NHAC_VIEC] 
	@USERNAME NVARCHAR (64),
	@NgayBD DATETIME ,
	@NgayKT DATETIME,
	@MS_LOAI_MAY NVARCHAR (20),
	@MS_NHA_XUONG NVARCHAR (50),
	@MS_HE_THONG INT ,
	@MS_MAY NVARCHAR (30) 
AS
BEGIN

	
SELECT     TOP (100) PERCENT A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG, A.NGAY_KE INTO #TB_BTDK_TMP_1
FROM         dbo.MGetNgayHieuChuanKeBaoTri(@NgayBD, @NgayKT, @USERNAME, @MS_NHA_XUONG, @MS_HE_THONG, @MS_LOAI_MAY, '-1', 1) AS A INNER JOIN
                      dbo.MAY_NHA_XUONG_NGAY_MAX AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.NHA_XUONG AS C ON B.MS_N_XUONG = C.MS_N_XUONG
WHERE     (A.MS_MAY = @MS_MAY OR @MS_MAY = '-1') 
ORDER BY A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG, A.NGAY_KE





--Xoa du lieu ngoai giai doan xem
DELETE FROM #TB_BTDK_TMP_1 WHERE NGAY_KE NOT IN (SELECT NGAY_KE FROM #TB_BTDK_TMP_1 WHERE NGAY_KE  BETWEEN @NgayBD AND @NgayKT)

--Xoa du lieu ton tai trong may loai BTPN
DELETE A FROM #TB_BTDK_TMP_1 A INNER JOIN MAY_LOAI_BTPN B ON A.MS_MAY=B.MS_MAY AND A.MS_LOAI_BT =B.MS_LOAI_BT 
	WHERE A.NGAY_KE <= B.NGAY_CUOI OR ( A.NGAY_KE<@NgayBD AND A.NGAY_KE>@NgayKT)

--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con
DELETE TB_BTDK_TMP_1_1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #TB_BTDK_TMP_1 AS TB_BTDK_TMP_1_1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = TB_BTDK_TMP_1_1.MS_LOAI_BT INNER JOIN
                      #TB_BTDK_TMP_1 AS TB_BTDK_TMP_1 ON TB_BTDK_TMP_1_1.MS_MAY = TB_BTDK_TMP_1.MS_MAY AND 
                      dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = TB_BTDK_TMP_1.MS_LOAI_BT AND DATEADD(DAY, 
                      CASE TB_BTDK_TMP_1_1.MS_DV_TG WHEN 2 THEN TB_BTDK_TMP_1_1.CHU_KY * 7 WHEN 3 THEN TB_BTDK_TMP_1_1.CHU_KY * 30 WHEN 4 THEN
                       TB_BTDK_TMP_1_1.CHU_KY * 365 ELSE TB_BTDK_TMP_1_1.CHU_KY END / 4, TB_BTDK_TMP_1_1.NGAY_KE) 
                      >= TB_BTDK_TMP_1.NGAY_KE AND DATEADD(DAY, 
                      - (CASE TB_BTDK_TMP_1_1.MS_DV_TG WHEN 2 THEN TB_BTDK_TMP_1_1.CHU_KY * 7 WHEN 3 THEN TB_BTDK_TMP_1_1.CHU_KY * 30 WHEN 4 THEN
                       TB_BTDK_TMP_1_1.CHU_KY * 365 ELSE TB_BTDK_TMP_1_1.CHU_KY END / 4), TB_BTDK_TMP_1_1.NGAY_KE) <= TB_BTDK_TMP_1.NGAY_KE 


--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong PBT
DELETE T1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #TB_BTDK_TMP_1 AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT INNER JOIN
                      PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT 
WHERE DATEADD(DAY, CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4, T1.NGAY_KE) >= T2.NGAY_BD_KH 
AND DATEADD(DAY, - (CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4), T1.NGAY_KE) <= T2.NGAY_BD_KH

--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong KHTT 
DELETE T1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #TB_BTDK_TMP_1 AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT INNER JOIN
                      KE_HOACH_TONG_THE AS T2 ON T1.MS_MAY = T2.MS_MAY AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT 
WHERE DATEADD(DAY, CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4, T1.NGAY_KE) >= T2.NGAY
AND DATEADD(DAY, - (CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4), T1.NGAY_KE) <= T2.NGAY





--Xóa bảo trì định kỳ đã lập bên kế hoạch tổng thể và phiếu bảo trì

DELETE T
FROM #TB_BTDK_TMP_1 T INNER JOIN
dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY AND 
T.MS_LOAI_BT = T1.MS_LOAI_BT AND DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN 
T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_KE) >= T1.NGAY AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN 
T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_KE) <= T1.NGAY 


DELETE T
FROM #TB_BTDK_TMP_1 T INNER JOIN
dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY AND 
T.MS_LOAI_BT = T1.MS_LOAI_BT AND DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN 
T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_KE) >= T1.NGAY_BD_KH AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN 
T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_KE) <= T1.NGAY_BD_KH 


SELECT     TOP (100) PERCENT T1.MS_MAY, T2.TEN_MAY, T4.TEN_LOAI_BT, T1.NGAY_HC_CUOI, 
	CONVERT(NVARCHAR(10), T1.CHU_KY) + ' ' + T6.TEN_DV_TG AS CHU_KY, T1.NGAY_KE, T3.Ten_N_XUONG, T7.TEN_HE_THONG, 
	T5.TEN_NHOM_MAY
FROM         dbo.#TB_BTDK_TMP_1 AS T1 INNER JOIN
                      dbo.MAY AS T2 ON T1.MS_MAY = T2.MS_MAY INNER JOIN
                      dbo.MAY_NHA_XUONG_NGAY_MAX AS T3 ON T1.MS_MAY = T3.MS_MAY INNER JOIN
                      dbo.LOAI_BAO_TRI AS T4 ON T1.MS_LOAI_BT = T4.MS_LOAI_BT INNER JOIN
                      dbo.NHOM_MAY AS T5 ON T2.MS_NHOM_MAY = T5.MS_NHOM_MAY INNER JOIN
                      dbo.DON_VI_THOI_GIAN AS T6 ON T1.MS_DV_TG = T6.MS_DV_TG INNER JOIN
                      dbo.MAY_HE_THONG_NGAY_MAX AS T7 ON T2.MS_MAY = T7.MS_MAY
ORDER BY T1.MS_MAY, T2.TEN_MAY, T5.TEN_NHOM_MAY, T3.Ten_N_XUONG, T4.TEN_LOAI_BT, T1.NGAY_HC_CUOI     
END       
