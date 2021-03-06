

ALTER PROCEDURE [dbo].[spGetPhieuTheoDiaDiem]
	@UName NVARCHAR(100) ='admin',
	@MS_N_XUONG NVARCHAR(50) ='-1',
	@TNgay DATE = '05/01/2020',
	@dNgay DATE = '05/31/2020'
AS

SELECT * INTO #MAY_USER FROM [dbo].[MGetMayUserNgay](@DNgay,@UName,@MS_N_XUONG,-1,-1,'-1','-1','-1',0)

SELECT  DISTINCT   T1.MS_PHIEU_BAO_TRI
FROM         dbo.PHIEU_BAO_TRI AS T1 INNER JOIN
                      #MAY_USER AS T2 ON T1.MS_MAY = T2.MS_MAY 
WHERE CONVERT(DATE,T1.NGAY_BD_KH) BETWEEN @TNgay AND @dNgay
ORDER BY T1.MS_PHIEU_BAO_TRI DESC
					  
