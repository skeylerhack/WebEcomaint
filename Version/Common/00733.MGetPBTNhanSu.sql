IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MGetPBTNhanSu')
   exec('CREATE FUNCTION  dbo.MGetPBTNhanSu () RETURNS  nvarchar(4000) as Begin return null end')
GO

--SELECT PHIEU_BAO_TRI.*,dbo.[MGetPBTNhanSu]('WO-201603001401') as asdasas FROM PHIEU_BAO_TRI 

ALTER function [dbo].[MGetPBTNhanSu]
(
	@MS_PHIEU_BAO_TRI nvarchar(20)
)
returns nvarchar(4000)
as
begin
declare @sName nvarchar(4000)

	SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + 
		ISNULL(B.MS_CONG_NHAN ,'')+ CASE LEN (ISNULL(B.HO,'')  + ISNULL(B.TEN,'') )  WHEN 0  THEN  '' ELSE N' (' +
 ISNULL(B.HO,'') + N' ' + ISNULL(B.TEN,'') + N')' END 
	FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU A INNER JOIN CONG_NHAN B 
		ON A.MS_CONG_NHAN  = B.MS_CONG_NHAN  
	WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI

              
return @sName
end

