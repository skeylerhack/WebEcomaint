
ALTER proc [dbo].[AddLOAI_BAO_TRI]
	
	@MS_HT_BT int,
	@TEN_LOAI_BT nvarchar(40),
	@GHI_CHU nvarchar(255),
	@THU_TU int,
	@hu_hong int 

AS

if @THU_TU = -1 set 
	@THU_TU = null


begin
INSERT INTO LOAI_BAO_TRI (
	MS_HT_BT,
	TEN_LOAI_BT,
	GHI_CHU,
	THU_TU,hu_hong
)
values (
	@MS_HT_BT ,
	@TEN_LOAI_BT,
	@GHI_CHU,
	@THU_TU,
@hu_hong
)
select SCOPE_IDENTITY()
end
