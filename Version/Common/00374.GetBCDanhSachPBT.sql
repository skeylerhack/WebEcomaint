IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetBCDanhSachPBT')
   exec('CREATE PROCEDURE GetBCDanhSachPBT AS BEGIN SET NOCOUNT ON; END')
GO

--DROP TABLE MAY_TMP GO SELECT CONVERT(BIT,1) AS CHON,MS_MAY, TEN_MAY, TEN_LOAI_MAY, TEN_NHOM_MAY, TEN_N_XUONG, TEN_HE_THONG into MAY_TMP FROM [dbo].[MGetMayUserNgay]( '01/01/2016','admin','-1',-1,-1,'-1','-1','-1',0) A
--DROP TABLE TTBT_TMP GO SELECT * INTO TTBT_TMP  FROM TINH_TRANG_PBT
--GetBCDanhSachPBT '01/01/2016','05/01/2016','1626',-1,'ADMIN',0,'MAY_TMP','TTBT_TMP'
ALTER PROC GetBCDanhSachPBT
	@TNgay DATETIME,
	@DNgay DATETIME,
	@MSNVien NVARCHAR(150),
	@MSLBT INT,
	@UserName NVARCHAR(50),
	@NNgu NVARCHAR(50),
	@MayTmp NVARCHAR(50),
	@TTBTTmp NVARCHAR(50)
AS 

DECLARE @sSql NVARCHAR(4000)
CREATE TABLE #MAY_TMP (MS_MAY NVARCHAR(250) NULL, TEN_MAY NVARCHAR(500) NULL, TEN_LOAI_MAY NVARCHAR(500) NULL, TEN_NHOM_MAY NVARCHAR(500) NULL, TEN_N_XUONG NVARCHAR(500) NULL, TEN_HE_THONG NVARCHAR(500) NULL)  
SET @sSql = ' INSERT INTO #MAY_TMP SELECT MS_MAY, TEN_MAY, TEN_LOAI_MAY, TEN_NHOM_MAY, TEN_N_XUONG, TEN_HE_THONG FROM ' + @MayTmp + ' WHERE ISNULL(CHON,0) = 1'
EXEC (@sSql)

SET @sSql = ' DROP TABLE ' + @MayTmp
EXEC (@sSql)

CREATE TABLE #TTBT_TMP (STT [int] NOT NULL,TEN_TINH_TRANH [nvarchar](25) NULL)  
SET @sSql = ' INSERT INTO #TTBT_TMP SELECT STT, CASE ' + @NNgu + ' WHEN 0 THEN TEN_TINH_TRANG WHEN 1 THEN TEN_TINH_TRANG_ANH ELSE TEN_TINH_TRANG_HOA END AS TEN_TINH_TRANH FROM TINH_TRANG_PBT 
					WHERE STT IN (SELECT DISTINCT STT FROM ' +  @TTBTTmp + ' A)'
EXEC (@sSql)

SET @sSql = ' DROP TABLE ' + @TTBTTmp
EXEC (@sSql)


SELECT DISTINCT T1.MS_PHIEU_BAO_TRI INTO #PBT_NS FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU T1 INNER JOIN PHIEU_BAO_TRI T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
WHERE (MS_CONG_NHAN = @MSNVien OR @MSNVien = '-1') AND (NGAY_BD_KH BETWEEN @TNgay AND @DNgay ) AND (@MSLBT = -1 OR T2.MS_LOAI_BT = @MSLBT) 

SELECT T1.MS_PHIEU_BAO_TRI, T1.MS_MAY, T3.TEN_MAY, T3.TEN_LOAI_MAY, TEN_NHOM_MAY, 
	TEN_N_XUONG, TEN_HE_THONG,  T4.TEN_LOAI_BT,T1.LY_DO_BT,T2.TEN_TINH_TRANH, T1.NGAY_BD_KH, T1.NGAY_KT_KH, T1.NGAY_NGHIEM_THU,T1.TT_SAU_BT,
CONVERT(NVARCHAR(2000),dbo.GetCongNhanPBTCV(T1.MS_PHIEU_BAO_TRI)) AS CONG_NHAN INTO #BPT
FROM PHIEU_BAO_TRI T1  INNER JOIN #TTBT_TMP T2 ON T1.TINH_TRANG_PBT = T2.STT INNER JOIN 
	#MAY_TMP T3 ON T1.MS_MAY = T3.MS_MAY INNER JOIN 
	LOAI_BAO_TRI T4 ON T1.MS_LOAI_BT = T4.MS_LOAI_BT INNER JOIN 
	#PBT_NS T5 ON T1.MS_PHIEU_BAO_TRI = T5.MS_PHIEU_BAO_TRI
WHERE (NGAY_BD_KH BETWEEN @TNgay AND @DNgay ) AND (@MSLBT = -1 OR T1.MS_LOAI_BT = @MSLBT) 


SELECT ROW_NUMBER() OVER (ORDER BY T1.MS_PHIEU_BAO_TRI, MS_MAY, TEN_MAY, TEN_LOAI_MAY, TEN_NHOM_MAY, TEN_N_XUONG, TEN_HE_THONG ) AS [STT],
T1.MS_PHIEU_BAO_TRI, MS_MAY, TEN_MAY, TEN_LOAI_MAY, TEN_NHOM_MAY, TEN_N_XUONG, TEN_HE_THONG, TEN_LOAI_BT, LY_DO_BT, 
	TEN_TINH_TRANH, NGAY_BD_KH, NGAY_KT_KH, NGAY_NGHIEM_THU, TT_SAU_BT,CONG_NHAN 
FROM #BPT T1 
ORDER BY T1.MS_PHIEU_BAO_TRI, MS_MAY, TEN_MAY, TEN_LOAI_MAY, TEN_NHOM_MAY, TEN_N_XUONG, TEN_HE_THONG 