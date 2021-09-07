IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPhuTungLoaiMay')
   exec('CREATE FUNCTION  dbo.GetPhuTungLoaiMay () RETURNS  nvarchar(50) as Begin return null end')
GO
--SELECT DBO.GetPhuTungLoaiMay('120149')	
ALTER function [dbo].[GetPhuTungLoaiMay]
(
	@MsPT nvarchar(50)
)
returns nvarchar(1000)
as 
begin
declare @LoaiMay nvarchar(1000)



	SELECT @LoaiMay =COALESCE(@LoaiMay + '; ', '') +
	CAST(B.TEN_LOAI_MAY AS Nvarchar(1000))
	FROM IC_PHU_TUNG_LOAI_MAY A INNER JOIN LOAI_MAY B ON A.MS_LOAI_MAY = B.MS_LOAI_MAY WHERE MS_PT = @MsPT


return @LoaiMay
end




