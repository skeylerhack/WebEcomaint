
UPDATE PHIEU_BAO_TRI 
SET NGAY_HONG = NULL
WHERE MS_PHIEU_BAO_TRI IN (
SELECT MS_PHIEU_BAO_TRI FROM PHIEU_BAO_TRI WHERE GIO_HONG  is null and  NGAY_HONG is not null and TINH_TRANG_PBT < 3
and MS_PHIEU_BAO_TRI not in (SELECT MS_PHIEU_BAO_TRI FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU ) )

UPDATE PHIEU_BAO_TRI 
SET DEN_NGAY_HONG = NULL
WHERE MS_PHIEU_BAO_TRI IN (
SELECT MS_PHIEU_BAO_TRI FROM PHIEU_BAO_TRI WHERE DEN_GIO_HONG  is null and  DEN_NGAY_HONG is not null and TINH_TRANG_PBT < 3
and MS_PHIEU_BAO_TRI not in (SELECT MS_PHIEU_BAO_TRI FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU ) )