
ALTER FUNCTION  [dbo].[tinhthang] (@ms_may nvarchar(50), @thang nvarchar(50)) 
RETURNS  int 
as 
Begin 
return (select  count(ms_may) + 1  from    dbo.nhoc  where ms_may =@ms_may  and thang = @thang  and ngay_ke_tiep>ngay ) 
end

