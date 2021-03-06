
ALTER procedure [dbo].[Tinhthoigian_baocao]
@ms_may nvarchar(100),
@quy nvarchar(50)
AS
SELECT     dbo.NHOC.MS_MAY, dbo.NHOC.QUY, 
CASE dbo.tinhquy(ms_may, nhoc.quy) 
	WHEN 0 THEN ROUND(CONVERT(float,dbo.tinhngay(ms_may, nhoc.quy) / 1 ), 2) 
	ELSE ROUND(CONVERT(float,dbo.tinhngay(ms_may, nhoc.quy)) / dbo.tinhquy(ms_may,nhoc.quy),2) END AS thoigian
	
	
FROM         dbo.NHOC INNER JOIN
                      dbo.NHOC_QUY ON dbo.NHOC.QUY = dbo.NHOC_QUY.QUY
WHERE     (dbo.NHOC.MS_MAY = @ms_may) AND (dbo.NHOC_QUY.QUY = @quy)
GROUP BY dbo.NHOC.MS_MAY, dbo.NHOC.QUY
return




