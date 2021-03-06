

ALTER PROC [dbo].[spKiemNgiemThu]
	@PBT NVARCHAR(100) = 'WO-201807000509'
AS
DECLARE @PBT_THEO_GIO NVARCHAR(100) = 1
	--0 : Nhập từ ngày, đến ngày, từ giờ đến giờ , tính ra số giờ và lock cột số giờ.
	--1 : Nhập từ ngày, đến ngày, từ giờ đến giờ , tính ra số giờ, nhưng có thể chỉnh sửa số giờ. 
	--2 : Nhập Từ ngày, từ giờ, Đến ngày đến giờ và nhập cả số giờ độc lập. Trong trường hợp này, đến giờ - từ giờ <> số giờ. Lúc này không bắt buộc nhập từ ngày đến ngày.
	SELECT TOP 1 COUNT(*) FROM (
SELECT MS_PHIEU_BAO_TRI,MS_CV,MS_BO_PHAN,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET  WHERE MS_PHIEU_BAO_TRI = @PBT
UNION
SELECT MS_PHIEU_BAO_TRI,STT,NULL,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO WHERE MS_PHIEU_BAO_TRI = @PBT
UNION
SELECT MS_PHIEU_BAO_TRI,STT,NULL,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_NHAN_SU WHERE MS_PHIEU_BAO_TRI = @PBT
) T WHERE SO_GIO > 0
