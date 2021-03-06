

ALTER proc [dbo].[Add_Work]
	@MS_LOAI_CV smallint,
	@MO_TA_CV nvarchar(255),
	@PATH_HD nvarchar(250),
	@MS_LOAI_MAY nvarchar(20),
	@THOI_GIAN_DU_KIEN REAL,
	@THAO_TAC nvarchar(2000),
	@TIEU_CHUAN_KT nvarchar(2000),
	@MS_CHUYEN_MON INT,
	@MS_BAC_THO INT,
	@MA_CV NVARCHAR(100),
	@KY_HIEU_CV NVARCHAR(100),
	@AN_TOAN bit,
	@DINH_MUC FLOAT,
	@NGOAI_TE NVARCHAR(6),
    @GHI_CHU NVARCHAR(2000),
    @MS_CV INT,
	@SO_NGUOI INT,
	@YEU_CAU_NS nvarchar(1000),
	@YEU_CAU_DUNG_CU nvarchar(1000)

AS
if(@MS_CHUYEN_MON=0)
	SET @MS_CHUYEN_MON=NULL
	
if(@MS_BAC_THO<>0)
begin
	INSERT INTO CONG_VIEC (
		MS_LOAI_CV ,
		MO_TA_CV ,
		PATH_HD ,
		MS_LOAI_MAY ,
		THOI_GIAN_DU_KIEN ,
		THAO_TAC ,
		TIEU_CHUAN_KT ,
		MS_CHUYEN_MON ,
		MS_BAC_THO ,
		MA_CV ,
		KY_HIEU_CV,
		AN_TOAN,
		DINH_MUC,
		NGOAI_TE,
		GHI_CHU,
		MS_CV ,
		SO_NGUOI,
		YEU_CAU_NS,
		YEU_CAU_DUNG_CU
	)
	values (
		@MS_LOAI_CV ,
		@MO_TA_CV ,
		@PATH_HD ,
		@MS_LOAI_MAY ,
		@THOI_GIAN_DU_KIEN ,
		@THAO_TAC ,
		@TIEU_CHUAN_KT ,
		@MS_CHUYEN_MON ,
		@MS_BAC_THO ,
		@MA_CV ,
		@KY_HIEU_CV,
		@AN_TOAN,
		@DINH_MUC,
		@NGOAI_TE,
		@GHI_CHU,
		@MS_CV ,
		@SO_NGUOI,
		@YEU_CAU_NS,
		@YEU_CAU_DUNG_CU
	)
end
else
begin
INSERT INTO CONG_VIEC (
	MS_LOAI_CV ,
	MO_TA_CV ,
	PATH_HD ,
	MS_LOAI_MAY ,
	THOI_GIAN_DU_KIEN ,
	THAO_TAC ,
	TIEU_CHUAN_KT ,
	MS_CHUYEN_MON ,
	MA_CV ,
	KY_HIEU_CV,
	AN_TOAN,
	DINH_MUC,
	NGOAI_TE,
    GHI_CHU,
    MS_CV ,
	SO_NGUOI,
	YEU_CAU_NS,
	YEU_CAU_DUNG_CU
)
values (
	@MS_LOAI_CV ,
	@MO_TA_CV ,
	@PATH_HD ,
	@MS_LOAI_MAY ,
	@THOI_GIAN_DU_KIEN ,
	@THAO_TAC ,
	@TIEU_CHUAN_KT ,
	@MS_CHUYEN_MON ,
	@MA_CV ,
	@KY_HIEU_CV,
	@AN_TOAN,
	@DINH_MUC,
	@NGOAI_TE,
	@GHI_CHU,
	@MS_CV ,
	@SO_NGUOI,
	@YEU_CAU_NS,
	@YEU_CAU_DUNG_CU
)
end
