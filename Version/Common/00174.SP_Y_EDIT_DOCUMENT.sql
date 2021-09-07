
ALTER procedure [dbo].[SP_Y_EDIT_DOCUMENT]
	@MS_TL NVARCHAR (50),
	@TEN_TL NVARCHAR (256),
	@TEN_TL_E NVARCHAR (256),
	@TEN_TL_CH NVARCHAR (256),
	@MS_TO INT,
	@MS_QT INT,
	@MAC_DINH BIT
AS
BEGIN					
	UPDATE dbo.DS_TL  SET TEN_TL = @TEN_TL , TEN_TL_E = @TEN_TL_E, TEN_TL_CH = @TEN_TL_CH
	WHERE MS_TL = @MS_TL
END
