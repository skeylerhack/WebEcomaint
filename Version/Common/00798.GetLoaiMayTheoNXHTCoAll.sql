IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetLoaiMayTheoNXHTCoAll')
   exec('CREATE PROCEDURE GetLoaiMayTheoNXHTCoAll AS BEGIN SET NOCOUNT ON; END')
GO





--EXEC GetLoaiMayTheoNXHTCoAll '-1',-1,'ADMINISTRATOR',0,0
ALTER proc [dbo].[GetLoaiMayTheoNXHTCoAll]	
	@MsNXuong NVARCHAR(50),
	@MsHThong AS INT,
	@UserName nvarchar(50),
	@NNgu INT,
	@CoAll bit
AS

declare @NgayBD DATETIME
SET @NgayBD = GETDATE()

SELECT * INTO #MAY FROM dbo.MGetMayUserNgay(@NgayBD,@USERNAME,@MsNXuong,@MsHThong,-1,'-1','-1', '-1',@NNgu) 


if @CoALL = 0
	SELECT DISTINCT  T1.MS_LOAI_MAY, T1.TEN_LOAI_MAY FROM #MAY AS T1 ORDER BY TEN_LOAI_MAY
ELSE
	SELECT DISTINCT  T1.MS_LOAI_MAY, T1.TEN_LOAI_MAY FROM #MAY AS T1 
UNION SELECT '-1',' < ALL > '
	ORDER BY TEN_LOAI_MAY


