IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCheckCongViec')
   exec('CREATE PROCEDURE spCheckCongViec AS BEGIN SET NOCOUNT ON; END')
GO


-- EXEC spCheckCongViec N'Thay van điện từ', 2,'DRS'

ALTER PROC [dbo].[spCheckCongViec]
	@MTCV NVARCHAR(500),
	@LCV INT,
	@LMAY NVARCHAR(50)
AS
	SELECT * FROM CONG_VIEC WHERE (MO_TA_CV = @MTCV) AND (MS_LOAI_CV = @LCV OR @LCV = -1) AND (MS_LOAI_MAY = @LMAY OR @LMAY = '-1')