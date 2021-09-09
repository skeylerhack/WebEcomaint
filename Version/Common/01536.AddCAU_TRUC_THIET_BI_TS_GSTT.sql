ALTER procedure [dbo].[AddCAU_TRUC_THIET_BI_TS_GSTT]
	@MS_MAY NVARCHAR(50),
	@MS_BO_PHAN NVARCHAR(50),
	@MS_TS_GSTT NVARCHAR(50),
	@MS_TT int,
	@TEN_GT NVARCHAR(150),
	@GIA_TRI_TREN FLOAT,
	@GIA_TRI_DUOI FLOAT,
	@CHU_KY_DO INT,
	@MS_DV_TG INT,
	@LOAI_TS BIT,
	@DAT BIT,
	@MS_UU_TIEN INT,
	@GHI_CHU NVARCHAR(250),
	@ACTIVE BIT,
	@THOI_GIAN FLOAT = 0,
	@CACH_THUC_HIEN NVARCHAR(2000) = '',
	@TIEU_CHUAN_KT NVARCHAR(2000) = '',
	@YEU_CAU_NS NVARCHAR(2000) = '',
	@YEU_CAU_DUNG_CU NVARCHAR(2000) = '',
	@PATH_HD NVARCHAR(2000) = ''
AS
IF @LOAI_TS=1
INSERT CAU_TRUC_THIET_BI_TS_GSTT
(
	MS_MAY,
	MS_BO_PHAN,
	MS_TS_GSTT,
	MS_TT,
	TEN_GT,
	GIA_TRI_TREN,
	GIA_TRI_DUOI,
	CHU_KY_DO,
	MS_DV_TG,
	ACTIVE, THOI_GIAN, CACH_THUC_HIEN,
	TIEU_CHUAN_KT,YEU_CAU_NS,YEU_CAU_DUNG_CU,PATH_HD,
	MS_UU_TIEN,GHI_CHU
)
VALUES
(
	@MS_MAY,
	@MS_BO_PHAN,
	@MS_TS_GSTT,
	1,
	@TEN_GT,
	NULL,
	NULL,
	@CHU_KY_DO,
	@MS_DV_TG,
	@ACTIVE, @THOI_GIAN, @CACH_THUC_HIEN,
	@TIEU_CHUAN_KT,@YEU_CAU_NS,@YEU_CAU_DUNG_CU,@PATH_HD,
	@MS_UU_TIEN,@GHI_CHU
)
ELSE
INSERT CAU_TRUC_THIET_BI_TS_GSTT
(
	MS_MAY,
	MS_BO_PHAN,
	MS_TS_GSTT,
	MS_TT,
	TEN_GT,
	GIA_TRI_TREN,
	GIA_TRI_DUOI,
	CHU_KY_DO,
	MS_DV_TG,
	DAT,
	GHI_CHU,
	ACTIVE , THOI_GIAN, CACH_THUC_HIEN,
	TIEU_CHUAN_KT,YEU_CAU_NS,YEU_CAU_DUNG_CU,PATH_HD 
)
VALUES
(
	@MS_MAY,
	@MS_BO_PHAN,
	@MS_TS_GSTT,
	@MS_TT,
	@TEN_GT,
	@GIA_TRI_TREN,
	@GIA_TRI_DUOI,
	@CHU_KY_DO,
	@MS_DV_TG,
	@DAT,
	@GHI_CHU,
	@ACTIVE , @THOI_GIAN, @CACH_THUC_HIEN,
	@TIEU_CHUAN_KT,@YEU_CAU_NS,@YEU_CAU_DUNG_CU,@PATH_HD 
)