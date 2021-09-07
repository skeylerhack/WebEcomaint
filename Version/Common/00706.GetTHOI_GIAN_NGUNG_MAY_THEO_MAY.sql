

-- EXEC GetTHOI_GIAN_NGUNG_MAY_THEO_MAY -1
ALTER procedure [dbo].[GetTHOI_GIAN_NGUNG_MAY_THEO_MAY]
	@LAN varchar(50)
 AS
BEGIN
		SELECT DISTINCT 
			  TGNM.NGAY, TGNM.TU_GIO, TGNM.DEN_NGAY, TGNM.DEN_GIO, TGNM.THOI_GIAN_SUA_CHUA AS THOI_GIAN_NGUNG_MAY, 
			  TGNM.THOI_GIAN_SUA AS THOI_GIAN_SUA_CHUA, TGNM.MS_HE_THONG, TGNM.MS_N_XUONG, TGNM.GHI_CHU, TGNM.MS_MAY,
			  TGNM.MS_MAY AS MS_MAY_OLD , TGNM.NGAY AS NGAY_OLD, TGNM.TU_GIO AS TU_GIO_OLD, TGNM.MS_NGUYEN_NHAN ,
			  TGNM.DEN_NGAY AS DEN_NGAY_OLD, TGNM.DEN_GIO AS DEN_GIO_OLD,TGNM.MS_LAN AS MS_LAN_OLD, TGNM.NGUYEN_NHAN AS NN_CGQ, TGNM.NGUYEN_NHAN_CU_THE, TGNM.HIEN_TUONG, TGNM.NGUOI_GIAI_QUYET 
		FROM         dbo.THOI_GIAN_NGUNG_MAY AS TGNM INNER JOIN
			  dbo.NHA_XUONG AS NX ON TGNM.MS_N_XUONG = NX.MS_N_XUONG
		WHERE     (TGNM.MS_LAN = @LAN OR @LAN = '-1')
END