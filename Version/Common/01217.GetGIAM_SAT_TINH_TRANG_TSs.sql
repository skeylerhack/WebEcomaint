--EXEC GetGIAM_SAT_TINH_TRANG_TSs 33,'ADMIN',0
ALTER procedure [dbo].[GetGIAM_SAT_TINH_TRANG_TSs] 
	@STT int,
	@USERNAME NVARCHAR(50),
	@LOAI_TS INT
AS

SELECT DISTINCT T8.STT, T8.MS_MAY, T6.TEN_MAY, T8.MS_BO_PHAN, T8.MS_TT, T8.MS_BO_PHAN + ': ' + T7.TEN_BO_PHAN TEN_BO_PHAN, T8.MS_TS_GSTT, T1.TEN_TS_GSTT, T8.GIA_TRI_DO,T10.TEN_DV_DO, T9.TEN_GT, ISNULL(T7.STT,999) AS STT_BP, T8.TG_TT,  T8.THOI_GIAN , T8.CACH_THUC_HIEN, T8.TIEU_CHUAN_KT, T8.YEU_CAU_DUNG_CU, T8.YEU_CAU_NS, T8.PATH_HD, NULL AS CT_CVIEC
FROM            dbo.THONG_SO_GSTT AS T1 INNER JOIN
		dbo.LOAI_MAY AS T2 INNER JOIN
		dbo.NHOM_MAY AS T3 ON T2.MS_LOAI_MAY = T3.MS_LOAI_MAY INNER JOIN
		dbo.NHOM_LOAI_MAY AS T4 ON T2.MS_LOAI_MAY = T4.MS_LOAI_MAY INNER JOIN
		dbo.USERS AS T5 ON T4.GROUP_ID = T5.GROUP_ID INNER JOIN
		dbo.MAY AS T6 ON T3.MS_NHOM_MAY = T6.MS_NHOM_MAY INNER JOIN
		dbo.CAU_TRUC_THIET_BI AS T7 ON T6.MS_MAY = T7.MS_MAY INNER JOIN
		dbo.GIAM_SAT_TINH_TRANG_TS AS T8 INNER JOIN
		dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T9 ON T8.MS_MAY = T9.MS_MAY AND T8.MS_BO_PHAN = T9.MS_BO_PHAN AND T8.MS_TS_GSTT = T9.MS_TS_GSTT AND T8.MS_TT = T9.MS_TT ON 
		T7.MS_MAY = T9.MS_MAY AND T7.MS_BO_PHAN = T9.MS_BO_PHAN ON T1.MS_TS_GSTT = T9.MS_TS_GSTT LEFT JOIN 
		DON_VI_DO T10 ON T10.MS_DV_DO = T1.MS_DV_DO
WHERE        (T1.LOAI_TS = @LOAI_TS) AND (T8.STT = @STT) AND (T5.USERNAME = @USERNAME) 
ORDER BY T8.STT,T8.MS_MAY,ISNULL(T7.STT,999),T1.TEN_TS_GSTT
