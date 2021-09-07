
--SELECT * FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO WHERE MS_PHIEU_BAO_TRI = 'WO-201602000021'
-- EXEC SP_GET_PTSD_PBT_CHI_TIET 'WO-201702000773'

ALTER procedure [dbo].[SP_GET_PTSD_PBT_CHI_TIET]
@MS_PHIEU_BAO_TRI  NVARCHAR (20) 
 AS



	SELECT        T1.MS_PT, dbo.IC_PHU_TUNG_THAY_THE.MS_PT1 INTO #PTTTHE
	FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET AS T1 INNER JOIN
								dbo.IC_PHU_TUNG_THAY_THE ON T1.MS_PT = dbo.IC_PHU_TUNG_THAY_THE.MS_PT
	WHERE        (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
UNION
	SELECT        MS_PT, MS_PT AS MS_PT1
	FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET 
	WHERE        (MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
UNION
	SELECT        T3.MS_PT, dbo.IC_PHU_TUNG_THAY_THE.MS_PT1 
	FROM            dbo.PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG AS T3 INNER JOIN
								dbo.IC_PHU_TUNG_THAY_THE ON T3.MS_PT = dbo.IC_PHU_TUNG_THAY_THE.MS_PT
	WHERE        (T3.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)
UNION
	SELECT        MS_PT, MS_PT AS MS_PT1
	FROM            dbo.PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG 
	WHERE        (MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)

SELECT DISTINCT 
                         T4.MS_DH_XUAT_PT, T5.MS_DH_NHAP_PT, T2.MS_PT, T5.MS_PT AS MS_PT1, T5.XUAT_XU, T4.SL_VT AS SO_LUONG_THUC_XUAT, 
						 CONVERT(FLOAT, T7.SL_TT) AS SL_TT, T5.DON_GIA, T5.NGOAI_TE, T5.TY_GIA, 
                         T5.TY_GIA_USD, T5.BAO_HANH_DEN_NGAY, T2.MS_PHIEU_BAO_TRI, T2.MS_CV, T2.MS_BO_PHAN, T2.STT, T7.GHI_CHU, 
						 CASE ISNULL(T7.ID, '')  WHEN '' THEN T4.ID_XUAT ELSE T7.ID END AS ID INTO #TMP
FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET AS T2 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU AS T3 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T4 ON T3.MS_DH_XUAT_PT = T4.MS_DH_XUAT_PT AND T3.MS_PT = T4.MS_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T5 ON T4.MS_DH_NHAP_PT = T5.MS_DH_NHAP_PT AND T4.MS_PT = T5.MS_PT AND T4.ID_XUAT = T5.ID INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T6 ON T3.MS_DH_XUAT_PT = T6.MS_DH_XUAT_PT ON T2.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI INNER JOIN
                         dbo.[#PTTTHE] AS T1 ON T2.MS_PT = T1.MS_PT AND T5.MS_PT = T1.MS_PT1 LEFT OUTER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T7 ON T5.ID = T7.ID AND T3.MS_DH_XUAT_PT = T7.MS_DH_XUAT_PT AND T5.MS_DH_NHAP_PT = T7.MS_DH_NHAP_PT AND 
                         T1.MS_PT = T7.MS_PT AND T1.MS_PT1 = T7.MS_PTTT AND T4.MS_DH_NHAP_PT = T7.MS_DH_NHAP_PT AND T2.MS_PHIEU_BAO_TRI = T7.MS_PHIEU_BAO_TRI AND T2.MS_CV = T7.MS_CV AND 
                         T2.MS_BO_PHAN = T7.MS_BO_PHAN AND T2.MS_PT = T7.MS_PT AND T2.STT = T7.STT
WHERE        (T2.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)

INSERT INTO #TMP
SELECT        T7.MS_DH_XUAT_PT, T5.MS_DH_NHAP_PT, T2.MS_PT, T8.MS_PT1, T4.XUAT_XU, T7.SO_LUONG_THUC_XUAT, CONVERT(FLOAT,T6.SL_TT) AS SL_TT, T4.DON_GIA, 
                         T4.NGOAI_TE, T4.TY_GIA, T4.TY_GIA_USD, T4.BAO_HANH_DEN_NGAY, T1.MS_PHIEU_BAO_TRI, T1.STT AS MS_CV, CONVERT(NVARCHAR(250), T1.STT) AS MS_BO_PHAN, T1.STT, T6.GHI_CHU, 
		CASE ISNULL(T6.ID, '') WHEN '' THEN T5.ID_XUAT ELSE T6.ID END AS ID

FROM            dbo.PHIEU_BAO_TRI_CV_PHU_TRO AS T1 INNER JOIN
                         dbo.PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG AS T2 ON T1.STT = T2.STT AND T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T4 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T5 ON T4.MS_DH_NHAP_PT = T5.MS_DH_NHAP_PT AND T4.MS_PT = T5.MS_PT AND T4.ID = T5.ID_XUAT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU T7 ON T5.MS_DH_XUAT_PT = T7.MS_DH_XUAT_PT AND T5.MS_PT = T7.MS_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T3 ON T7.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI AND 
                         T2.MS_PT = T7.MS_PT LEFT OUTER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T6 ON T5.ID_XUAT = T6.ID AND T5.MS_DH_NHAP_PT = T6.MS_DH_NHAP_PT AND 
                         T5.MS_DH_XUAT_PT = T6.MS_DH_XUAT_PT AND T2.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI AND T2.STT = T6.MS_CV AND T2.STT = T6.MS_BO_PHAN AND T2.MS_PT = T6.MS_PT AND 
                         T2.STT = T6.STT INNER JOIN #PTTTHE T8 ON T2.MS_PT = T8.MS_PT
WHERE        (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI)

SELECT [MS_DH_XUAT_PT],[MS_DH_NHAP_PT],[MS_PT],[MS_PT1],[XUAT_XU],[SO_LUONG_THUC_XUAT],[SL_TT],[DON_GIA],[NGOAI_TE],[TY_GIA],[TY_GIA_USD],
[BAO_HANH_DEN_NGAY],[MS_PHIEU_BAO_TRI],[MS_CV],[MS_BO_PHAN],[STT],[GHI_CHU],[ID]
FROM #TMP

select * from PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO where MS_PHIEU_BAO_TRI =  'WO-201702000773'