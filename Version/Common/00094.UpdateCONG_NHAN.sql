

ALTER proc [dbo].[UpdateCONG_NHAN]
	@MS_CONG_NHAN nvarchar(9),
	@HO nvarchar(50),
	@TEN nvarchar(50),
	@NGAY_SINH_Tmp nvarchar(20),
	@NOI_SINH nvarchar(255),
	@PHAI BIT,
	@DIA_CHI_THUONG_TRU nvarchar(100),
	@SO_CMND nvarchar(10),
	@NGAY_CAP_Tmp nvarchar(20),
	@NOI_CAP nvarchar(50),
	@MS_TO_tmp INT,
	@NGAY_VAO_LAM_Tmp nvarchar(20),
	@BO_VIEC INT,
	@NGAY_NGHI_VIEC_Tmp nvarchar(20),
	@LY_DO_NGHI nvarchar(255),
	@MS_TRINH_DO_tmp SMALLINT,
	@NGOAI_NGU nvarchar(20),
	@Hinh_CN nvarchar(255),
	@GHI_CHU nvarchar(255),
	@MS_THE_CC nvarchar(9),
	@SO_DT_NHA_RIENG nvarchar(15),
	@SO_DTDD nvarchar(15),
	@TEN_NGUOI_THAN nvarchar(50),
	@QUAN_HE nvarchar(50),
	@BANG_CAP nvarchar(255),
	@MS_CN_TMP nvarchar(9),
	@USER_MAIL NVARCHAR(150)
AS
declare @NGAY_SINH DATETIME
declare @NGAY_CAP DATETIME
declare @NGAY_VAO_LAM DATETIME
declare @NGAY_NGHI_VIEC DATETIME
declare @MS_TRINH_DO SMALLINT
declare @MS_TO INT

if @NGAY_SINH_Tmp!=''
	set @NGAY_SINH=convert(datetime,@NGAY_SINH_Tmp,103)
else
	set @NGAY_SINH=null

if @NGAY_CAP_Tmp != ''
	set @NGAY_CAP=convert(datetime,@NGAY_CAP_Tmp,103)
else
	set @NGAY_CAP=null

if @NGAY_VAO_LAM_Tmp != ''
	set @NGAY_VAO_LAM=convert(datetime,@NGAY_VAO_LAM_Tmp,103)
else
	set @NGAY_VAO_LAM=null

if @NGAY_NGHI_VIEC_Tmp!=''
	set @NGAY_NGHI_VIEC=convert(datetime,@NGAY_NGHI_VIEC_Tmp,103)
else
	set @NGAY_NGHI_VIEC=null

if @MS_TRINH_DO_tmp = 0 
	set @MS_TRINH_DO= null
else
	set @MS_TRINH_DO=@MS_TRINH_DO_tmp

if @MS_TO_tmp=0
	set @MS_TO=null
else
	set @MS_TO=@MS_TO_tmp

UPDATE CONG_NHAN SET
	MS_CONG_NHAN=@MS_CONG_NHAN,
	HO=@HO,
	TEN=@TEN,
	NGAY_SINH=@NGAY_SINH,
	NOI_SINH=@NOI_SINH,
	PHAI=@PHAI,
	DIA_CHI_THUONG_TRU=@DIA_CHI_THUONG_TRU,
	SO_CMND=@SO_CMND,
	NGAY_CAP=@NGAY_CAP,
	NOI_CAP=@NOI_CAP,
	MS_TO=@MS_TO,
	NGAY_VAO_LAM=@NGAY_VAO_LAM,
	BO_VIEC=@BO_VIEC,
	NGAY_NGHI_VIEC=@NGAY_NGHI_VIEC,
	LY_DO_NGHI=@LY_DO_NGHI,
	MS_TRINH_DO=@MS_TRINH_DO,
	NGOAI_NGU=@NGOAI_NGU,
	Hinh_CN=@Hinh_CN,
	GHI_CHU=@GHI_CHU,
	MS_THE_CC=@MS_THE_CC,
	SO_DT_NHA_RIENG=@SO_DT_NHA_RIENG,
	SO_DTDD=@SO_DTDD,
	TEN_NGUOI_THAN=@TEN_NGUOI_THAN,
	QUAN_HE=@QUAN_HE,
	BANG_CAP=@BANG_CAP,
	USER_MAIL = @USER_MAIL
WHERE
	MS_CONG_NHAN=@MS_CN_TMP


