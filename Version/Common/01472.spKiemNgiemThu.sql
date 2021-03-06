


ALTER PROC [dbo].[spKiemNgiemThu]
	@PBT NVARCHAR(100) = 'WO-201901000013'
AS
DECLARE @PBT_THEO_GIO NVARCHAR(100) = 1
	--0 : Nhập từ ngày, đến ngày, từ giờ đến giờ , tính ra số giờ và lock cột số giờ.
	--1 : Nhập từ ngày, đến ngày, từ giờ đến giờ , tính ra số giờ, nhưng có thể chỉnh sửa số giờ. 
	--2 : Nhập Từ ngày, từ giờ, Đến ngày đến giờ và nhập cả số giờ độc lập. Trong trường hợp này, đến giờ - từ giờ <> số giờ. Lúc này không bắt buộc nhập từ ngày đến ngày.

-- Kiểm tra nếu chỉ có mỗi DV cho NT luôn @iCoDV = 1
DECLARE @iCoDV INT = 0
SELECT @iCoDV = SUM(LOAI)  FROM (
	SELECT TOP 1 MS_PHIEU_BAO_TRI,1 AS LOAI  FROM dbo.PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI = @PBT AND ISNULL(STT_SERVICE,'') <> ''
	UNION
	SELECT TOP 1 MS_PHIEU_BAO_TRI,2 AS LOAI FROM dbo.PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI = @PBT AND ISNULL(STT_SERVICE,'') = ''
) T1

SELECT TOP 1 CASE 
WHEN @iCoDV > 1 THEN
COUNT(*) 
ELSE 1 END  FROM (
SELECT MS_PHIEU_BAO_TRI,MS_CV,MS_BO_PHAN,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET  WHERE MS_PHIEU_BAO_TRI = @PBT
UNION
SELECT MS_PHIEU_BAO_TRI,STT,NULL,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO WHERE MS_PHIEU_BAO_TRI = @PBT
UNION
SELECT MS_PHIEU_BAO_TRI,STT,NULL,MS_CONG_NHAN,SO_GIO FROM PHIEU_BAO_TRI_NHAN_SU WHERE MS_PHIEU_BAO_TRI = @PBT
) T WHERE SO_GIO > 0
