
ALTER PROC [dbo].[spAddNAV_REQUEST_SERVICE]
	@ID_PSDV_NHOM bigint,
	@MS_YEU_CAU	nvarchar(20),
	@GL_ACC	nvarchar(50) ,
	@MO_TA_SERVICE	nvarchar(255) ,
	@SER_GROUP_CODE	nvarchar(50) ,
	@SO_LUONG	float ,
	@MS_CONG_NHAN	nvarchar(9),
	@NGAY_YEU_CAU	nvarchar(30),
	@MS_PHIEU_BAO_TRI	nvarchar(255)
AS

INSERT INTO NAV_REQUEST_SERVICE (ID_PSDV_NHOM,[MS_YEU_CAU],[GL_ACC],[MO_TA_SERVICE],[SER_GROUP_CODE],[SO_LUONG],[MS_CONG_NHAN],
	[NGAY_YEU_CAU],[MS_PHIEU_BAO_TRI],[INSERT_DATE],[STATUS]) 
 VALUES (@ID_PSDV_NHOM, @MS_YEU_CAU,@GL_ACC,@MO_TA_SERVICE,@SER_GROUP_CODE,@SO_LUONG,@MS_CONG_NHAN,
	CONVERT(DATETIME,@NGAY_YEU_CAU,121),@MS_PHIEU_BAO_TRI,CONVERT(DATETIME,GETDATE(),121), 'N' )
 
