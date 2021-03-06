
ALTER proc [dbo].[QL_ADD_DON_HANG_NHAP]
	@MS_DH_NHAP_PT nvarchar(14),
	@SO_PHIEU_XN nvarchar(20),
	@GIO datetime,
	@NGAY datetime,
	@MS_KHO int,
	@MS_DANG_NHAP int,
	@NGUOI_NHAP nvarchar(255),
	@NGAY_CHUNG_TU datetime,
	@SO_CHUNG_TU nvarchar(20),
	@DIEM int,
	@DANH_GIA nvarchar(50),
	@GHI_CHU nvarchar(255),
	@LOCK bit,
	@THU_KHO NVARCHAR(50),
	@MS_DDH NVARCHAR(255),
	@DIEM1 INT,
	@DIEM2 INT
AS

IF (@DIEM=-1)
	BEGIN
		SET @DIEM=NULL
	END

IF (@DIEM1=-1)
	BEGIN
		SET @DIEM1 =  NULL
	END

IF (@DIEM2 =-1 )
	BEGIN
		SET @DIEM2 = NULL
	END

INSERT INTO [dbo].[IC_DON_HANG_NHAP]
           ([MS_DH_NHAP_PT]
           ,[SO_PHIEU_XN]
           ,[GIO]
           ,[NGAY]
           ,[MS_KHO]
           ,[MS_DANG_NHAP]
           ,[NGUOI_NHAP]
           ,[NGAY_CHUNG_TU]
           ,[SO_CHUNG_TU]
           ,[DIEM]
           ,[DANH_GIA]
           ,[GHI_CHU]
           ,[LOCK]
           ,THU_KHO,MS_DDH,DIEM1,DIEM2)
     VALUES
           (
			@MS_DH_NHAP_PT,
			@SO_PHIEU_XN,
			@GIO,
			@NGAY,
			@MS_KHO,
			@MS_DANG_NHAP,
			@NGUOI_NHAP,
			@NGAY_CHUNG_TU,
			@SO_CHUNG_TU,
			@DIEM,
			@DANH_GIA,
			@GHI_CHU,
			@LOCK
			,@THU_KHO,@MS_DDH,@DIEM1,@DIEM2)
