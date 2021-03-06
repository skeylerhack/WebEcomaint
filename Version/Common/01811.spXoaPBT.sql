

ALTER PROC [dbo].[spXoaPBT]
	@MS_PHIEU_BAO_TRI AS NVARCHAR(50)
AS
BEGIN



DELETE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CV_PHU_TRO_NHAN_SU WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CV_PHU_TRO WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI

DELETE PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_DANH_GIA_SERVICE WHERE  MS_PBT= @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_HINH WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_TINH_TRANG_CHI_TIET WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_TINH_TRANG WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_SERVICE WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CLASS WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CHI_PHI WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
DELETE PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI

END