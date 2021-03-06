IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'getMayTGNgungMay')
   exec('CREATE PROCEDURE [dbo].[getMayTGNgungMay] AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC getMayTGNgungMay 'Admin','GF-01-04','-1',-1, '01/01/2015','01/01/2016',0

ALTER procedure [dbo].[getMayTGNgungMay]	
	@UserName NVARCHAR(50),
	@MsNX NVARCHAR(50),
	@MsLoaiMay NVARCHAR(20),
	@MSHT INT,
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@NNgu int
AS


SELECT DISTINCT MS_MAY,TEN_MAY, A.Ten_N_XUONG, A.TEN_HE_THONG, A.TEN_LOAI_MAY INTO #MAY_USER FROM dbo.MGetMayUserNgay(
	@DenNgay,@UserName,@MsNX,@MSHT,-1,@MsLoaiMay,'-1','-1',0) A

SELECT DISTINCT CONVERT(BIT, 0) AS CHON, A.MS_MAY, A.TEN_MAY, A.Ten_N_XUONG, A.TEN_HE_THONG, A.TEN_LOAI_MAY
FROM         #MAY_USER A INNER JOIN                      
                      dbo.THOI_GIAN_NGUNG_MAY B ON A.MS_MAY = B.MS_MAY
WHERE     (B.NGAY BETWEEN @TuNgay AND @DenNgay )
ORDER BY MS_MAY
