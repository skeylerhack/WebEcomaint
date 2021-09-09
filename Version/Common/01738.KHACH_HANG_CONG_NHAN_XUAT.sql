
ALTER VIEW [dbo].[KHACH_HANG_CONG_NHAN_XUAT]
AS
SELECT     MS_KH NGUOI_NHAP, TEN_CONG_TY TEN_NGUOI_NHAP, 2 AS MS_DANG_XUAT
FROM         KHACH_HANG
UNION
SELECT     MS_KH NGUOI_NHAP, TEN_CONG_TY TEN_NGUOI_NHAP, 1 AS MS_DANG_XUAT
FROM         KHACH_HANG
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 1 AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 2AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 4 AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 5 AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 6 AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
UNION
SELECT     MS_KH NGUOI_NHAP, TEN_CONG_TY TEN_NGUOI_NHAP, 3 AS MS_DANG_XUAT
FROM         KHACH_HANG
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 3 AS MS_DANG_XUAT
FROM         CONG_NHAN
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 8 AS MS_DANG_XUAT
FROM         CONG_NHAN
UNION
SELECT     MS_CONG_NHAN NGUOI_NHAP, HO + ' ' + TEN TEN_NGUOI_NHAP, 9 AS MS_DANG_XUAT
FROM         CONG_NHAN
WHERE     NGAY_NGHI_VIEC IS NULL
GO

