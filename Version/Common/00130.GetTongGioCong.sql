--EXEC GetTongGioCong 'WO-201510000008',1

ALTER procedure [dbo].[GetTongGioCong]
	@MS_PHIEU_BAO_TRI NVARCHAR(50),
	@TINH_TRANG_PBT INT
AS
--IF @TINH_TRANG_PBT=3 OR @TINH_TRANG_PBT=4 OR @TINH_TRANG_PBT=5
SELECT ISNULL(SUM(SO_GIO),0)*60 FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET
	WHERE MS_PHIEU_BAO_TRI=@MS_PHIEU_BAO_TRI
UNION
SELECT ISNULL(SUM(SO_GIO),0)*60 FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO
	WHERE MS_PHIEU_BAO_TRI=@MS_PHIEU_BAO_TRI


