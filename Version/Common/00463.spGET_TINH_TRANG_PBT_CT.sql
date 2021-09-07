IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGET_TINH_TRANG_PBT_CT')
   exec('CREATE PROCEDURE spGET_TINH_TRANG_PBT_CT AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC [dbo].[spGET_TINH_TRANG_PBT_CT]
	@TINH_TRANG_PBT NVARCHAR(255),
	@NNgu INT


AS
BEGIN
	IF(@NNgu = 0)
	BEGIN
		SELECT MS_TT_CT, TEN_TIENG_VIET as TEN FROM TINH_TRANG_PBT_CT WHERE STT = @TINH_TRANG_PBT-- IN (SELECT TOP 1 STT FROM TINH_TRANG_PBT WHERE RTRIM(TEN_TINH_TRANG) = @TINH_TRANG_PBT)
	END
	ELSE
	IF(@NNgu = 1)
	BEGIN
		SELECT MS_TT_CT, TEN_TIENG_ANH as TEN FROM TINH_TRANG_PBT_CT WHERE STT = @TINH_TRANG_PBT --IN (SELECT TOP 1 STT FROM TINH_TRANG_PBT WHERE RTRIM(TEN_TINH_TRANG_ANH) = @TINH_TRANG_PBT)
		RETURN;
	END
	ELSE
	BEGIN
			SELECT MS_TT_CT, TEN_TIENG_HOA as TEN FROM TINH_TRANG_PBT_CT WHERE STT =@TINH_TRANG_PBT --IN (SELECT TOP 1 STT FROM TINH_TRANG_PBT WHERE RTRIM(TEN_TINH_TRANG_HOA) = @TINH_TRANG_PBT)
		RETURN;
	END
		RETURN;
END