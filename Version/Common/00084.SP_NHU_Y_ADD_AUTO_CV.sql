
--SELECT * FROM PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI ='WO-201111002'
ALTER PROC [dbo].[SP_NHU_Y_ADD_AUTO_CV]
    @MS_PHIEU_BAO_TRI NVARCHAR(20),
	@MS_CV INT,
	@MS_BO_PHAN NVARCHAR(50),
	@SO_GIO_KH FLOAT,
	@SO_GIO_PB FLOAT,
	@DINH_MUC_PB FLOAT,
	@SO_NGUOI	int	,
	@YEU_CAU_NS	nvarchar(1000),
	@YEU_CAU_DUNG_CU	nvarchar(1000)
AS
INSERT INTO PHIEU_BAO_TRI_CONG_VIEC
(
	MS_PHIEU_BAO_TRI,
	MS_CV,
	MS_BO_PHAN,
	SO_GIO_KH,
	SO_GIO_PB,
	DINH_MUC_PB,
	SO_NGUOI,YEU_CAU_NS,YEU_CAU_DUNG_CU
	

)
VALUES
(
    @MS_PHIEU_BAO_TRI,
	@MS_CV,
	@MS_BO_PHAN,
	@SO_GIO_KH,
	@SO_GIO_PB,
	@DINH_MUC_PB,
	@SO_NGUOI,@YEU_CAU_NS,@YEU_CAU_DUNG_CU
)
