
ALTER procedure [dbo].[update_PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO_1]
	(@MS_DH_XUAT_PT_6 	[nvarchar](14),
	 @MS_DH_NHAP_PT_7 	[nvarchar](14),
	 @MS_PT_4 	[nvarchar](25),
	 @MS_PTTT_8 	[nvarchar](25),
	 @SL_TT_17 	[float],
	 @DON_GIA_18 	[float],
	 @NGOAI_TE_19 	[nvarchar](6),
	 @TI_GIA_20 	[float],
	 @TI_GIA_USD_21 	[float],
	@MS_PHIEU_BAO_TRI_1 	[nvarchar](20),
	 @MS_CV_2 	[int],
	 @MS_BO_PHAN_3 	[nvarchar](50),
	 @STT_5 	[int],	 
	 @GHI_CHU_22 	[nvarchar](512),
	 @ID 	[float])

AS 

IF @SL_TT_17 > 0 
BEGIN
	UPDATE [dbo].[PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO] 
	SET 	
		 [SL_TT]	 = @SL_TT_17,
		 [DON_GIA]	 = @DON_GIA_18,
		 [NGOAI_TE]	 = @NGOAI_TE_19,
		 [TI_GIA]	 = @TI_GIA_20,
		 [TI_GIA_USD]	 = @TI_GIA_USD_21,
		 [GHI_CHU]	 = @GHI_CHU_22 

	WHERE 
		( [MS_PHIEU_BAO_TRI]	 = @MS_PHIEU_BAO_TRI_1 AND
		 [MS_CV]	 = @MS_CV_2 AND
		 [MS_BO_PHAN]	 = @MS_BO_PHAN_3 AND
		 [MS_PT]	 = @MS_PT_4 AND
		 [STT]	 = @STT_5 AND
		 [MS_DH_XUAT_PT]	 = @MS_DH_XUAT_PT_6 AND
		 [MS_DH_NHAP_PT]	 = @MS_DH_NHAP_PT_7 AND
		 [MS_PTTT]	 = @MS_PTTT_8 AND
		 [ID] = @ID)
END 
ELSE
BEGIN
	DELETE FROM [PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO]   WHERE 
		( [MS_PHIEU_BAO_TRI]	 = @MS_PHIEU_BAO_TRI_1 AND
		 [MS_CV]	 = @MS_CV_2 AND
		 [MS_BO_PHAN]	 = @MS_BO_PHAN_3 AND
		 [MS_PT]	 = @MS_PT_4 AND
		 [STT]	 = @STT_5 AND
		 [MS_DH_XUAT_PT]	 = @MS_DH_XUAT_PT_6 AND
		 [MS_DH_NHAP_PT]	 = @MS_DH_NHAP_PT_7 AND
		 [MS_PTTT]	 = @MS_PTTT_8 AND
		 [ID] = @ID)
END