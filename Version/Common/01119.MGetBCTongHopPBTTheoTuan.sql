-- select STT INTO TTBT from TINH_TRANG_PBT 

--   MGetBCTongHopPBTTheoTuan '01/01/2017','05/01/2017' ,'-1','-1','-1','-1','admin',0
ALTER proc [dbo].[MGetBCTongHopPBTTheoTuan]
		@TNGAY DATETIME,
		@DNGAY DATETIME,		
		@MSNX NVARCHAR(150),
		@MSHT NVARCHAR(150),
		@MSLMAY NVARCHAR(50),
		@MSLBT INT,
		@USERNAME NVARCHAR(50),
		@NN INT
AS	
DECLARE @NgayHT DATETIME = GETDATE()
SELECT * INTO #MAY_TMP FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,@MSNX,@MSHT, -1,@MSLMAY,-1,'-1', @NN)

DECLARE @GSTT NVARCHAR(250)
	SELECT TOP 1  @GSTT =  CASE @NN WHEN 0 THEN LANGUAGES.VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE FORM = 'ucBaoCaoTongHopPBT' AND KEYWORD =N'GSTT'
DECLARE @KHCV NVARCHAR(250)
	SELECT TOP 1  @KHCV =  CASE @NN WHEN 0 THEN LANGUAGES.VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE FORM = 'ucBaoCaoTongHopPBT' AND KEYWORD =N'KHCV'
DECLARE @Xong NVARCHAR(250)
	SELECT TOP 1  @Xong =  CASE @NN WHEN 0 THEN LANGUAGES.VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE FORM = 'ucBaoCaoTongHopPBT' AND KEYWORD =N'Xong'
DECLARE @Chua NVARCHAR(250)
	SELECT TOP 1  @Chua =  CASE @NN WHEN 0 THEN LANGUAGES.VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE FORM = 'ucBaoCaoTongHopPBT' AND KEYWORD =N'Chua'


SELECT * INTO #PBT FROM PHIEU_BAO_TRI WHERE TINH_TRANG_PBT IN (SELECT DISTINCT STT FROM TTBT) AND ((NGAY_BD_KH >= @TNGAY) AND (NGAY_BD_KH < @DNGAY)) AND (MS_LOAI_BT = @MSLBT OR @MSLBT = -1)

DROP TABLE TTBT

SELECT T1.* , CASE ISNULL(T3.MS_LOAI_CV,99) WHEN 99 THEN NULL ELSE T4.TEN_LOAI_CV END AS TEN_LOAI_CV 
INTO #PBT_PHU_TRO
FROM PHIEU_BAO_TRI_CV_PHU_TRO T1 INNER JOIN #PBT T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
INNER JOIN LOAI_BAO_TRI T3 ON T2.MS_LOAI_BT = T3.MS_LOAI_BT 
LEFT JOIN LOAI_CONG_VIEC T4 ON T3.MS_LOAI_CV = T4.MS_LOAI_CV
WHERE T2.NGAY_BD_KH BETWEEN @TNGAY AND @DNGAY


SELECT DISTINCT 0 [No], T.MS_PHIEU_BAO_TRI [Work Order], T.MS_MAY [Unit No], T1.TEN_N_XUONG  [Area],
T1.TEN_MAY [Plant Discription Dyteline],T7.TEN_LOAI_BT [Maintenance type] ,
T3.MS_BO_PHAN + ' - ' + CASE @NN WHEN 0 THEN T4.MO_TA_CV WHEN 1 THEN T4.MO_TA_CV_ANH ELSE T4.MO_TA_CV_HOA END [Description of Works]
,T5.TEN_LOAI_CV [Man Power], 
T2.TEN [Sup.],CASE @NN WHEN 0 THEN T6.TEN_TINH_TRANG WHEN 1 THEN T6.TEN_TINH_TRANG_ANH ELSE T6.TEN_TINH_TRANG_HOA END  [Status], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, T3.MS_CV,T3.MS_BO_PHAN, 0, 0, 0) [Work Type],CONVERT(NVARCHAR(12), T.NGAY_NGHIEM_THU, 103) [Complete Date], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, T3.MS_CV,T3.MS_BO_PHAN, 0, 2, 0) [Time taken hrs], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, T3.MS_CV,T3.MS_BO_PHAN, 0, 3, 0)[Men No], '' [Total hrs],  
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, T3.MS_CV,T3.MS_BO_PHAN, 0, 1, 0)[Spare parts], T8.CHUC_NANG [Function], T.LY_DO_BT [Remark],
CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) END + ' - ' + CONVERT(NVARCHAR(5), YEAR(T.NGAY_BD_KH))
[Week],CONVERT(INT, CONVERT(NVARCHAR(50), YEAR(T.NGAY_BD_KH)) +  CONVERT(NVARCHAR(50), CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) END)) Sort
FROM #PBT T 
INNER JOIN #MAY_TMP T1 ON T.MS_MAY = T1.MS_MAY
INNER JOIN CONG_NHAN T2 ON T.NGUOI_GIAM_SAT = T2.MS_CONG_NHAN
INNER JOIN PHIEU_BAO_TRI_CONG_VIEC T3 ON T.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI
INNER JOIN CONG_VIEC T4 ON T4.MS_CV= T3.MS_CV
INNER JOIN LOAI_CONG_VIEC T5 ON T5.MS_LOAI_CV = T4.MS_LOAI_CV
INNER JOIN TINH_TRANG_PBT T6 ON T6.STT = T.TINH_TRANG_PBT
INNER JOIN LOAI_BAO_TRI T7 ON T.MS_LOAI_BT = T7.MS_LOAI_BT
INNER JOIN CAU_TRUC_THIET_BI_PHU_TUNG T8 ON T8.MS_MAY = T1.MS_MAY AND T8.MS_BO_PHAN = T3.MS_BO_PHAN

UNION 

SELECT DISTINCT 0 [No], T.MS_PHIEU_BAO_TRI [Work Order], T.MS_MAY [Unit No], T1.TEN_N_XUONG  [Area], 
T1.TEN_MAY [Plant Discription Dyteline], T7.TEN_LOAI_BT [Maintenance type],
T3.TEN_CONG_VIEC [Description of Works], T3.TEN_LOAI_CV AS [Man Power], T2.TEN [Sup.],
CASE @NN WHEN 0 THEN T6.TEN_TINH_TRANG WHEN 1 THEN T6.TEN_TINH_TRANG_ANH ELSE T6.TEN_TINH_TRANG_HOA END  [Status], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, 0, NULL, T3.STT, 0, 0) [Work Type],
CONVERT(NVARCHAR(12), T.NGAY_NGHIEM_THU, 103) [Complete Date], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, 0,NULL, T3.STT, 2, 0) [Time taken hrs], 
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, 0,NULL, T3.STT, 3, 0)[Men No], '' [Total hrs],  
dbo.GetCV_PTPBT(T.MS_PHIEU_BAO_TRI, 0,NULL, T3.STT, 1, 0)[Spare parts], NULL [Function],
T.LY_DO_BT [Remark], 
CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) END + ' - ' + CONVERT(NVARCHAR(5), YEAR(T.NGAY_BD_KH))
[Week],CONVERT(INT, CONVERT(NVARCHAR(50), YEAR(T.NGAY_BD_KH)) +  CONVERT(NVARCHAR(50), CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_BD_KH),2)) END)) Sort
FROM #PBT T 
INNER JOIN #MAY_TMP T1 ON T.MS_MAY = T1.MS_MAY
INNER JOIN CONG_NHAN T2 ON T.NGUOI_GIAM_SAT = T2.MS_CONG_NHAN
INNER JOIN #PBT_PHU_TRO T3 ON T.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI
INNER JOIN TINH_TRANG_PBT T6 ON T6.STT = T.TINH_TRANG_PBT
INNER JOIN LOAI_BAO_TRI T7 ON T.MS_LOAI_BT = T7.MS_LOAI_BT

UNION

SELECT DISTINCT 0 [No], NULL [Work Order], T1.MS_MAY [Unit No], T4.TEN_N_XUONG  [Area],T4.TEN_MAY [Plant Discription Dyteline], @GSTT AS  [Maintenance type], ISNULL(T1.MS_BO_PHAN, '') + ' - ' + ISNULL(T2.TEN_TS_GSTT, '') [Description of Works], NULL [Man Power], 
NULL [Sup.], 
dbo.GetTenGT_TSGSTT(T1.MS_MAY, T1.STT,T1.MS_TS_GSTT,T1.MS_BO_PHAN,T1.MS_TT) AS [Status],
T6.TEN AS [Work Type],CONVERT(NVARCHAR(12), T.NGAY_KT, 103) [Complete Date],
NULL [Time taken hrs], 
NULL [Men No], NULL [Total hrs], NULL [Spare parts],NULL [Function], NULL [Remark],
CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_KT),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) END + ' - ' + CONVERT(NVARCHAR(5), YEAR(T.NGAY_KT))
[Week],CONVERT(INT, CONVERT(NVARCHAR(50), YEAR(T.NGAY_KT)) +  CONVERT(NVARCHAR(50), CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_KT),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) END)) Sort
FROM GIAM_SAT_TINH_TRANG T INNER JOIN GIAM_SAT_TINH_TRANG_TS_DT T1
ON T.STT = T1.STT INNER JOIN THONG_SO_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT
INNER JOIN GIA_TRI_TS_GSTT T3 ON T2.MS_TS_GSTT = T3.MS_TS_GSTT AND T1.STT_GT = T3.STT
INNER JOIN #MAY_TMP T4 ON T1.MS_MAY = T4.MS_MAY
LEFT JOIN CONG_NHAN T6 ON T.MS_CONG_NHAN = T6.MS_CONG_NHAN
WHERE LOAI_TS = 1 AND (NGAY_KT >= @TNGAY) AND (NGAY_KT < @DNGAY)

UNION

SELECT DISTINCT 0 [No], NULL [Work Order], T1.MS_MAY [Unit No], T4.TEN_N_XUONG  [Area],T4.TEN_MAY [Plant Discription Dyteline],
@GSTT AS [Maintenance type], ISNULL(T1.MS_BO_PHAN, '') + ' - ' + ISNULL(T2.TEN_TS_GSTT, '') [Description of Works], NULL [Man Power], 
NULL [Sup.], CONVERT(NVARCHAR(50), T1.GIA_TRI_DO) + ' ' + ISNULL(TEN_DV_DO, '') AS [Status],
T6.TEN AS [Work Type],CONVERT(NVARCHAR(12), T.NGAY_KT, 103) [Complete Date],
NULL [Time taken hrs], 
NULL [Men No], NULL [Total hrs], NULL [Spare parts],NULL [Function], NULL [Remark],
CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_KT),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) END + ' - ' + CONVERT(NVARCHAR(5), YEAR(T.NGAY_KT))
[Week],CONVERT(INT, CONVERT(NVARCHAR(50), YEAR(T.NGAY_KT)) +  CONVERT(NVARCHAR(50), CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T.NGAY_KT),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T.NGAY_KT),2)) END)) Sort

FROM GIAM_SAT_TINH_TRANG T INNER JOIN GIAM_SAT_TINH_TRANG_TS T1
ON T.STT = T1.STT INNER JOIN THONG_SO_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT
INNER JOIN #MAY_TMP T4 ON T1.MS_MAY = T4.MS_MAY
LEFT JOIN DON_VI_DO T5 ON T5.MS_DV_DO = T2.MS_DV_DO 
LEFT JOIN CONG_NHAN T6 ON T1.MS_CONG_NHAN = T.MS_CONG_NHAN
WHERE LOAI_TS = 0 AND (NGAY_KT >= @TNGAY) AND (NGAY_KT < @DNGAY)

UNION 
SELECT 0 [No], NULL AS [Work Order], NULL [Unit No], NULL   [Area],NULL [Plant Discription Dyteline], @KHCV [Maintenance type] ,
TEN_CONG_VIEC AS [Description of Works],NULL AS [Man Power], NULL [Sup.],
CASE T1.DA_XONG WHEN 0 THEN @Chua ELSE @Xong END  As [Status], T2.TEN AS [Work Type],
CASE T1.DA_XONG WHEN 1 THEN CONVERT(NVARCHAR(12), T1.NGAY, 103) ELSE NULL END [Complete Date], 
THOI_GIAN_DK AS [Time taken hrs], 1 AS [Men No], NULL [Total hrs],  
NULL AS [Spare parts], NULL [Function], T1.GHI_CHU [Remark],
CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T1.NGAY),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T1.NGAY),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T1.NGAY),2)) END + ' - ' + CONVERT(NVARCHAR(5), YEAR(T1.NGAY))
[Week],CONVERT(INT, CONVERT(NVARCHAR(50), YEAR(T1.NGAY)) +  CONVERT(NVARCHAR(50), CASE WHEN CONVERT(INT, RIGHT(DATENAME(wk,T1.NGAY),2)) < 10 THEN + '0' +
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T1.NGAY),2)) ELSE
CONVERT(NVARCHAR(5), RIGHT(DATENAME(wk,T1.NGAY),2)) END)) Sort
FROM KE_HOACH_THUC_HIEN T1 INNER JOIN CONG_NHAN T2 ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN 
WHERE  (T1.NGAY >= @TNGAY) AND (T1.NGAY < @DNGAY)