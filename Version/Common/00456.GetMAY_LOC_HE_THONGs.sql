
ALTER PROC [dbo].[GetMAY_LOC_HE_THONGs]
	@MS_HE_THONG INT
AS
SELECT     DISTINCT dbo.MAY.MS_MAY,MAY.TEN_MAY, dbo.HIEN_TRANG_SU_DUNG_MAY.TEN_HIEN_TRANG, dbo.HANG_SAN_XUAT.TEN_HSX, dbo.KHACH_HANG.TEN_CONG_TY, 
                      dbo.NHOM_MAY.TEN_NHOM_MAY, dbo.LOAI_MAY.TEN_LOAI_MAY, dbo.MAY.SO_NAM_KHAU_HAO, dbo.MAY.MO_TA, dbo.MAY.NHIEM_VU_THIET_BI, 
                      dbo.MAY.MODEL, dbo.MAY.SERIAL_NUMBER, dbo.MAY.NGAY_SX, dbo.MAY.NUOC_SX, dbo.MAY.NGAY_MUA, dbo.MAY.NGAY_BD_BAO_HANH, 
                      dbo.MAY.NGAY_DUA_VAO_SD, dbo.MAY.SO_THE, dbo.MAY.SO_NGAY_LV_TRONG_TUAN, dbo.MAY.SO_GIO_LV_TRONG_NGAY, 
                      dbo.DON_VI_TINH_RUN_TIME.TEN_DVT_RT, dbo.MAY.TY_LE_CON_LAI, dbo.MAY.MUC_UU_TIEN, dbo.MAY.SO_THANG_BH, dbo.MAY.GIA_MUA, 
                      dbo.NGOAI_TE.TEN_NGOAI_TE, MAX(dbo.MAY_HE_THONG.NGAY_NHAP) AS NGAY_NHAP_MAX, ANH_TB,TEN_UU_TIEN,CHU_KY_HC_TB,dbo.MAY.LUU_Y_SU_DUNG,MAY.SO_CT,MAY.TI_GIA_VND,MAY.TI_GIA_USD,
                       dbo.MAY.DON_VI_THOI_GIAN,dbo.MAY.CHU_KY_HIEU_CHUAN_TB_NGOAI,dbo.MAY.CHU_KY_KD_TB, dbo.MAY.DINH_MUC_SL, dbo.MAY.DVT_SL
FROM         dbo.NGOAI_TE RIGHT OUTER JOIN
                      dbo.MAY_HE_THONG INNER JOIN
                      dbo.MAY ON dbo.MAY_HE_THONG.MS_MAY = dbo.MAY.MS_MAY ON dbo.NGOAI_TE.NGOAI_TE = dbo.MAY.NGOAI_TE LEFT OUTER JOIN
                      dbo.HIEN_TRANG_SU_DUNG_MAY ON dbo.MAY.MS_HIEN_TRANG = dbo.HIEN_TRANG_SU_DUNG_MAY.MS_HIEN_TRANG LEFT OUTER JOIN
                      dbo.HANG_SAN_XUAT ON dbo.MAY.MS_HSX = dbo.HANG_SAN_XUAT.MS_HSX LEFT OUTER JOIN
                      dbo.KHACH_HANG ON dbo.MAY.MS_KH = dbo.KHACH_HANG.MS_KH LEFT OUTER JOIN
                      dbo.LOAI_MAY INNER JOIN
                      dbo.NHOM_MAY ON dbo.LOAI_MAY.MS_LOAI_MAY = dbo.NHOM_MAY.MS_LOAI_MAY ON 
                      dbo.MAY.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY LEFT OUTER JOIN
                      dbo.DON_VI_TINH_RUN_TIME ON dbo.MAY.MS_DVT_RT = dbo.DON_VI_TINH_RUN_TIME.MS_DVT_RT INNER JOIN MUC_UU_TIEN ON MAY.MUC_UU_TIEN=MUC_UU_TIEN.MS_UU_TIEN
WHERE MS_HE_THONG=@MS_HE_THONG
GROUP BY dbo.MAY.MS_MAY,MAY.TEN_MAY, dbo.HIEN_TRANG_SU_DUNG_MAY.TEN_HIEN_TRANG, dbo.HANG_SAN_XUAT.TEN_HSX, dbo.KHACH_HANG.TEN_CONG_TY, 
                      dbo.NHOM_MAY.TEN_NHOM_MAY, dbo.LOAI_MAY.TEN_LOAI_MAY, dbo.MAY.SO_NAM_KHAU_HAO, dbo.MAY.MO_TA, dbo.MAY.NHIEM_VU_THIET_BI, 
                      dbo.MAY.MODEL, dbo.MAY.SERIAL_NUMBER, dbo.MAY.NGAY_SX, dbo.MAY.NUOC_SX, dbo.MAY.NGAY_MUA, dbo.MAY.NGAY_BD_BAO_HANH, 
                      dbo.MAY.NGAY_DUA_VAO_SD, dbo.MAY.SO_THE, dbo.MAY.SO_NGAY_LV_TRONG_TUAN, dbo.MAY.SO_GIO_LV_TRONG_NGAY, 
                      dbo.DON_VI_TINH_RUN_TIME.TEN_DVT_RT, dbo.MAY.TY_LE_CON_LAI, dbo.MAY.MUC_UU_TIEN, dbo.MAY.SO_THANG_BH, dbo.MAY.GIA_MUA, 
                      dbo.NGOAI_TE.TEN_NGOAI_TE, ANH_TB,TEN_UU_TIEN,CHU_KY_HC_TB,dbo.MAY.LUU_Y_SU_DUNG,MAY.SO_CT,MAY.TI_GIA_VND,MAY.TI_GIA_USD,
                       dbo.MAY.DON_VI_THOI_GIAN,dbo.MAY.CHU_KY_HIEU_CHUAN_TB_NGOAI,dbo.MAY.CHU_KY_KD_TB, dbo.MAY.DINH_MUC_SL, dbo.MAY.DVT_SL
