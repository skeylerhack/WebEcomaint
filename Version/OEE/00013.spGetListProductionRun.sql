
ALTER PROCEDURE [dbo].[spGetListProductionRun]
	@TuNgay DATE = '10/19/2020',
	@DenNgay DATE  ='10/31/2020',
	@USERNAME NVARCHAR(250) ='admin',
	@NhomMay NVARCHAR(20) ='-1',
	@LoaiMay NVARCHAR(20) = '-1',
	@NNgu INT = 0
AS 
BEGIN
SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(@TuNgay,@username,'-1',-1,-1,@LoaiMay,@NhomMay,'-1', @NNgu) A 
SELECT A.ID,A.MS_TO,A.MS_MAY,B.TEN_HE_THONG,A.OperatorID,A.ItemID,A.POID,A.StartTime,A.EndTime, DATEDIFF(minute, GETDATE(), GETDATE()) AS 'Minute',A.CaSTT,ActualQuantity,A.StandardOutput,A.AllocatedQuantity,A.CD,A.OmePackWeight,(AllocatedQuantity/OmePackWeight)  AS PackageNumber,ActualSpeed,StandardSpeed,DefectQuantity FROM ProductionRunDetails A
INNER JOIN dbo.HE_THONG B ON B.MS_HE_THONG = A.MS_HE_THONG
INNER JOIN #MAY C ON C.MS_MAY = A.MS_MAY
WHERE A.StartTime BETWEEN @TuNgay AND @DenNgay END	

