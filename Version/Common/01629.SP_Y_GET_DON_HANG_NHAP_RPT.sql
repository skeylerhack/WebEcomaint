
ALTER procedure [dbo].[SP_Y_GET_DON_HANG_NHAP_RPT]
@MS_DH_NHAP_PT NVARCHAR (14) = 'PN-2102-0001',
@LANGUAGE INT  = 0
AS
BEGIN
	SELECT     dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT, dbo.IC_DON_HANG_NHAP.SO_PHIEU_XN, dbo.IC_DON_HANG_NHAP.GIO, 
	dbo.IC_DON_HANG_NHAP.NGAY, dbo.IC_DON_HANG_NHAP.MS_KHO, dbo.IC_DON_HANG_NHAP.MS_DANG_NHAP, 
	dbo.IC_DON_HANG_NHAP.NGUOI_NHAP, dbo.IC_DON_HANG_NHAP.NGAY_CHUNG_TU, dbo.IC_DON_HANG_NHAP.SO_CHUNG_TU, 
	dbo.IC_DON_HANG_NHAP.DIEM, dbo.IC_DON_HANG_NHAP.DANH_GIA, dbo.IC_DON_HANG_NHAP.GHI_CHU, dbo.IC_DON_HANG_NHAP.LOCK, 
	dbo.IC_DON_HANG_NHAP.STT, dbo.IC_DON_HANG_NHAP.DA_HET, dbo.IC_DON_HANG_NHAP.THU_KHO, dbo.IC_DON_HANG_NHAP.MS_DDH, 
	dbo.IC_DON_HANG_NHAP.SO_DE_XUAT, dbo.IC_DON_HANG_NHAP.NGUOI_GIAO, dbo.IC_DON_HANG_NHAP.BSXE, dbo.IC_DON_HANG_NHAP.DIEM1, 
	dbo.IC_DON_HANG_NHAP.DIEM2,
	CASE ISNULL(MS_VT_NCC,'') WHEN '' then  dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT ELSE MS_VT_NCC END AS MS_PT,
	CASE ISNULL(TEN_PT_CT,'') WHEN '' then  TEN_PT ELSE TEN_PT_CT END AS TEN_PT,
	 dbo.IC_PHU_TUNG.MS_PT_NCC, 
	dbo.IC_PHU_TUNG.QUY_CACH,  CASE @LANGUAGE WHEN 1 THEN dbo.DON_VI_TINH.TEN_2 WHEN 2 THEN dbo.DON_VI_TINH.TEN_3 ELSE dbo.DON_VI_TINH.TEN_1 END AS DVT, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.SO_LUONG_CTU, dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA, dbo.IC_DON_HANG_NHAP_VAT_TU.NGOAI_TE, dbo.NGOAI_TE.TEN_NGOAI_TE, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA, dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA_USD, dbo.IC_DON_HANG_NHAP_VAT_TU.MS_VT_NCC, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.BAO_HANH_DEN_NGAY, dbo.IC_DON_HANG_NHAP_VAT_TU.SL_DA_SD, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.XUAT_XU, dbo.IC_DON_HANG_NHAP_VAT_TU.GHI_CHU AS GHI_CHU_CT, 
	dbo.IC_DON_HANG_NHAP_VAT_TU.THANH_TIEN, dbo.IC_KHO.TEN_KHO,CASE @LANGUAGE WHEN 1 THEN dbo.DANG_NHAP.DANG_NHAP_ANH WHEN 2 THEN dbo.DANG_NHAP.DANG_NHAP_HOA ELSE dbo.DANG_NHAP.DANG_NHAP_VIET END AS TEN_DANG_NHAP,
	TMP.TEN_NGUOI_NHAP, IC_DON_HANG_NHAP.NGUOI_LAP, MS_PT_CTY
	FROM         dbo.IC_DON_HANG_NHAP INNER JOIN
	dbo.IC_DON_HANG_NHAP_VAT_TU ON 
	dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT INNER JOIN
	dbo.IC_PHU_TUNG ON dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT INNER JOIN
	dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN
	dbo.NGOAI_TE ON dbo.IC_DON_HANG_NHAP_VAT_TU.NGOAI_TE = dbo.NGOAI_TE.NGOAI_TE INNER JOIN
	dbo.IC_KHO ON dbo.IC_DON_HANG_NHAP.MS_KHO = dbo.IC_KHO.MS_KHO INNER JOIN
	dbo.DANG_NHAP ON dbo.IC_DON_HANG_NHAP.MS_DANG_NHAP = dbo.DANG_NHAP.MS_DANG_NHAP INNER JOIN 
	(SELECT MS_CONG_NHAN AS MS_NGUOI_NHAP , HO + TEN AS TEN_NGUOI_NHAP
	FROM dbo.CONG_NHAN
	UNION
	SELECT MS_KH AS MS_NGUOI_NHAP ,TEN_CONG_TY AS TEN_NGUOI_NHAP
	FROM dbo.KHACH_HANG) TMP ON dbo.IC_DON_HANG_NHAP.NGUOI_NHAP = TMP.MS_NGUOI_NHAP 
	WHERE dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = @MS_DH_NHAP_PT
END


