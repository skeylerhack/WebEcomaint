

--  spGetDieuDoPBT


ALTER PROC [dbo].[spGetDieuDoPBT]
	@IdDD bigint = -1,  
	@UName NVARCHAR(50) = 'admin',
	@TNgay DATE = '01/01/2018',
	@DNgay DATE = '03/01/2021',
	@NNgu INT = 0,
	@MsNhomDD bigint = -1,
	@Action INT = 1
AS
--Nha xuong
;with cte(MS_N_XUONG, MS_CHA,[ALL_CHA])
AS 
(
select MS_N_XUONG, MS_CHA , CAST('' AS NVARCHAR(MAX))  AS ALL_CHA from 
dbo.NHA_XUONG
where MS_CHA is null 
UNION ALL
select A.MS_N_XUONG, A.MS_CHA,
cast ((B.ALL_CHA + cast(A.MS_CHA as nvarchar(50)) +', ') as NVARCHAR(MAX)) 
from 
dbo.NHA_XUONG A 
inner join cte B
ON A.MS_CHA=B.MS_N_XUONG
) 
select MS_N_XUONG, CASE substring(ALL_CHA,0,LEN(ALL_CHA)) WHEN '' THEN MS_N_XUONG ELSE substring(ALL_CHA,0,LEN(ALL_CHA)) END  AS MS_NX_CHA  INTO #NX_CHA from cte 
ORDER BY MS_N_XUONG

--He Thong
;with cte(MS_HE_THONG, MS_CHA,[ALL_CHA])
AS 
(
select MS_HE_THONG, MS_CHA , CAST('' AS NVARCHAR(MAX))  AS ALL_CHA from 
dbo.HE_THONG
where MS_CHA is null 
UNION ALL
select A.MS_HE_THONG, A.MS_CHA,cast ((B.ALL_CHA + cast(A.MS_CHA as nvarchar(50)) +', ') as NVARCHAR(MAX))from 
dbo.HE_THONG A 
inner join cte B
ON A.MS_CHA=B.MS_HE_THONG
) 

select MS_HE_THONG, 
CONVERT(NVARCHAR(MAX),CASE substring(ALL_CHA,0,LEN(ALL_CHA)) WHEN '' THEN MS_HE_THONG ELSE substring(ALL_CHA,0,LEN(ALL_CHA)) END)  AS MS_HT_CHA  INTO #HT_CHA from cte 
ORDER BY MS_HE_THONG





--@Action = 0 View; 1 Dieu Do
SELECT DISTINCT T1.MS_MAY,T1.MS_N_XUONG,T1.MS_HE_THONG,MS_LOAI_MAY,MS_NHOM_MAY,TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI,ISNULL(T3.MS_NX_CHA,T1.MS_N_XUONG) AS MS_NX_CHA ,ISNULL(T4.MS_HT_CHA,T1.MS_HE_THONG) AS MS_HT_CHA INTO #MAY_USER FROM dbo.MGetMayUserNgay(@DNgay, @UName, '-1', -1,-1, '-1', '-1', '-1', @NNgu) T1 
 LEFT JOIN #NX_CHA T3 ON T1.MS_N_XUONG = T3.MS_N_XUONG LEFT JOIN #HT_CHA T4 ON T1.MS_HE_THONG = T4.MS_HE_THONG
INNER JOIN DIEU_DO_NHOM_MAY T2 ON T1.MS_MAY = T2.MS_MAY 
WHERE ID_NHOM_DD = @MsNhomDD OR @MsNhomDD  = -1


IF @Action = 0
BEGIN
SELECT CHON, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY, MS_BO_PHAN,TEN_BO_PHAN, MO_TA_CV, SO_GIO_KH, NGAY_BD_KH,MS_DIEU_DO,SO_NGUOI_DD, NGAY_DD,  MS_CV, 
                         MS_N_XUONG, MS_HE_THONG, MS_LOAI_MAY, MS_NHOM_MAY, MS_LOAI_BT, TINH_TRANG_PBT, MS_UU_TIEN, K1, K2, K3, K4, @MsNhomDD AS K5,
						 CONVERT(INT,ROW_NUMBER() OVER (ORDER BY NGAY_BD_KH, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY, TEN_BO_PHAN, MO_TA_CV )) AS TK,
						 TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI,MS_NX_CHA,MS_HT_CHA
FROM 
	(SELECT        CONVERT(BIT, 1) AS CHON, T1.MS_PHIEU_BAO_TRI,
	CASE @NNgu WHEN 0 THEN T6.TEN_TINH_TRANG WHEN 1 THEN  ISNULL(NULLIF(T6.TEN_TINH_TRANG_ANH, ''), T6.TEN_TINH_TRANG)   ELSE ISNULL(NULLIF(T6.TEN_TINH_TRANG_HOA, ''), T6.TEN_TINH_TRANG) END AS TEN_TINH_TRANG, CASE @NNgu WHEN 0 THEN T5.TEN_UU_TIEN ELSE T5.TEN_TA END AS TEN_UU_TIEN,
	T1.MS_MAY, 
	CASE @NNgu WHEN 0 THEN T2.TEN_BO_PHAN WHEN 1 THEN  ISNULL(NULLIF(T2.TEN_BO_PHAN_ANH, ''), T2.TEN_BO_PHAN)   ELSE ISNULL(NULLIF(T2.TEN_BO_PHAN_HOA, ''), T2.TEN_BO_PHAN) END AS TEN_BO_PHAN, 
	CASE @NNgu WHEN 0 THEN T3.MO_TA_CV WHEN 1 THEN  ISNULL(NULLIF(T3.MO_TA_CV_ANH, ''), T3.MO_TA_CV)   ELSE ISNULL(NULLIF(T3.MO_TA_CV_HOA, ''), T3.MO_TA_CV) END AS MO_TA_CV, 
	T1.SO_GIO_KH, ISNULL(T4.NGAY_BD_KH_GOC,T4.NGAY_BD_KH) AS NGAY_BD_KH,T8.MS_DIEU_DO,	T1.SO_NGUOI_DD,T1.NGAY_DD,
	T1.MS_BO_PHAN, T1.MS_CV,MS_N_XUONG,MS_HE_THONG,T7.MS_LOAI_MAY,MS_NHOM_MAY,T4.MS_LOAI_BT,T4.TINH_TRANG_PBT,T4.MS_UU_TIEN,
	@IdDD AS K1,@UName AS K2, @TNgay AS K3, @DNgay AS K4,TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI,MS_NX_CHA,MS_HT_CHA
	FROM            dbo.DIEU_DO_PBT AS T1 INNER JOIN
							 dbo.CAU_TRUC_THIET_BI AS T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_BO_PHAN = T2.MS_BO_PHAN INNER JOIN
							 dbo.CONG_VIEC AS T3 ON T1.MS_CV = T3.MS_CV INNER JOIN
							 dbo.PHIEU_BAO_TRI AS T4 ON T1.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI INNER JOIN
							 dbo.MUC_UU_TIEN AS T5 ON T4.MS_UU_TIEN = T5.MS_UU_TIEN INNER JOIN
							 dbo.TINH_TRANG_PBT AS T6 ON T4.TINH_TRANG_PBT = T6.STT INNER JOIN 
							 #MAY_USER T7 ON T1.MS_MAY = T7.MS_MAY INNER JOIN DIEU_DO T8 ON T1.ID_DD = T8.ID_DD
	WHERE T1.ID_DD = @IdDD) A
ORDER BY NGAY_BD_KH, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY,MS_BO_PHAN, TEN_BO_PHAN, MO_TA_CV



END


IF @Action = 1
BEGIN

	SELECT T1.MS_PHIEU_BAO_TRI,ISNULL(NGAY_BD_KH_GOC,NGAY_BD_KH) AS NGAY_BD_KH, T1.MS_MAY,T1.MS_LOAI_BT, TINH_TRANG_PBT, MS_UU_TIEN
		,MS_N_XUONG,MS_HE_THONG,MS_LOAI_MAY,MS_NHOM_MAY,TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI ,MS_NX_CHA,MS_HT_CHA
	INTO #PBT FROM PHIEU_BAO_TRI T1 INNER JOIN 
	(SELECT DISTINCT MS_LOAI_BT FROM HINH_THUC_BAO_TRI T1 INNER JOIN LOAI_BAO_TRI T2 ON T1.MS_HT_BT = T2.MS_HT_BT WHERE (PHONG_NGUA = 1) ) T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT INNER JOIN #MAY_USER T3 ON T1.MS_MAY = T3.MS_MAY
	WHERE (ISNULL(NGAY_BD_KH_GOC,NGAY_BD_KH) BETWEEN @TNgay AND @DNgay) 
	AND (TINH_TRANG_PBT = 1 OR TINH_TRANG_PBT = 2)

SELECT CHON, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY,MS_BO_PHAN, TEN_BO_PHAN, MO_TA_CV, SO_GIO_KH, NGAY_BD_KH,MS_DIEU_DO, SO_NGUOI_DD, NGAY_DD,  MS_CV, 
                         MS_N_XUONG, MS_HE_THONG, MS_LOAI_MAY, MS_NHOM_MAY, MS_LOAI_BT, TINH_TRANG_PBT, MS_UU_TIEN, K1, K2, K3, K4, @MsNhomDD AS K5,
						 CONVERT(INT,ROW_NUMBER() OVER (ORDER BY NGAY_BD_KH, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY, TEN_BO_PHAN, MO_TA_CV )) AS TK,
						 TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI ,MS_NX_CHA,MS_HT_CHA
FROM 
	(
	SELECT CONVERT(BIT,0) AS CHON, T1.MS_PHIEU_BAO_TRI, 
	CASE @NNgu WHEN 0 THEN T6.TEN_TINH_TRANG WHEN 1 THEN  ISNULL(NULLIF(T6.TEN_TINH_TRANG_ANH, ''), T6.TEN_TINH_TRANG)   ELSE ISNULL(NULLIF(T6.TEN_TINH_TRANG_HOA, ''), T6.TEN_TINH_TRANG) END AS TEN_TINH_TRANG,
	CASE @NNgu WHEN 0 THEN T5.TEN_UU_TIEN ELSE T5.TEN_TA END AS TEN_UU_TIEN,
	T1.MS_MAY, 
	CASE @NNgu WHEN 0 THEN T3.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(T3.TEN_BO_PHAN_ANH, ''), T3.TEN_BO_PHAN) ELSE ISNULL(T3.TEN_BO_PHAN_HOA,T3.TEN_BO_PHAN) END AS TEN_BO_PHAN, 
	CASE @NNgu WHEN 0 THEN T4.MO_TA_CV WHEN 1 THEN  ISNULL(NULLIF(T4.MO_TA_CV_ANH, ''), T4.MO_TA_CV)   ELSE ISNULL(NULLIF(T4.MO_TA_CV_HOA, ''), T4.MO_TA_CV) END AS MO_TA_CV,	
	T2.SO_GIO_KH, T1.NGAY_BD_KH,T7.MS_DIEU_DO,
	CONVERT(INT, DD_SN) AS SO_NGUOI_DD,CONVERT(DATE,DD_NGAY) AS NGAY_DD,T2.MS_BO_PHAN,T2.MS_CV,MS_N_XUONG,MS_HE_THONG,T1.MS_LOAI_MAY,MS_NHOM_MAY,T1.MS_LOAI_BT,T1.TINH_TRANG_PBT,T1.MS_UU_TIEN,
	@IdDD AS K1,@UName AS K2, @TNgay AS K3, @DNgay AS K4,TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,TEN_HE_THONG,TEN_BP_CHIU_PHI,MS_NX_CHA,MS_HT_CHA
	FROM            #PBT AS T1 INNER JOIN
							 dbo.PHIEU_BAO_TRI_CONG_VIEC AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN
							 dbo.CAU_TRUC_THIET_BI AS T3 ON T1.MS_MAY = T3.MS_MAY AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
							 dbo.CONG_VIEC AS T4 ON T2.MS_CV = T4.MS_CV INNER JOIN
							 dbo.MUC_UU_TIEN AS T5 ON T1.MS_UU_TIEN = T5.MS_UU_TIEN INNER JOIN
							 dbo.TINH_TRANG_PBT AS T6 ON T1.TINH_TRANG_PBT = T6.STT LEFT JOIN 
							 DIEU_DO T7 ON T2.ID_DD = T7.ID_DD
							 ) A
ORDER BY NGAY_BD_KH, MS_PHIEU_BAO_TRI, TEN_TINH_TRANG, TEN_UU_TIEN, MS_MAY,MS_BO_PHAN, TEN_BO_PHAN, MO_TA_CV

END

