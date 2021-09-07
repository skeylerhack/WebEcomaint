IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spGetDanhSachGiayPhep' )
    EXEC('CREATE PROCEDURE spGetDanhSachGiayPhep AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE dbo.spGetDanhSachGiayPhep
    @TYPE INT = 0 ,
    @UName NVARCHAR(100) = 'admin' ,
    @TNgay DATETIME = '01/01/2020' ,
    @DNgay DATETIME = '01/01/2021' ,
    @Duyet INT = -1
AS
    SELECT DISTINCT A.MS_N_XUONG, CASE @TYPE WHEN 0 THEN B.Ten_N_XUONG WHEN 1 THEN ISNULL(B.TEN_N_XUONG_A,B.Ten_N_XUONG) ELSE ISNULL(B.TEN_N_XUONG_H,B.Ten_N_XUONG) END AS Ten_N_XUONG INTO #TMPNX FROM dbo.NHOM_NHA_XUONG A
	INNER JOIN dbo.NHA_XUONG B ON B.MS_N_XUONG = A.MS_N_XUONG
	WHERE GROUP_ID = (SELECT TOP 1 GROUP_ID FROM dbo.USERS WHERE USERNAME = @UName)


    SELECT  DISTINCT
            A.MS_GP, A.MS_LOAI_GP,
            ( CASE @TYPE
                WHEN 0 THEN TEN_LOAI_GP
                WHEN 1 THEN ISNULL(TEN_LOAI_GP_A, TEN_LOAI_GP)
                ELSE ISNULL(TEN_LOAI_GP_H, TEN_LOAI_GP)
              END ) AS TEN_LOAI_GP, A.MS_N_XUONG, Ten_N_XUONG,
            A.DS_PHIEU_BAO_TRI, A.DUYET,CASE A.DUYET WHEN 0 THEN N'Đang soạn' ELSE N'Đã duyệt' END TINH_TRANG, A.NGUOI_LAP, A.NGAY_LAP,
            A.NGUOI_DUYET, A.NGAY_DUYET, A.GHI_CHU
    FROM    dbo.GIAY_PHEP A
            INNER JOIN dbo.LOAI_GIAY_PHEP B ON B.MS_LOAI_GP = A.MS_LOAI_GP
            INNER JOIN #TMPNX ON #TMPNX.MS_N_XUONG = A.MS_N_XUONG
    WHERE   A.NGAY_LAP BETWEEN @TNgay AND @DNgay
            AND ( A.DUYET = @Duyet
                  OR @Duyet = -1
                )
GO

