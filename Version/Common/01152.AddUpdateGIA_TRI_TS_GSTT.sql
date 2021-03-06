IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AddUpdateGIA_TRI_TS_GSTT')
   exec('CREATE PROCEDURE AddUpdateGIA_TRI_TS_GSTT AS BEGIN SET NOCOUNT ON; END')
GO


alter proc [dbo].[AddUpdateGIA_TRI_TS_GSTT]
	@MS_TS_GSTT nvarchar(10),
	@TEN_GIA_TRI nvarchar(50),
	@DAT BIT,
	@GHI_CHU NVARCHAR(255),
	@STT INT	
AS
BEGIN

IF EXISTS ( SELECT * FROM GIA_TRI_TS_GSTT WHERE STT = @STT )
BEGIN 
		UPDATE GIA_TRI_TS_GSTT SET
		TEN_GIA_TRI=@TEN_GIA_TRI,
		DAT=@DAT,
		GHI_CHU =@GHI_CHU
		
	WHERE
		MS_TS_GSTT=@MS_TS_GSTT AND
		STT=@STT

END
ELSE
BEGIN
		INSERT INTO GIA_TRI_TS_GSTT (
		MS_TS_GSTT,
		TEN_GIA_TRI,
		DAT,
		GHI_CHU
	)
	values (
		@MS_TS_GSTT,
		@TEN_GIA_TRI,
		@DAT,
		@GHI_CHU
	)
END



select SCOPE_IDENTITY()
END
