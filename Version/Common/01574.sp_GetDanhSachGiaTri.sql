IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetDanhSachGiaTri')
   exec('CREATE PROCEDURE sp_GetDanhSachGiaTri AS BEGIN SET NOCOUNT ON; END')
GO
--danh sách giá trị từ database
ALTER PROCEDURE [dbo].[sp_GetDanhSachGiaTri]
    @STT INT = 6141,
    @MsThonsSo INT = 1,
    @LoaiTS INT = 0,
 -- 1 DINH TINH  0 DINH LUONG
    @MsMay NVARCHAR(100) = '10-01-OCO-021-00' ,
    @MsBP NVARCHAR(100) = '02' ,
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
    IF @LoaiTS = 1
        BEGIN
            SELECT T2.TEN_GIA_TRI,T1.GHI_CHU,T1.STT_GT FROM dbo.GIAM_SAT_TINH_TRANG_TS_DT T1
LEFT JOIN dbo.GIA_TRI_TS_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT AND T1.STT_GT =T2.STT
 WHERE T1.STT =@STT AND T1.MS_MAY=@MsMay AND T1.MS_TS_GSTT =@MsThonsSo AND T1.MS_BO_PHAN =@MsBP
            ORDER BY T2.TEN_GIA_TRI,T2.GHI_CHU, T1.STT_GT
        END
    ELSE
        BEGIN
            SELECT T1.TEN_GT,T1.GIA_TRI_DUOI,T1.GIA_TRI_TREN 
FROM  dbo.CAU_TRUC_THIET_BI_TS_GSTT T1
WHERE T1.MS_MAY =@MsMay AND T1.MS_TS_GSTT=@MsThonsSo AND T1.MS_BO_PHAN=@MsBP
			ORDER BY T1.GIA_TRI_DUOI,T1.GIA_TRI_TREN 	
        END

