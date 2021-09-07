
----exec GetYEU_CAU_NSD '-1','12/01/2020','12/30/2020',1,'maint1',0
ALTER procedure [dbo].[GetYEU_CAU_NSD] 
	@NGUOI_YEU_CAU NVARCHAR(50) = 'admin',
	@TU_NGAY_TMP NVARCHAR(10),
	@DEN_NGAY_TMP  NVARCHAR(10),
	@iLoai int,
	@USERNAME NVARCHAR(50), 
	@NNgu int
AS
DECLARE @TU_NGAY DATETIME
DECLARE @DEN_NGAY DATETIME
IF  @TU_NGAY_TMP='  /  /' 
	SET @TU_NGAY=NULL
ELSE
	SET @TU_NGAY=CONVERT(DATETIME, @TU_NGAY_TMP)
IF  @DEN_NGAY_TMP='  /  /' 
	SET @DEN_NGAY=NULL
ELSE
	SET @DEN_NGAY=CONVERT(DATETIME, @DEN_NGAY_TMP)
	
IF @NGUOI_YEU_CAU = ''
	SET @NGUOI_YEU_CAU = '-1'
IF @USERNAME = ''
	SET @USERNAME = 'admin'
	
SELECT T1.MS_N_XUONG , 
CASE @NNgu WHEN 0 THEN T2.Ten_N_XUONG WHEN 1 THEN ISNULL(NULLIF(T2.TEN_N_XUONG_A,''),T2.Ten_N_XUONG) ELSE ISNULL(NULLIF(T2.TEN_N_XUONG_H,''),T2.Ten_N_XUONG) END AS Ten_N_XUONG
INTO  #NX_TMP FROM [dbo].[MGetNhaXuongDiaDiem]('-1','-1','-1' ,@USERNAME)  T1 INNER JOIN dbo.NHA_XUONG T2 ON T1.MS_N_XUONG = T2.MS_N_XUONG

SELECT * FROM YEU_CAU_NSD ORDER BY MS_YEU_CAU DESC	
SELECT DISTINCT A.STT, A.MS_YEU_CAU, A.SO_YEU_CAU, DBO.GetMayYeuCauSuDung(A.STT,@NNgu,1) AS TEN_MAY,

A.NGAY, A.GIO_YEU_CAU, A.NGUOI_YEU_CAU, A.USER_COMMENT, A.NGAY_HOAN_THANH, A.DA_KIEM_TRA,
A.USERNAME, A.REVIEWER_COMMENT, A.USER_LAP, A.EMAIL_NSD, A.MS_N_XUONG, Ten_N_XUONG,CONVERT( BIT, THUC_HIEN_DSX) AS THUC_HIEN_DSX

FROM         dbo.YEU_CAU_NSD AS A LEFT	 JOIN 
                      #NX_TMP AS NX ON A.MS_N_XUONG = NX.MS_N_XUONG INNER JOIN 
					  (SELECT DISTINCT STT,  MIN(ISNULL(CONVERT(INT,THUC_HIEN_DSX),0)) AS THUC_HIEN_DSX FROM YEU_CAU_NSD_CHI_TIET  GROUP BY STT) X ON A.STT = X.STT
WHERE     (A.NGAY BETWEEN ISNULL(@TU_NGAY, '20000101') AND ISNULL(@DEN_NGAY, '20990101')) AND (A.NGUOI_YEU_CAU = @NGUOI_YEU_CAU) OR
                      (A.NGAY BETWEEN ISNULL(@TU_NGAY, '20000101') AND ISNULL(@DEN_NGAY, '20990101')) AND (@NGUOI_YEU_CAU = '-1') 
					  AND (A.DUYET =@iLoai OR @iLoai =-1)
ORDER BY A.STT DESC 