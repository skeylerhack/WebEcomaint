IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetBCDanhMucHangTrongKho')
   exec('CREATE PROCEDURE [dbo].[spGetBCDanhMucHangTrongKho] AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC spGetBCDanhMucHangTrongKho 0, -1,'-1','ADMIN'


ALTER PROC spGetBCDanhMucHangTrongKho
	@SL_TON FLOAT,
	@MsKho INT,
	@MsLoaiVT NVARCHAR(50),
	@UserName NVARCHAR(100)
AS	
-- phan wuyen kho
	SELECT DISTINCT MS_KHO INTO #KHO_USER FROM NHOM_KHO T1 INNER JOIN USERS T2 ON T1.GROUP_ID = T2.GROUP_ID WHERE USERNAME =	@UserName
-- phan wuyen kho loai phu tung	
	SELECT MS_LOAI_PT INTO #USER_LPT FROM NHOM_LOAI_PHU_TUNG T1 INNER JOIN USERS T2 ON T1.GROUP_ID = T2.GROUP_ID WHERE USERNAME = @UserName

-- Lay phu tung phan wuyen	
	SELECT     DISTINCT T1.MS_PT , T1.TEN_PT INTO #PT
	FROM         dbo.IC_PHU_TUNG AS T1 INNER JOIN
		  dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T2 ON T1.MS_PT = T2.MS_PT INNER JOIN 
		  #USER_LPT T3 ON T2.MS_LOAI_PT = T3.MS_LOAI_PT
	WHERE (MS_LOAI_VT = @MsLoaiVT OR @MsLoaiVT = '-1')
	
	
	SELECT T1.MS_PT, SUM(SL_VT) AS SL_TON INTO #PT_TK FROM VI_TRI_KHO_VAT_TU T1 INNER JOIN 
		#PT T2 ON T1.MS_PT = T2.MS_PT INNER JOIN #KHO_USER T3 ON T1.MS_KHO = T3.MS_KHO
	WHERE (T1.MS_KHO = @MsKho OR @MsKho = -1)
	GROUP BY T1.MS_PT HAVING SUM(SL_VT) >= @SL_TON



	
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T1.TEN_PT, T1.MS_PT) AS STT, 
		T1.TEN_PT, NULL AS TEN, T1.MS_PT,SL_TON, dbo.GetPhuTungLoaiMay(T1.MS_PT) AS MDSD , dbo.GetPhuTungLoaiPhuTung(T1.MS_PT) AS GHI_CHU
	FROM         #PT AS T1 INNER JOIN #PT_TK AS T4 ON T1.MS_PT = T4.MS_PT 
	ORDER BY  T1.TEN_PT, T1.MS_PT

