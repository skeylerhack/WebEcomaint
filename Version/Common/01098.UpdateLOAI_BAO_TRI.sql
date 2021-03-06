
ALTER proc [dbo].[UpdateLOAI_BAO_TRI]
	@MS_LOAI_BT int,
	@MS_HT_BT int,
	@TEN_LOAI_BT nvarchar(40),
	@GHI_CHU nvarchar(255),
	@THU_TU int,
@hu_hong int 
AS
if @THU_TU = -1 set 
	@THU_TU = null

UPDATE LOAI_BAO_TRI SET
	MS_HT_BT=@MS_HT_BT,
	TEN_LOAI_BT=@TEN_LOAI_BT,
	GHI_CHU=@GHI_CHU,
	THU_TU=@THU_TU,
	hu_hong=@hu_hong
WHERE
	MS_LOAI_BT=@MS_LOAI_BT
