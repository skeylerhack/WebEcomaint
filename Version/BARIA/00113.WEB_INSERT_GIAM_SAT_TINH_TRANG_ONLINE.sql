

ALTER PROC [dbo].[WEB_INSERT_GIAM_SAT_TINH_TRANG_ONLINE]
	@NGAY_KT datetime, 
	@GIO_KT datetime, 
	@DEN_GIO datetime, 
	@MS_CONG_NHAN NVARCHAR(50), 
	@GIO_CHAY_MAY FLOAT,
	@NHAN_XET NVARCHAR(MAX),
	@USERNAME NVARCHAR(255),
	@MS_MAY NVARCHAR(255)
AS

insert into GIAM_SAT_TINH_TRANG (NGAY_KT, GIO_KT, DEN_GIO, MS_CONG_NHAN , GIO_CHAY_MAY,NHAN_XET,USERNAME)
VALUES (@NGAY_KT,@GIO_KT,@DEN_GIO,@MS_CONG_NHAN,@GIO_CHAY_MAY,@NHAN_XET,@USERNAME)


 DECLARE @NGUOI_YEU_CAU NVARCHAR(255)
 SET @NGUOI_YEU_CAU  = (SELECT TOP 1 HO + ' ' + TEN FROM CONG_NHAN WHERE MS_CONG_NHAN = @MS_CONG_NHAN)


-- INSERT GIO CHAY MAY
if @GIO_CHAY_MAY >=0 
BEGIN

	--SELECT * FROM THOI_GIAN_CHAY_MAY
	DECLARE @CHI_SO_DONG_HO FLOAT
	DECLARE @SO_GIO_LUY_KE FLOAT

	SELECT TOP 1  @SO_GIO_LUY_KE = SO_GIO_LUY_KE  FROM THOI_GIAN_CHAY_MAY 
	WHERE MS_MAY = @MS_MAY AND NGAY < (@NGAY_KT + @GIO_KT) ORDER BY NGAY DESC

	IF @SO_GIO_LUY_KE IS NULL
	BEGIN
			INSERT INTO THOI_GIAN_CHAY_MAY (MS_MAY, NGAY, CHI_SO_DONG_HO, MS_PBT, SO_MOVEMENT, SO_GIO_LUY_KE,USERNAME) 
			VALUES(@MS_MAY,@NGAY_KT + @GIO_KT,@GIO_CHAY_MAY,'',0,@GIO_CHAY_MAY,@USERNAME)
	END
	ELSE
	BEGIN
		IF @GIO_CHAY_MAY - @SO_GIO_LUY_KE < 0 
		BEGIN
			INSERT INTO THOI_GIAN_CHAY_MAY (MS_MAY, NGAY, CHI_SO_DONG_HO, MS_PBT, SO_MOVEMENT, SO_GIO_LUY_KE,USERNAME) 
			VALUES(@MS_MAY,@NGAY_KT + @GIO_KT,@GIO_CHAY_MAY,'',0,@GIO_CHAY_MAY,@USERNAME)
		END  
		ELSE
			BEGIN
			INSERT INTO THOI_GIAN_CHAY_MAY (MS_MAY, NGAY, CHI_SO_DONG_HO, MS_PBT, SO_MOVEMENT, SO_GIO_LUY_KE,USERNAME) 
			VALUES(@MS_MAY,@NGAY_KT + @GIO_KT,(@GIO_CHAY_MAY - @SO_GIO_LUY_KE),'',0,@GIO_CHAY_MAY,@USERNAME)
			END
	END
END

IF ISNULL(@NHAN_XET,'') <> ''
BEGIN

 DECLARE @MS_YEU_CAU NVARCHAR(100)
 DECLARE @MS_NX_MAY NVARCHAR(100)

 DECLARE @ID_H NVARCHAR (6)
 DECLARE @ID_D DATETIME
 
 SET @ID_H = 'WR'
 SET @ID_D = @NGAY_KT
 
DECLARE @COUNT INT 
SET @COUNT = (SELECT COUNT (*) FROM TB_S_ID T WHERE T.ID_H = @ID_H AND YEAR(ID_D) = YEAR(@ID_D) AND MONTH(ID_D) = MONTH(@ID_D)  )

DECLARE @ID_I INT 
SET @ID_I = (SELECT CASE WHEN MAX (T.ID_I) IS NULL THEN 0 ELSE  MAX (T.ID_I) END  + 1
FROM TB_S_ID T WHERE T.ID_H = @ID_H AND YEAR(ID_D) = YEAR(@ID_D) AND MONTH(ID_D) = MONTH(@ID_D)  )

--DELETE FROM TB_S_ID WHERE ID_H = @ID_H 
if @COUNT = 0 
 INSERT INTO TB_S_ID (ID_H,ID_I,ID_D) VALUES (@ID_H,@ID_I,@ID_D)   
else
 UPDATE TB_S_ID SET ID_I = @ID_I  WHERE ID_H = @ID_H AND YEAR(ID_D) = YEAR(@ID_D) AND MONTH(ID_D) = MONTH(@ID_D) 
 
SET @MS_YEU_CAU = 'WR-' + CONVERT(NVARCHAR(4),YEAR(@NGAY_KT)) + RIGHT('00' + CONVERT(NVARCHAR(4),MONTH(@NGAY_KT)),2) + RIGHT('000000'+ CONVERT(NVARCHAR(20),@ID_I),6)
  
SELECT TOP 1 @MS_NX_MAY = MS_N_XUONG FROM MAY_NHA_XUONG_NGAY_MAX WHERE NGAY_MAX < (@NGAY_KT + @GIO_KT) ORDER BY NGAY_MAX DESC
  
 INSERT INTO dbo.YEU_CAU_NSD (NGAY, GIO_YEU_CAU, NGUOI_YEU_CAU, USER_COMMENT, NGAY_HOAN_THANH, DA_KIEM_TRA, USERNAME, REVIEWER_COMMENT, 
 USER_LAP, EMAIL_NSD, SO_YEU_CAU, MS_YEU_CAU, MS_N_XUONG)
                      VALUES (@NGAY_KT , @GIO_KT , @NGUOI_YEU_CAU,@NHAN_XET,@NGAY_KT,CONVERT(BIT,1),@USERNAME,'',@USERNAME,'',@MS_YEU_CAU,@MS_YEU_CAU,@MS_NX_MAY)

DECLARE @MAX_STT_YC INT
SELECT TOP 1 @MAX_STT_YC = MAX(STT) FROM YEU_CAU_NSD

INSERT INTO  dbo.YEU_CAU_NSD_CHI_TIET  (STT, MS_MAY, MO_TA_TINH_TRANG, YEU_CAU,MS_LOAI_YEU_CAU_BT,MS_NGUYEN_NHAN,MS_UU_TIEN )
VALUES(@MAX_STT_YC , @MS_MAY,N'TD: '+@NHAN_XET,@NHAN_XET,3,100,2 )



UPDATE YEU_CAU_NSD_CHI_TIET SET USERNAME_DSX = 'admin',
 THOI_GIAN_DSX = CONVERT(dATETIME, Convert(nvarchar(10), @NGAY_KT, 101) + ' ' + Convert(nvarchar(8), @GIO_KT, 108))
 , THUC_HIEN_DSX = 1 FROM YEU_CAU_NSD_CHI_TIET WHERE STT = @MAX_STT_YC





END