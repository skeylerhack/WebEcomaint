
ALTER procedure [dbo].[insert_PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO_1]
	(@MS_DH_XUAT_PT_6 	[nvarchar](14),
	 @MS_DH_NHAP_PT_7 	[nvarchar](14),
	 @MS_PT_4 	[nvarchar](25),
	 @MS_PTTT_8 	[nvarchar](25),
	 @SL_TT_9 	[float],
	 @DON_GIA_10 	[float],
	 @NGOAI_TE_11 	[nvarchar](6),
	 @TI_GIA_12 	[float],
	 @TI_GIA_USD_13 	[float],
	@MS_PHIEU_BAO_TRI_1 	[nvarchar](20),
	 @MS_CV_2 	[int],
	 @MS_BO_PHAN_3 	[nvarchar](50),
	 @STT_5 	[int],	 
	 @GHI_CHU_14 	[nvarchar](512),
	 @ID 	[float])

AS 

IF @SL_TT_9 > 0 
BEGIN

	INSERT INTO [dbo].[PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO] 
	 ( [MS_PHIEU_BAO_TRI],
	 [MS_CV],
	 [MS_BO_PHAN],
	 [MS_PT],
	 [STT],
	 [MS_DH_XUAT_PT],
	 [MS_DH_NHAP_PT],
	 [MS_PTTT],
	 [SL_TT],
	 [DON_GIA],
	 [NGOAI_TE],
	 [TI_GIA],
	 [TI_GIA_USD],
	 [GHI_CHU], ID) 
 
	VALUES 
	( @MS_PHIEU_BAO_TRI_1,
	 @MS_CV_2,
	 @MS_BO_PHAN_3,
	 @MS_PT_4,
	 @STT_5,
	 @MS_DH_XUAT_PT_6,
	 @MS_DH_NHAP_PT_7,
	 @MS_PTTT_8,
	 @SL_TT_9,
	 @DON_GIA_10,
	 @NGOAI_TE_11,
	 @TI_GIA_12,
	 @TI_GIA_USD_13,
	 @GHI_CHU_14, @ID)

END