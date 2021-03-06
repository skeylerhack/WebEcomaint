
-- exec GetPHIEU_BAO_TRI_CONG_VIECs 'WO-201403000078'

ALTER procedure [dbo].[GetPHIEU_BAO_TRI_CONG_VIECs]
	@MS_PHIEU_BAO_TRI NVARCHAR(20)
AS
SELECT DISTINCT T1.MS_PHIEU_BAO_TRI, T1.MS_CV, T2.MO_TA_CV AS MA_CV, T1.MS_BO_PHAN, T5.TEN_BO_PHAN, T1.NGAY_HOAN_THANH, T1.SO_GIO_KH, 
	T1.DINH_MUC_KH, T1.SO_GIO_PB, T1.DINH_MUC_PB, T1.NGOAI_TE, T1.HANG_MUC_ID, T7.TEN_HANG_MUC, T1.EOR_ID, T3.TEN_CHUYEN_MON, 
	T1.BAC_THO, T1.THUC_KIEM, T1.GHI_CHU, CONVERT(NVARCHAR(250), T1.MS_CV) + CONVERT(NVARCHAR(250), T1.MS_BO_PHAN) AS MSCVBT, 
	ISNULL(T1.THAO_TAC,'') AS THAO_TAC, ISNULL(T1.TIEU_CHUAN_KT,'') AS TIEU_CHUAN_KT, ISNULL(T1.PATH_HD,'') AS PATH_HD, 
	ISNULL(T1.SO_NGUOI,0) AS SO_NGUOI, ISNULL(T1.YEU_CAU_NS,'') AS YEU_CAU_NS, ISNULL(T1.YEU_CAU_DUNG_CU,'') AS YEU_CAU_DUNG_CU, 
	CONVERT(BIT,0) AS YCSD
FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC AS T1 INNER JOIN
	dbo.CONG_VIEC AS T2 ON T1.MS_CV = T2.MS_CV LEFT OUTER JOIN
	dbo.CHUYEN_MON AS T3 ON T2.MS_CHUYEN_MON = T3.MS_CHUYEN_MON LEFT OUTER JOIN
	dbo.BAC_THO AS T4 ON T1.BAC_THO = T4.MS_BAC_THO INNER JOIN
	dbo.CAU_TRUC_THIET_BI AS T5 ON T1.MS_BO_PHAN = T5.MS_BO_PHAN INNER JOIN
	dbo.PHIEU_BAO_TRI AS T6 ON T1.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI AND T5.MS_MAY = T6.MS_MAY LEFT OUTER JOIN
	dbo.KE_HOACH_TONG_THE AS T7 ON T1.HANG_MUC_ID = T7.HANG_MUC_ID
WHERE     (T1.MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI) AND (T1.STT_SERVICE IS NULL)
ORDER BY T1.MS_CV, MA_CV, T1.MS_BO_PHAN, T5.TEN_BO_PHAN

