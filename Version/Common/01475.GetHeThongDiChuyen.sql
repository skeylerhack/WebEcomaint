IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'H_MAY_HE_THONG')
   exec('DROP PROCEDURE H_MAY_HE_THONG')
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetHeThongDiChuyen')
   exec('CREATE PROCEDURE GetHeThongDiChuyen AS BEGIN SET NOCOUNT ON; END')
GO


ALTER procedure [dbo].[GetHeThongDiChuyen] 
	@MS_HE_THONG INT = -1,
	@UserName NVARCHAR(50) = 'admin',
	@NNgu INT = 0

AS

DECLARE @NgayMax DATETIME

SELECT @NgayMax = DATEADD(DAY,1, MAX(ISNULL(NGAY_NHAP,GETDATE())))  FROM
(
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_NHA_XUONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_HE_THONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_BO_PHAN_CHIU_PHI 
) A


SELECT DISTINCT MS_MAY,TEN_MAY INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(), @UserName, '-1', @MS_HE_THONG, - 1, '-1', '-1', '-1', @NNgu) 

SELECT        TMP.MS_MAY, T1.TEN_MAY, TMP.NGAY_NHAP, TMP.MS_HE_THONG
FROM            (SELECT        dbo.MAY_HE_THONG.MS_MAY, MAX(dbo.MAY_HE_THONG.NGAY_NHAP) AS NGAY_NHAP, dbo.MAY_HE_THONG.MS_HE_THONG
                          FROM            dbo.MAY_HE_THONG INNER JOIN
                                                    dbo.MAY_HE_THONG_NGAY_MAX ON dbo.MAY_HE_THONG.MS_MAY = dbo.MAY_HE_THONG_NGAY_MAX.MS_MAY AND 
                                                    dbo.MAY_HE_THONG.MS_HE_THONG = dbo.MAY_HE_THONG_NGAY_MAX.MS_HE_THONG
                          GROUP BY dbo.MAY_HE_THONG.MS_MAY, dbo.MAY_HE_THONG.MS_HE_THONG) AS TMP INNER JOIN
                         #MAY AS T1 ON TMP.MS_MAY = T1.MS_MAY
