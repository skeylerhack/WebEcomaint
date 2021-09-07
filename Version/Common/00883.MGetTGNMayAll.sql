
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'fn' AND name = 'MGetTGNMayAll')
   exec('CREATE FUNCTION  dbo.MGetTGNMayAll () returns float  as begin  return null end')
GO

--SELECT DBO.MGetTGNMayAll('09/01/2012', '09/30/2012','1111' )
alter FUNCTION [dbo].[MGetTGNMayAll]--không where HU_HONG
 ( 
	@TNgay DATETIME ,
	@DNgay DATETIME ,
	@MS_MAY NVARCHAR(30)
)

RETURNS float AS BEGIN

declare @TGian FLOAT

SELECT @TGian = ISNULL(SUM(THOI_GIAN_SUA_CHUA) / 60,0)  FROM dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN 
dbo.NGUYEN_NHAN_DUNG_MAY AS B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN 
WHERE (MS_MAY = @MS_MAY)  AND (A.NGAY BETWEEN @TNgay AND @DNgay ) 

RETURN @TGian
END
