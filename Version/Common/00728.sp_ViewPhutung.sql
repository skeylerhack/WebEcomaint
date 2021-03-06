

--EXEC sp_ViewPhutung 'AIC-0001',0,-1,'ADMIN'
ALTER procedure [dbo].[sp_ViewPhutung]	
	@sLOAI_MAY varchar(30),
	@NNgu INT,
	@MS_LOAI_PT INT,
	@UserName NVARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT DISTINCT MS_LOAI_PT INTO #LPT_USER FROM NHOM_LOAI_PHU_TUNG A INNER JOIN USERS B ON A.GROUP_ID = B.GROUP_ID WHERE USERNAME = @UserName
							  	
	
	SELECT DISTINCT  CONVERT(BIT, 0) AS chkChon, IC_PHU_TUNG.MS_PT, IC_PHU_TUNG.MS_PT_NCC, IC_PHU_TUNG.MS_PT_CTY, Case @NNgu when 0 then IC_PHU_TUNG.TEN_PT when 1 then isnull(TEN_PT_ANH,IC_PHU_TUNG.TEN_PT) when 2 then ISNULL(TEN_PT_HOA,IC_PHU_TUNG.TEN_PT) end as TEN_PT, IC_PHU_TUNG.TEN_PT_VIET, 
		CASE @NNgu WHEN 0 THEN TEN_1 WHEN 1 THEN TEN_2 ELSE TEN_3 END AS DVT, IC_PHU_TUNG.QUY_CACH, IC_PHU_TUNG.DVT AS DVT1
	FROM         IC_PHU_TUNG INNER JOIN
						  DON_VI_TINH ON IC_PHU_TUNG.DVT = DON_VI_TINH.DVT INNER JOIN
						  IC_PHU_TUNG_LOAI_PHU_TUNG ON IC_PHU_TUNG.MS_PT = IC_PHU_TUNG_LOAI_PHU_TUNG.MS_PT INNER JOIN
						  LOAI_VT ON IC_PHU_TUNG.MS_LOAI_VT = LOAI_VT.MS_LOAI_VT
						  INNER JOIN #LPT_USER X ON X.MS_LOAI_PT = IC_PHU_TUNG_LOAI_PHU_TUNG.MS_LOAI_PT
	WHERE     (IC_PHU_TUNG_LOAI_PHU_TUNG.MS_LOAI_PT = @MS_LOAI_PT OR @MS_LOAI_PT = -1)  AND (LOAI_VT.VAT_TU = 0) 
		AND (ACTIVE_PT = 1)
	ORDER BY IC_PHU_TUNG.MS_PT
		
END
