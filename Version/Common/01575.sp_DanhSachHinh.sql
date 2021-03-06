IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_DanhSachHinh')
   exec('CREATE PROCEDURE sp_DanhSachHinh AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC [dbo].[sp_DanhSachHinh]
    @STT INT = 1156 ,
    @MS_TS_GSTR INT =1,
    @MS_MAY NVARCHAR(30) ='10-01-OCO-021-00',
    @MS_BP NVARCHAR(10) ='02',
    @UserName NVARCHAR(50) = 'admin' ,
    @NNgu INT = 0
AS
    BEGIN
        SELECT  DUONG_DAN ,
                GHI_CHU,
				STT_HINH
        FROM    dbo.GIAM_SAT_TINH_TRANG_HINH
        WHERE   STT = @STT
                AND MS_TS_GSTT = @MS_TS_GSTR
                AND MS_MAY = @MS_MAY
                AND MS_BO_PHAN = @MS_BP
    END


