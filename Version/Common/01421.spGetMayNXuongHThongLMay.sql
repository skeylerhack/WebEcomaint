

--EXEC [spGetMayNXuongHThongLMay] 'ADMIN','-1',-1,-1,'-1','-1','-1','01/01/2019',1
ALTER proc [dbo].[spGetMayNXuongHThongLMay]
	@UserName NVARCHAR(50),
	@MsNX NVARCHAR(50),
	@MSHT INT,
	@MSBPCP INT,
	@MsLoaiMay NVARCHAR(20),	
	@MsNhomMay NVARCHAR(20),	
	@MSMay NVARCHAR(100),
	@DenNgay DATETIME,
	@NNgu int
AS




SELECT DISTINCT MS_MAY,TEN_MAY, MS_NHOM_MAY, MS_LOAI_MAY, MS_HSX, MS_HIEN_TRANG, MS_KH, SO_NAM_KHAU_HAO, MO_TA, NHIEM_VU_THIET_BI, MODEL, SERIAL_NUMBER, NGAY_SX, NUOC_SX, 
                      NGAY_MUA, NGAY_BD_BAO_HANH, NGAY_DUA_VAO_SD, SO_THE, SO_NGAY_LV_TRONG_TUAN, SO_GIO_LV_TRONG_NGAY, MS_DVT_RT, TY_LE_CON_LAI, MUC_UU_TIEN, SO_THANG_BH, 
                      GIA_MUA, NGOAI_TE, LUU_Y_SU_DUNG, Anh_TB, CHU_KY_HC_TB,  AN_TOAN, MS_HO_SO, TEN_HO_SO, NGAY_HIEU_LUC_HO_SO, SO_CT, TI_GIA_VND, TI_GIA_USD, 
                      CHU_KY_HIEU_CHUAN_TB_NGOAI, CHU_KY_KD_TB, DON_VI_THOI_GIAN, MS_N_XUONG, MS_HE_THONG, MS_BP_CHIU_PHI, USER_INSERT, NGAY_INSERT, USER_UPDATE, NGAY_UPDATE, 
                      Ten_N_XUONG, TEN_HE_THONG, TEN_NHOM_MAY, TEN_LOAI_MAY, TEN_BP_CHIU_PHI
	FROM dbo.MGetMayUserNgay(@DenNgay,@UserName,@MsNX,@MSHT,@MSBPCP,@MsLoaiMay,@MsNhomMay,@MSMay,@NNgu) A

ORDER BY MS_MAY,TEN_MAY,MODEL,TEN_BP_CHIU_PHI,Ten_N_XUONG,TEN_HE_THONG	
