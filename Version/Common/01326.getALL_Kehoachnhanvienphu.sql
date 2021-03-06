
--exec getALL_Kehoachnhanvienphu 'WO-201704000004'

ALTER procedure [dbo].[getALL_Kehoachnhanvienphu]
	@MS_PHIEU_BAO_TRI NVARCHAR(20)
	
AS

BEGIN 


	SELECT PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.MS_CONG_NHAN, PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.MS_CONG_NHAN AS MS_CN,HO + ' ' + TEN AS TEN_CONG_NHAN,NGAY_KH, TU_GIO_KH,DEN_NGAY_KH,DEN_GIO_KH, PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.TONG_GIO_KH, 	NGAY, TU_GIO,DEN_NGAY,DEN_GIO,
	convert( bit,case THUE_NGOAI when 0 then 1 else 0 end) as THUE_NGOAI,HOAN_THANH, ID_STT,SO_GIO,
	PHIEU_BAO_TRI_CV_PHU_TRO.STT AS MS_CV, PHIEU_BAO_TRI_CV_PHU_TRO.STT AS MS_BO_PHAN
	FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO 
	INNER JOIN PHIEU_BAO_TRI_CV_PHU_TRO ON (PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.MS_PHIEU_BAO_TRI  = PHIEU_BAO_TRI_CV_PHU_TRO.MS_PHIEU_BAO_TRI  AND 
	PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.STT = PHIEU_BAO_TRI_CV_PHU_TRO.STT )
	INNER JOIN CONG_NHAN ON PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.MS_CONG_NHAN = CONG_NHAN.MS_CONG_NHAN
	INNER JOIN [TO] ON CONG_NHAN.MS_TO = [TO].MS_TO1 INNER JOIN
	TO_PHONG_BAN ON [TO].MS_TO = TO_PHONG_BAN.MS_TO INNER JOIN DON_VI ON TO_PHONG_BAN.MS_DON_VI = DON_VI.MS_DON_VI
	WHERE PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO.MS_PHIEU_BAO_TRI=@MS_PHIEU_BAO_TRI 
END


