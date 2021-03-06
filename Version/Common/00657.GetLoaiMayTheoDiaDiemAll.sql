
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetLoaiMayTheoDiaDiemAll')
   exec('CREATE PROCEDURE GetLoaiMayTheoDiaDiemAll AS BEGIN SET NOCOUNT ON; END')
GO

ALTER procedure [dbo].[GetLoaiMayTheoDiaDiemAll] 
	@MS_N_XUONG NVARCHAR(50),
	@CoAll bit
AS

IF @CoAll = 0
BEGIN
		SELECT DISTINCT dbo.LOAI_MAY.MS_LOAI_MAY, dbo.LOAI_MAY.TEN_LOAI_MAY
		FROM         dbo.LOAI_MAY INNER JOIN
		                      dbo.NHOM_MAY ON dbo.LOAI_MAY.MS_LOAI_MAY = dbo.NHOM_MAY.MS_LOAI_MAY INNER JOIN
		                      dbo.MAY ON dbo.NHOM_MAY.MS_NHOM_MAY = dbo.MAY.MS_NHOM_MAY INNER JOIN
		                      dbo.MAY_NHA_XUONG ON dbo.MAY.MS_MAY = dbo.MAY_NHA_XUONG.MS_MAY
		WHERE     (MAY_NHA_XUONG.MS_N_XUONG = @MS_N_XUONG OR @MS_N_XUONG = '-1')
		ORDER BY dbo.LOAI_MAY.TEN_LOAI_MAY
END
ELSE
BEGIN
		SELECT DISTINCT dbo.LOAI_MAY.MS_LOAI_MAY, dbo.LOAI_MAY.TEN_LOAI_MAY
		FROM         dbo.LOAI_MAY INNER JOIN
		                      dbo.NHOM_MAY ON dbo.LOAI_MAY.MS_LOAI_MAY = dbo.NHOM_MAY.MS_LOAI_MAY INNER JOIN
		                      dbo.MAY ON dbo.NHOM_MAY.MS_NHOM_MAY = dbo.MAY.MS_NHOM_MAY INNER JOIN
		                      dbo.MAY_NHA_XUONG ON dbo.MAY.MS_MAY = dbo.MAY_NHA_XUONG.MS_MAY
		WHERE     (MAY_NHA_XUONG.MS_N_XUONG = @MS_N_XUONG OR @MS_N_XUONG = '-1')
		UNION
		SELECT '-1' , ' < ALL > '
		ORDER BY dbo.LOAI_MAY.TEN_LOAI_MAY

END