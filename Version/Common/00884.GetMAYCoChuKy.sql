
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetMAYCoChuKy')
   exec('CREATE PROCEDURE GetMAYCoChuKy AS BEGIN SET NOCOUNT ON; END')
GO

--exec GetMAYCoChuKy '-1', '-1', '-1', '-1', 'admin', 0
ALTER proc [dbo].[GetMAYCoChuKy]
	@MS_NHA_XUONG nvarchar(20),
	@MsHThong nvarchar(20),
	@MS_LOAI_MAY nvarchar(20),
	@USERNAME  nvarchar(20),
	@NNgu int
AS
begin
SELECT * INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(), @USERNAME, @MS_NHA_XUONG, @MsHThong, -1, @MS_LOAI_MAY, -1,-1, @NNgu )


SELECT DISTINCT CONVERT(BIT,0) AS CHON,B.MS_MAY, B.TEN_MAY
FROM         dbo.CHU_KY_HIEU_CHUAN AS A INNER JOIN
#MAY AS B ON A.MS_MAY = B.MS_MAY 
ORDER BY B.MS_MAY, B.TEN_MAY

end