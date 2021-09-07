-- EXEC GetGIAM_SAT_TINH_TRANG_ALL '01/01/2011', '11/01/2016','-1'
ALTER proc [dbo].[GetGIAM_SAT_TINH_TRANG_ALL]
	@TU_NGAY NVARCHAR(10),
	@DEN_NGAY	NVARCHAR(10),
	@MS_CONG_NHAN	NVARCHAR(50)
	
AS
	DECLARE @TU_NGAY_TMP DATETIME
	DECLARE @DEN_NGAY_TMP	DATETIME
	SET @TU_NGAY_TMP = CONVERT(DATETIME,@TU_NGAY,103)
	SET @DEN_NGAY_TMP =DateAdd(day,1, CONVERT(DATETIME,@DEN_NGAY,103))

	SELECT     GIAM_SAT_TINH_TRANG.STT, GIAM_SAT_TINH_TRANG.NGAY_KT,GIAM_SAT_TINH_TRANG.GIO_KT,  
                      CONG_NHAN.HO + ' ' + CONG_NHAN.TEN AS HO_TEN,GIAM_SAT_TINH_TRANG.MS_CONG_NHAN,DEN_GIO,
                      dbo.GetMSMayGSTT(STT) AS MS_MAY ,dbo.GettenMayGSTT(STT) AS TEN_MAY 
	FROM         GIAM_SAT_TINH_TRANG LEFT JOIN
	                      CONG_NHAN ON GIAM_SAT_TINH_TRANG.MS_CONG_NHAN = CONG_NHAN.MS_CONG_NHAN 
	WHERE (NGAY_KT BETWEEN @TU_NGAY_TMP AND  @DEN_NGAY_TMP) 
		AND (CONG_NHAN.MS_CONG_NHAN = @MS_CONG_NHAN OR @MS_CONG_NHAN = '-1')
	ORDER BY GIAM_SAT_TINH_TRANG.NGAY_KT DESC ,GIAM_SAT_TINH_TRANG.GIO_KT DESC 
		
		
