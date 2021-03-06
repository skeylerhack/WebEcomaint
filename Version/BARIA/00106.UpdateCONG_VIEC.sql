
ALTER proc [dbo].[UpdateCONG_VIEC]
	@MS_CV INT,
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
	@AN_TOAN  bit,
	@DINH_MUC FLOAT,
	@NGOAI_TE NVARCHAR(6),
	@GHI_CHU nvarchar(2000),
	@SO_NGUOI INT,
	@YEU_CAU_NS nvarchar(1000),
	@YEU_CAU_DUNG_CU nvarchar(1000)
AS

UPDATE CONG_VIEC SET
	MS_LOAI_CV=@MS_LOAI_CV ,
	MO_TA_CV=@MO_TA_CV ,
	PATH_HD=@PATH_HD,
	MS_LOAI_MAY=@MS_LOAI_MAY,
	THOI_GIAN_DU_KIEN=@THOI_GIAN_DU_KIEN,
	THAO_TAC=@THAO_TAC,
	TIEU_CHUAN_KT=@TIEU_CHUAN_KT,
	MS_CHUYEN_MON=@MS_CHUYEN_MON,
	MS_BAC_THO=@MS_BAC_THO,
	MA_CV=@MA_CV ,
	KY_HIEU_CV=@KY_HIEU_CV,
	AN_TOAN = @AN_TOAN,
	DINH_MUC =@DINH_MUC,
	NGOAI_TE =@NGOAI_TE,
	GHI_CHU = @GHI_CHU,
	SO_NGUOI = @SO_NGUOI ,
	YEU_CAU_NS = @YEU_CAU_NS ,
	YEU_CAU_DUNG_CU = @YEU_CAU_DUNG_CU
WHERE
	MS_CV=@MS_CV


update PHIEU_BAO_TRI_CONG_VIEC 
set THAO_TAC = @THAO_TAC
where MS_CV = @MS_CV 
