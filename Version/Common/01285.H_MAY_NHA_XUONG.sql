

ALTER procedure [dbo].[H_MAY_NHA_XUONG] 
	@MS_N_XUONG NVARCHAR(50),
	@UserName NVARCHAR(50)

AS

DECLARE @NgayMax DATETIME

SELECT @NgayMax = DATEADD(DAY,1, MAX(ISNULL(NGAY_NHAP,GETDATE())))  FROM
(
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_NHA_XUONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_HE_THONG UNION 
	SELECT MAX(NGAY_NHAP) AS NGAY_NHAP FROM MAY_BO_PHAN_CHIU_PHI 
) A


SELECT DISTINCT MS_MAY,TEN_MAY INTO #MAY FROM dbo.MGetMayUserNgay(@NgayMax, @UserName, @MS_N_XUONG, - 1, - 1, '-1', '-1', '-1', 1) 


SELECT        TMP.MS_MAY, T1.TEN_MAY, TMP.NGAY_NHAP, TMP.MS_N_XUONG
FROM            (SELECT        dbo.MAY_NHA_XUONG.MS_MAY, MAX(dbo.MAY_NHA_XUONG.NGAY_NHAP) AS NGAY_NHAP, dbo.MAY_NHA_XUONG.MS_N_XUONG
                          FROM            dbo.MAY_NHA_XUONG INNER JOIN
                                                    dbo.MAY_NHA_XUONG_NGAY_MAX ON dbo.MAY_NHA_XUONG.MS_MAY = dbo.MAY_NHA_XUONG_NGAY_MAX.MS_MAY AND 
                                                    dbo.MAY_NHA_XUONG.MS_N_XUONG = dbo.MAY_NHA_XUONG_NGAY_MAX.MS_N_XUONG
                          GROUP BY dbo.MAY_NHA_XUONG.MS_MAY, dbo.MAY_NHA_XUONG.MS_N_XUONG) AS TMP INNER JOIN
                         #MAY AS T1 ON TMP.MS_MAY = T1.MS_MAY
WHERE        (TMP.MS_N_XUONG = @MS_N_XUONG)
