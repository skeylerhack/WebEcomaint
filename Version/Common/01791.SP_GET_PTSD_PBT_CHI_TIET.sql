ALTER procedure [dbo].[SP_GET_PTSD_PBT_CHI_TIET]
@MS_PHIEU_BAO_TRI  NVARCHAR (20) ='WO-202011000001'
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

SELECT        T3.MS_PHIEU_BAO_TRI,  T3.MS_DH_XUAT_PT, T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC, T4.MS_PT AS MS_PT_GOC, SUM(T4.SL_VT) AS SL_TRA  INTO #TMP_TRA
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T3 ON T1.MS_DHX = T3.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T4 ON T2.MS_DH_NHAP_PT = T4.MS_DH_NHAP_PT AND T2.MS_PT = T4.MS_PT AND T2.ID = T4.ID 
WHERE        (T1.MS_DANG_NHAP = 6) AND (T3.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI) AND T1.MS_DANG_NHAP = 6
GROUP BY T3.MS_PHIEU_BAO_TRI, T3.MS_DH_XUAT_PT,T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC,T4.MS_PT 

SELECT        T3.MS_PHIEU_BAO_TRI,  T3.MS_DH_XUAT_PT, T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC, T4.MS_PT AS MS_PT_GOC,SUM(T2.DON_GIA) AS DG_TAICHE, SUM(T4.SL_VT) AS SL_TAICHE  INTO #TMP_TAICHE
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T3 ON T1.MS_DHX = T3.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T4 ON T2.MS_DH_NHAP_PT = T4.MS_DH_NHAP_PT AND T2.MS_PT = T4.MS_PT AND T2.ID = T4.ID 
WHERE        (T1.MS_DANG_NHAP = 10) AND (T3.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI) AND T1.MS_DANG_NHAP = 10
GROUP BY T3.MS_PHIEU_BAO_TRI, T3.MS_DH_XUAT_PT,T2.ID_GOC, T2.MS_DH_NHAP_PT_GOC,T4.MS_PT 

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
SELECT        T7.MS_DH_XUAT_PT, T5.MS_DH_NHAP_PT, T2.MS_PT, T8.MS_PT1, T4.XUAT_XU, T5.SL_VT , CONVERT(FLOAT,T6.SL_TT) AS SL_TT, T4.DON_GIA, 
                         T4.NGOAI_TE, T4.TY_GIA, T4.TY_GIA_USD, T4.BAO_HANH_DEN_NGAY, T1.MS_PHIEU_BAO_TRI, T1.STT 
                         AS MS_CV, CONVERT(NVARCHAR(250), T1.STT) 
                         
                       -- ''
                         AS MS_BO_PHAN, T1.STT, T6.GHI_CHU, 
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
                         INNER JOIN IC_PHU_TUNG  T9 ON T9.MS_PT = T2.MS_PT 
                         INNER JOIN LOAI_VT T10 ON T10.MS_LOAI_VT = T9.MS_LOAI_VT 
WHERE        (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI) AND T10.VAT_TU = 0

--SELECT * FROM #TMP_TRA

SELECT DISTINCT
        T.[MS_DH_XUAT_PT], [MS_DH_NHAP_PT],
        dbo.GetPhieuNhapTra(T.MS_DH_XUAT_PT, T.MS_DH_NHAP_PT) AS MS_DH_NHAP_TRA,
		dbo.GetPhieuTaiChe(T.MS_DH_XUAT_PT, T.MS_DH_NHAP_PT,T.MS_PT) AS MS_DH_NHAP_TC,
        T.[MS_PT], [MS_PT1],ISNULL([SO_LUONG_THUC_XUAT],0) AS SO_LUONG_THUC_XUAT,ISNULL(T1.SL_TRA,0) AS SL_TRA,ISNULL([SL_TT],0) AS SL_TT,
        ISNULL(T2.SL_TAICHE,0) AS SL_TAICHE,
		ROUND(ISNULL([DON_GIA],0),2) AS DON_GIA, ROUND(CASE ISNULL(T2.DG_TAICHE,0) WHEN 0 THEN 0 ELSE  CASE ISNULL(T.DON_GIA,0) WHEN 0 THEN ISNULL(T2.DG_TAICHE,0) ELSE T.DON_GIA - ISNULL(T2.DG_TAICHE,0) END END,2)   AS DG_TAICHE, [NGOAI_TE], [TY_GIA],
        [TY_GIA_USD], [XUAT_XU], [BAO_HANH_DEN_NGAY], T.[MS_PHIEU_BAO_TRI],
        [MS_CV], [MS_BO_PHAN], [STT], [GHI_CHU], [ID], T3.TAI_SD
FROM    #TMP T
        LEFT JOIN #TMP_TRA T1 ON T1.MS_PHIEU_BAO_TRI = T.MS_PHIEU_BAO_TRI
                                 AND T1.MS_DH_XUAT_PT = T.MS_DH_XUAT_PT
                                 AND T1.MS_PT_GOC = T.MS_PT
                                 AND T.ID = T1.ID_GOC
                                 AND T.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT_GOC
        LEFT JOIN #TMP_TAICHE T2 ON T2.MS_PHIEU_BAO_TRI = T.MS_PHIEU_BAO_TRI
                                    AND T2.MS_DH_XUAT_PT = T.MS_DH_XUAT_PT
                                    AND T2.MS_PT_GOC = T.MS_PT
                                    AND T.ID = T2.ID_GOC
                                    AND T.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT_GOC
        INNER JOIN dbo.IC_PHU_TUNG T3 ON T3.MS_PT = T.MS_PT


