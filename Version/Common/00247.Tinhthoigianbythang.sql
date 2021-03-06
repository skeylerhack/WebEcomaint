
ALTER procedure [dbo].[Tinhthoigianbythang]
	@ms_may nvarchar(100),
	@thang nvarchar(50)
AS
--select ms_may,  nhoc.thang,thoigian=

--case dbo.tinhthang(ms_may, nhoc.thang)
--when 0 then  
--	ROUND(CONVERT(float,dbo.tinhngaybythang(ms_may,nhoc.thang))/1 ,2)
--else
--	ROUND(CONVERT(float, dbo.tinhngaybythang(ms_may,nhoc.thang)) /dbo.tinhthang(ms_may, nhoc.thang),2)
--end 

--from nhoc , dbo.NHOC_thang where dbo.NHOC_thang.thang=nhoc.thang 
-- and   ms_may=@ms_may and dbo.NHOC_thang.thang=@thang
--group by ms_may,nhoc.thang
--return


SELECT     MS_MAY, dbo.NHOC.thang, CASE dbo.tinhthang(ms_may, nhoc.thang) WHEN 0 THEN ROUND(CONVERT(float, dbo.tinhngaybythang(ms_may, nhoc.thang)) / 1, 2) 
                      ELSE ROUND(CONVERT(float, dbo.tinhngaybythang(ms_may, nhoc.thang)) / dbo.tinhthang(ms_may, nhoc.thang), 2) END AS thoigian
FROM         dbo.NHOC INNER JOIN
                      dbo.NHOC_thang ON dbo.NHOC.thang = dbo.NHOC_thang.thang
WHERE     (dbo.NHOC.MS_MAY = @ms_may) AND (dbo.NHOC_thang.thang = @thang)
GROUP BY dbo.NHOC.MS_MAY, dbo.NHOC.thang
RETURN