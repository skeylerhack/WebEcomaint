IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPhuTungLoaiPhuTung')
   exec('CREATE FUNCTION  dbo.GetPhuTungLoaiPhuTung () RETURNS  nvarchar(50) as Begin return null end')
GO
--SELECT DBO.GetPhuTungLoaiPhuTung('120149')	
ALTER function [dbo].[GetPhuTungLoaiPhuTung]
(
	@MsPT nvarchar(50)
)
returns nvarchar(1000)
as 
begin
declare @LoaiPT nvarchar(1000)



	SELECT @LoaiPT =COALESCE(@LoaiPT + '; ', '') +
	CAST(B.TEN_LOAI_PT AS Nvarchar(1000))
	FROM IC_PHU_TUNG_LOAI_PHU_TUNG A INNER JOIN LOAI_PHU_TUNG B ON A.MS_LOAI_PT = B.MS_LOAI_PT WHERE MS_PT = @MsPT


return @LoaiPT
end

