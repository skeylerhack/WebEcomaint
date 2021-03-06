IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MGetMayPhuTungHetTuoiTho')
exec('CREATE PROCEDURE MGetMayPhuTungHetTuoiTho AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[MGetMayPhuTungHetTuoiTho]
	@UserName NVARCHAR(50) ='ADMIN',
	@NNgu NVARCHAR(50) ='0',
	@MS_DUONG NVARCHAR(50) ='-1',
	@MSNX NVARCHAR(150) ='-1',
	@MSHT INT =-1,
	@MSLMAY NVARCHAR(50) ='-1',
	@MSNHOMMAY NVARCHAR(50) ='-1'
as
--@MS_TINH  thay the user
-- @MS_QUAN they the ngon ngu
SELECT CONVERT(BIT,1) AS CHON, MS_MAY,TEN_MAY,MODEL  INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(),@UserName,@MSNX,@MSHT,-1,@MSLMAY,'-1','-1',@NNgu) 	

select DISTINCT A.* from #MAY A
INNER JOIN dbo.CAU_TRUC_THIET_BI_PHU_TUNG B ON B.MS_MAY = A.MS_MAY

