IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'H_MAY_NHA_XUONG')
   exec('DROP PROCEDURE H_MAY_NHA_XUONG')
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetNhaXuongDiChuyen')
   exec('CREATE PROCEDURE GetNhaXuongDiChuyen AS BEGIN SET NOCOUNT ON; END')
GO



ALTER procedure [dbo].[GetNhaXuongDiChuyen] 
	@MS_N_XUONG NVARCHAR(50) = 'VF01',
	@UserName NVARCHAR(50) = 'admin',
	@NNgu INT = 1

AS



SELECT DISTINCT MS_MAY,TEN_MAY, Ten_N_XUONG INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(), @UserName, @MS_N_XUONG, - 1, - 1, '-1', '-1', '-1', @NNgu) T1


SELECT        TMP.MS_MAY, T1.TEN_MAY, TMP.NGAY_NHAP, TMP.MS_N_XUONG
FROM            (SELECT        dbo.MAY_NHA_XUONG.MS_MAY, MAX(dbo.MAY_NHA_XUONG.NGAY_NHAP) AS NGAY_NHAP, dbo.MAY_NHA_XUONG.MS_N_XUONG
                          FROM            dbo.MAY_NHA_XUONG INNER JOIN
                                                    dbo.MAY_NHA_XUONG_NGAY_MAX ON dbo.MAY_NHA_XUONG.MS_MAY = dbo.MAY_NHA_XUONG_NGAY_MAX.MS_MAY AND 
                                                    dbo.MAY_NHA_XUONG.MS_N_XUONG = dbo.MAY_NHA_XUONG_NGAY_MAX.MS_N_XUONG
                          GROUP BY dbo.MAY_NHA_XUONG.MS_MAY, dbo.MAY_NHA_XUONG.MS_N_XUONG) AS TMP INNER JOIN
                         #MAY AS T1 ON TMP.MS_MAY = T1.MS_MAY
--WHERE        (TMP.MS_N_XUONG = @MS_N_XUONG OR @MS_N_XUONG = '-1')
