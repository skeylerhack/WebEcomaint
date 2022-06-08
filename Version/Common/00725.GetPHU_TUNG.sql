
ALTER proc [dbo].[GetPHU_TUNG]
	@NNGU nvarchar(5)
AS
SELECT *,MS_PT + ' - ' + case @NNGU when 0 then TEN_PT when 1 then ISNULL(TEN_PT_ANH,TEN_PT) when 2 then ISNULL(TEN_PT_HOA,TEN_PT) end  AS TENPT 
FROM IC_PHU_TUNG WHERE DUNG_CU_DO=1
