

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MGetCNVaiTroUsers')
   exec('CREATE PROCEDURE MGetCNVaiTroUsers AS BEGIN SET NOCOUNT ON; END')
GO
--exec MGetCNVaiTroUsers 2, 'trungnv'

alter proc [dbo].[MGetCNVaiTroUsers]
	@iVaiTro int,
	@User NVARCHAR(255)
AS	
	SELECT Distinct MS_TO INTO #TO_USER FROM [dbo].[MGetDonViPhongBanUser](@User)
	SELECT A.MS_CONG_NHAN, (HO + ' ' +  TEN)  AS HO_TEN_CONG_NHAN FROM CONG_NHAN A INNER JOIN CONG_NHAN_VAI_TRO B ON
	A.MS_CONG_NHAN  = B.MS_CONG_NHAN
	INNER JOIN #TO_USER T ON T.MS_TO = A.MS_TO 
	 WHERE MS_VAI_TRO  = @iVaiTro 
	 ORDER BY HO  , TEN 
	
	


