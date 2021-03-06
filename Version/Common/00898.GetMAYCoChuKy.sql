
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

SELECT DISTINCT CONVERT(BIT,0) AS CHON,MS_MAY, TEN_MAY, MO_TA FROM dbo.MGetMayUserNgay(GETDATE(), @USERNAME, @MS_NHA_XUONG, @MsHThong, -1, @MS_LOAI_MAY, -1,-1, @NNgu )

end