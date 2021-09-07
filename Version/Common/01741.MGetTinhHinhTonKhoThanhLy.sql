IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MGetTinhHinhTonKhoThanhLy')
exec('CREATE PROCEDURE MGetTinhHinhTonKhoThanhLy AS BEGIN SET NOCOUNT ON; END')
GO
--EXEC MGetTinhHinhTonKhoThanhLy -1,'-1',-1,0,N'Hết kho', N'Thiếu',N'Đủ',N'Dư',N'ALL0'
ALTER PROCEDURE [dbo].[MGetTinhHinhTonKhoThanhLy]
		@MsKho INT = -1, 
		@MsLVTu nvarchar(10) = '-1',
		@MsClass int = '-1',
		@NNgu int = 0,
		@Het nvarchar(500) = N'Hết',
		@Thieu nvarchar(500) = N'Thiếu',
		@VuaDu nvarchar(500) = N'VuaDu',
		@Du nvarchar(500) = N'Đủ',
		@All0 nvarchar(500) = N'All'
as 
--- lấy ra phụ tùng
SELECT T2.MS_PT,T2.MS_PT_CTY, T2.TEN_PT, T2.TEN_PT_VIET, T2.MS_PT_NCC, T2.QUY_CACH, T2.THEO_KHO,T4.TEN_HSX,T3.TEN_1 AS DVT , T2.ACTIVE_PT,T5.TEN_CLASS
INTO #ICPT 
FROM dbo.IC_PHU_TUNG T2 
INNER JOIN dbo.DON_VI_TINH T3 ON T3.DVT = T2.DVT 
LEFT JOIN dbo.HANG_SAN_XUAT T4 ON T4.MS_HSX = T2.MS_HSX 
LEFT JOIN dbo.CLASS_VT T5 ON T5.MS_CLASS = T2.MS_CLASS 
WHERE  ('-1' = @MsLVTu OR T2.MS_LOAI_VT = @MsLVTu) AND (-1 = @MsClass OR ISNULL(T2.MS_CLASS,-99) = @MsClass) 


SELECT MS_KHO, TEN_KHO INTO #ICKHO FROM IC_KHO  WHERE  (@MsKho = -1 OR @MsKho = 0 OR MS_KHO = @MsKho)
UNION
SELECT 0, CASE @NNGU WHEN 0 THEN N'Không theo kho' ELSE  N'Not in warehouse' END TEN_KHO
SELECT DISTINCT MS_PT, 0 AS MS_KHO, CASE @NNGU WHEN 0 THEN N'Không theo kho' ELSE  N'Not in warehouse' END TEN_KHO, CONVERT(FLOAT,NULL) AS TON_TT,'' AS GHI_CHU
INTO #VTKKHO 
FROM #ICPT 
WHERE THEO_KHO = 0 



SELECT DISTINCT T1.MS_PT,T1.MS_KHO, T3.TEN_KHO, CONVERT(FLOAT,NULL) AS TON_TT,T1.GHI_CHU
INTO #VTTHEOKHO 
FROM dbo.IC_PHU_TUNG_KHO T1 
INNER JOIN #ICPT T2 ON T2.MS_PT = T1.MS_PT 
INNER JOIN #ICKHO T3 ON T3.MS_KHO = T1.MS_KHO 
WHERE T2.THEO_KHO = 1 
GROUP BY T1.MS_PT,T1.MS_KHO,T1.GHI_CHU, T3.TEN_KHO



SELECT T1.MS_KHO,T2.TEN_KHO, T1.MS_PT,SUM(T1.SL_VT) AS TON_TT INTO  #TONKHO 
FROM dbo.VI_TRI_KHO_VAT_TU_X T1 INNER JOIN #ICKHO T2 ON T1.MS_KHO = T2.MS_KHO INNER JOIN #ICPT T3 ON T3.MS_PT = T1.MS_PT
GROUP BY T1.MS_KHO,T2.TEN_KHO,T1.MS_PT HAVING SUM(SL_VT)>0

SELECT T1.MS_PT,SUM(SL_VT) AS TON_TT INTO  #TONKHOTONG 
FROM dbo.VI_TRI_KHO_VAT_TU_X T1 
INNER JOIN #ICKHO T2 ON T1.MS_KHO = T2.MS_KHO 
INNER JOIN #ICPT T3 ON T3.MS_PT = T1.MS_PT    
GROUP BY T1.MS_PT HAVING SUM(SL_VT)>0


UPDATE #VTTHEOKHO SET TON_TT = T2.TON_TT FROM #VTTHEOKHO T1 INNER JOIN #TONKHO T2 ON T2.MS_KHO = T1.MS_KHO AND T2.MS_PT = T1.MS_PT
UPDATE #VTKKHO SET TON_TT = T2.TON_TT FROM #VTKKHO T1 INNER JOIN #TONKHOTONG T2 ON T2.MS_PT = T1.MS_PT



SELECT T1.*, CONVERT(FLOAT,T2.TON_TT) AS TON_TONG INTO #VTPT FROM (
SELECT MS_PT, TEN_KHO, TON_TT,GHI_CHU FROM #VTTHEOKHO 
UNION
SELECT T1.MS_PT,T1.TEN_KHO, T1.TON_TT,NULL AS GHI_CHU
FROM #TONKHO T1 INNER JOIN dbo.IC_PHU_TUNG T2 ON T1.MS_PT = T2.MS_PT  
WHERE NOT EXISTS(SELECT * FROM #VTTHEOKHO T2 WHERE T1.MS_PT = T2.MS_PT AND T1.MS_KHO = T2.MS_KHO)  AND T2.THEO_KHO = 1
UNION	
SELECT MS_PT,TEN_KHO, TON_TT,GHI_CHU
FROM #VTKKHO 
) T1 INNER JOIN #TONKHOTONG T2 ON T1.MS_PT = T2.MS_PT


SELECT T1.MS_PT, T1.TEN_KHO,T2.MS_PT_CTY, T2.TEN_PT, T2.TEN_PT_VIET, T2.MS_PT_NCC, T2.QUY_CACH,T2.TEN_HSX,T2.TEN_CLASS, T1.TON_TT,TON_TONG,  
		T1.GHI_CHU, T2.ACTIVE_PT
		INTO #TMP 
FROM #VTPT T1 INNER JOIN #ICPT T2 ON T1.MS_PT = T2.MS_PT 


if @MsKho = 0
	SELECT MS_PT, TEN_KHO, MS_PT_CTY, TEN_PT, TEN_PT_VIET, MS_PT_NCC, QUY_CACH, TEN_HSX, TEN_CLASS,TON_TT, TON_TONG, GHI_CHU, ACTIVE_PT FROM #TMP WHERE TEN_KHO = N'Không theo kho' or TEN_KHO = N'Not in warehouse' ORDER BY MS_PT,TEN_KHO
else
	SELECT MS_PT, TEN_KHO, MS_PT_CTY, TEN_PT, TEN_PT_VIET, MS_PT_NCC, QUY_CACH, TEN_HSX, TEN_CLASS, TON_TT, TON_TONG, GHI_CHU, ACTIVE_PT FROM #TMP  ORDER BY MS_PT,TEN_KHO

