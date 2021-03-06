
--EXEC GetKE_HOACH_THUC_HIEN_DA_HT 'ADCCD002', '07/01/2015', '09/01/2015'
ALTER proc [dbo].[GetKE_HOACH_THUC_HIEN_DA_HT]
	@MS_CONG_NHAN nvarchar(9),
	@TuNGAY datetime,
	@DenNGAY datetime
AS
SELECT STT,TEN_CONG_VIEC,THOI_GIAN_DK,TU_GIO,NGAY,DEN_GIO,THOI_HAN,
CASE ISNULL(TU_GIO,'') WHEN '' THEN SPHUT ELSE
	DATEDIFF(MINUTE,CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),ISNULL(TU_GIO,'00:00:00'),108)) ,
	CONVERT(DATETIME,CONVERT(NVARCHAR(10),THOI_HAN,101) + ' ' + CONVERT(NVARCHAR(10),ISNULL(DEN_GIO,'00:00:00'),108))) END AS SPHUT,
	GHI_CHU,MUC_UU_TIEN.MS_UU_TIEN AS UU_TIEN,DA_XONG,USER_LAST,THOI_GIAN_SUA,PREVIOUS_USER,
	MS_CONG_NHAN AS MSCN_OLD,NGAY AS NGAY_OLD, STT AS STT_OLD
FROM KE_HOACH_THUC_HIEN LEFT JOIN MUC_UU_TIEN ON KE_HOACH_THUC_HIEN.MS_UU_TIEN = MUC_UU_TIEN.MS_UU_TIEN
WHERE (MS_CONG_NHAN = @MS_CONG_NHAN OR @MS_CONG_NHAN = '-1') AND (NGAY BETWEEN @TuNGAY and DateAdd(day,1, @DenNGAY )) AND (DA_XONG = 1)
ORDER BY THOI_GIAN_SUA, STT


