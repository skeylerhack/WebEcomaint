
-- exec GetGIAM_SAT_TINH_TRANG_TSs_DAT 4573, 0, '10-01-OCO-001-00',1
ALTER procedure [dbo].[GetGIAM_SAT_TINH_TRANG_TSs_DAT] 
	@STT INT = 8,
	@DAT BIT =0,
	@MS_MAY NVARCHAR(30) ='-1',
	@LOAI_TS INT = 0
AS
if @LOAI_TS=1  
	SELECT DISTINCT T1.STT, T2.MS_MAY, T8.TEN_MAY,T2.MS_BO_PHAN,T2.MS_BO_PHAN + ': ' + T5.TEN_BO_PHAN TEN_BO_PHAN, T2.MS_TS_GSTT, T6.TEN_TS_GSTT,  T2.TG_TT,  T2.THOI_GIAN , T2.CACH_THUC_HIEN, T2.TIEU_CHUAN_KT, T2.YEU_CAU_DUNG_CU, T2.YEU_CAU_NS, T2.PATH_HD	, NULL AS CT_CVIEC
	FROM dbo.GIAM_SAT_TINH_TRANG AS T1 
	INNER JOIN dbo.GIAM_SAT_TINH_TRANG_TS AS T2 ON T1.STT = T2.STT 
	INNER JOIN dbo.GIAM_SAT_TINH_TRANG_TS_DT AS T3 ON T2.STT = T3.STT AND T2.MS_MAY = T3.MS_MAY AND T2.MS_TS_GSTT = T3.MS_TS_GSTT AND T2.MS_BO_PHAN = T3.MS_BO_PHAN AND T2.MS_TT = T3.MS_TT
	INNER JOIN dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T4 ON T2.MS_MAY = T4.MS_MAY AND T2.MS_BO_PHAN = T4.MS_BO_PHAN AND T2.MS_TS_GSTT = T4.MS_TS_GSTT 
	INNER JOIN dbo.CAU_TRUC_THIET_BI AS T5 ON T4.MS_MAY = T5.MS_MAY AND T4.MS_BO_PHAN = T5.MS_BO_PHAN 
	INNER JOIN dbo.THONG_SO_GSTT AS T6 ON T4.MS_TS_GSTT = T6.MS_TS_GSTT 
	INNER JOIN dbo.GIA_TRI_TS_GSTT AS T7 ON T3.STT_GT = T7.STT AND T3.MS_TS_GSTT = T7.MS_TS_GSTT 
	INNER JOIN dbo.MAY AS T8 ON T5.MS_MAY = T8.MS_MAY 
	WHERE        (T1.STT = @STT) AND (T7.DAT = @DAT) AND (T6.LOAI_TS = @LOAI_TS) AND (T2.MS_MAY = @MS_MAY OR @MS_MAY = '-1')
	ORDER BY T1.STT,T2.MS_MAY,T6.TEN_TS_GSTT--,ISNULL(T5.STT,999)
ELSE	
	SELECT DISTINCT  T2.STT, T2.MS_MAY, T6.TEN_MAY, T2.MS_BO_PHAN, T2.MS_TT, T2.MS_BO_PHAN + ': ' + T4.TEN_BO_PHAN TEN_BO_PHAN , T2.MS_TS_GSTT, T5.TEN_TS_GSTT, T2.GIA_TRI_DO, T10.TEN_DV_DO,T3.TEN_GT,  T2.TG_TT,  T2.THOI_GIAN , T2.CACH_THUC_HIEN, T2.TIEU_CHUAN_KT, T2.YEU_CAU_DUNG_CU, T2.YEU_CAU_NS, T2.PATH_HD, NULL AS CT_CVIEC
	FROM            dbo.GIAM_SAT_TINH_TRANG AS T1 INNER JOIN
							 dbo.GIAM_SAT_TINH_TRANG_TS AS T2 ON T1.STT = T2.STT INNER JOIN
							 dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T3 ON T2.MS_MAY = T3.MS_MAY AND T2.MS_BO_PHAN = T3.MS_BO_PHAN AND T2.MS_TS_GSTT = T3.MS_TS_GSTT AND T2.MS_TT = T3.MS_TT INNER JOIN
							 dbo.CAU_TRUC_THIET_BI AS T4 ON T3.MS_MAY = T4.MS_MAY AND T3.MS_BO_PHAN = T4.MS_BO_PHAN INNER JOIN
							 dbo.THONG_SO_GSTT AS T5 ON T3.MS_TS_GSTT = T5.MS_TS_GSTT INNER JOIN
							 dbo.MAY AS T6 ON T4.MS_MAY = T6.MS_MAY INNER JOIN
							 dbo.NHOM_MAY AS T7 ON T6.MS_NHOM_MAY = T7.MS_NHOM_MAY  LEFT JOIN 
							 DON_VI_DO T10 ON T10.MS_DV_DO = T5.MS_DV_DO
	WHERE        (T1.STT = @STT) AND (T5.LOAI_TS = @LOAI_TS) AND (T2.MS_MAY = @MS_MAY OR @MS_MAY = '-1')
	ORDER BY T2.STT,T2.MS_MAY,T5.TEN_TS_GSTT--,ISNULL(T4.STT,999)
	
