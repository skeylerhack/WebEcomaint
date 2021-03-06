
ALTER procedure [dbo].[Tinhthoigianbaocaobynam]
@ms_may nvarchar(100),
@nam  nvarchar(100)
AS
select ms_may,  nhoc.nam, thoigian=
case dbo.tinhnam(ms_may, nhoc.nam)
when 0  then round(convert(float, dbo.tinhngaybynam(ms_may,nhoc.nam),0)/1,2)
else
round(convert(float,dbo.tinhngaybynam(ms_may,nhoc.nam)) /dbo.tinhnam(ms_may, nhoc.nam),2) 
end
from nhoc , dbo.NHOC_nam where dbo.NHOC_nam.nam=nhoc.nam  
and   ms_may=@ms_may and dbo.NHOC_nam.nam=@nam
group by ms_may,nhoc.nam
return
