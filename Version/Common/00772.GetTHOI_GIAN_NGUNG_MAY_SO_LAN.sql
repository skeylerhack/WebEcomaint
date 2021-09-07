
ALTER procedure [dbo].[GetTHOI_GIAN_NGUNG_MAY_SO_LAN]
	@USERNAME NVARCHAR(50),
	@MS_MAY NVARCHAR(30),
	@LOAI_MAY NVARCHAR(30),
	@MS_HETHONG NVARCHAR(30),
	@MS_NHA_XUONG NVARCHAR(30),
	@MS_NGUYENNHAN NVARCHAR(30),
	@TU_NGAY Datetime,
	@DEN_NGAY Datetime,
	@LockTGNM bit
 AS

BEGIN

if @MS_MAY = ''
	set @MS_MAY = '-1'
if @TU_NGAY is null OR  @TU_NGAY  = '' set @TU_NGAY = DATEADD (YEAR,-1,GETDATE())
if @DEN_NGAY is null OR  @DEN_NGAY  = '' set @DEN_NGAY = DATEADD (YEAR,1,GETDATE())

SELECT DISTINCT * INTO #MAY_USER FROM dbo.MGetMayUserNgay(@DEN_NGAY,@USERNAME,@MS_NHA_XUONG,@MS_HETHONG,-1,-1,'-1',@MS_MAY,0)  A 
	


SELECT DISTINCT 
                      X.MS_MAY, X.MS_LAN, X.NGAY, X.TU_GIO, X.NGUOI_GIAI_QUYET, X.NGUYEN_NHAN AS NN_CGQ, X.MS_NGUYEN_NHAN, X.MS_PHIEU_BAO_TRI, X.HIEN_TUONG, X.NGUYEN_NHAN_CU_THE, 
                      X.NGAY_KT, X.GIO_KT, T1.TEN_NGUYEN_NHAN
                      , X.NGAY_SX, B.MS_LOAI_MAY, x.TRUONG_CA, x.CaID , CONVERT(DATETIME, CONVERT(NVARCHAR(10), X.NGAY, 101) + ' '+ CONVERT(NVARCHAR(8), X.TU_GIO, 108)) AS TNGAY_GIO, CONVERT(DATETIME, CONVERT(NVARCHAR(10), X.NGAY_KT, 101) + ' '+ CONVERT(NVARCHAR(8), X.GIO_KT, 108)) AS DNGAY_GIO 
FROM         #MAY_USER AS B INNER JOIN
                      dbo.THOI_GIAN_NGUNG_MAY_SO_LAN AS X ON B.MS_MAY = X.MS_MAY
                      LEFT JOIN NGUYEN_NHAN_DUNG_MAY T1 ON X.MS_NGUYEN_NHAN=T1.MS_NGUYEN_NHAN
					  INNER JOIN dbo.NHOM_MAY C ON B.MS_LOAI_MAY=C.MS_LOAI_MAY
WHERE     CONVERT(DATE, CONVERT(NVARCHAR(10), X.NGAY, 101))
 BETWEEN convert(date,@TU_NGAY) AND convert(date,@DEN_NGAY)
AND (X.MS_NGUYEN_NHAN = @MS_NGUYENNHAN OR @MS_NGUYENNHAN  = '-1') 
AND (ISNULL(X.LOCK,0) = @LockTGNM) 
  AND '1'=(CASE WHEN @LOAI_MAY='-1' THEN 1 WHEN @LOAI_MAY<>'-1' AND C.MS_LOAI_MAY =@LOAI_MAY THEN '1' ELSE '0' END)                   
ORDER BY X.MS_MAY, X.MS_LAN, X.NGAY DESC, X.TU_GIO, X.NGUOI_GIAI_QUYET


END


