
ALTER procedure [dbo].[H_MAY_HE_THONG] 
	@MS_HE_THONG INT,
	@UserName NVARCHAR(50)

AS

DECLARE @NgayMax DATETIME

SELECT @NgayMax = DATEADD(DAY,1, MAX(ISNULL(NGAY_NHAP,GETDATE())))  FROM
(
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_NHA_XUONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_HE_THONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_BO_PHAN_CHIU_PHI 
) A


SELECT DISTINCT MS_MAY,TEN_MAY INTO #MAY FROM dbo.MGetMayUserNgay(@NgayMax, @UserName, '-1', @MS_HE_THONG, - 1, '-1', '-1', '-1', 1) 

SELECT        TMP.MS_MAY, T1.TEN_MAY, TMP.NGAY_NHAP, TMP.MS_HE_THONG
FROM            (SELECT        dbo.MAY_HE_THONG.MS_MAY, MAX(dbo.MAY_HE_THONG.NGAY_NHAP) AS NGAY_NHAP, dbo.MAY_HE_THONG.MS_HE_THONG
                          FROM            dbo.MAY_HE_THONG INNER JOIN
                                                    dbo.MAY_HE_THONG_NGAY_MAX ON dbo.MAY_HE_THONG.MS_MAY = dbo.MAY_HE_THONG_NGAY_MAX.MS_MAY AND 
                                                    dbo.MAY_HE_THONG.MS_HE_THONG = dbo.MAY_HE_THONG_NGAY_MAX.MS_HE_THONG
                          GROUP BY dbo.MAY_HE_THONG.MS_MAY, dbo.MAY_HE_THONG.MS_HE_THONG) AS TMP INNER JOIN
                         #MAY AS T1 ON TMP.MS_MAY = T1.MS_MAY
WHERE        (TMP.MS_HE_THONG = @MS_HE_THONG)