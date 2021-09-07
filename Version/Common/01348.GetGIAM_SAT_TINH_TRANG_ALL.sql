
-- EXEC GetGIAM_SAT_TINH_TRANG_ALL '01/01/2011', '11/01/2019','-1'
ALTER proc [dbo].[GetGIAM_SAT_TINH_TRANG_ALL]
	@TU_NGAY datetime,
	@DEN_NGAY	datetime,
	@MS_CONG_NHAN	NVARCHAR(50)
	
AS

	SELECT     STT, SO_PHIEU, NGAY_KH, NGAY_KT,GIO_KT,  
                      T.HO + ' ' + T.TEN AS HO_TEN, T.MS_CONG_NHAN,DEN_GIO,
                      dbo.GetMSMayGSTT(STT) AS MS_MAY ,dbo.GettenMayGSTT(STT) AS TEN_MAY , NHAN_XET
	FROM         GIAM_SAT_TINH_TRANG LEFT JOIN
	                      CONG_NHAN T ON T.MS_CONG_NHAN = GIAM_SAT_TINH_TRANG.MS_CONG_NHAN 
	WHERE (CONVERT(DATE,NGAY_KT) BETWEEN CONVERT(DATE,@TU_NGAY) AND  CONVERT(DATE,@DEN_NGAY)) 
		AND (T.MS_CONG_NHAN = @MS_CONG_NHAN OR @MS_CONG_NHAN = '-1')
	ORDER BY NGAY_KT DESC ,GIO_KT DESC 
		
		