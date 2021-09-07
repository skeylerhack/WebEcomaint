

--exec MGetCNVaiTroUsers 2, 'admin'
alter proc [dbo].[MGetCNVaiTroUsers]
	@iVaiTro int,
	@User NVARCHAR(255)
AS	
	SELECT Distinct MS_TO INTO #TO_USER FROM [dbo].[MGetDonViPhongBanUser](@User)
	SELECT A.MS_CONG_NHAN, (HO + ' ' +  TEN)  AS HO_TEN_CONG_NHAN FROM CONG_NHAN A INNER JOIN CONG_NHAN_VAI_TRO B ON
	A.MS_CONG_NHAN  = B.MS_CONG_NHAN
	INNER JOIN [TO] T1 ON T1.MS_TO1 = A.MS_TO 
	INNER JOIN #TO_USER T ON T.MS_TO = T1.MS_TO 
	 WHERE (MS_VAI_TRO  = @iVaiTro) or (@iVaiTro = -1)
	 ORDER BY HO  , TEN 




	
	


