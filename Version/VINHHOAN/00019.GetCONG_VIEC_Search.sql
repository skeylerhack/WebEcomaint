

ALTER proc [dbo].[GetCONG_VIEC_Search]
	@USERLOGED NVARCHAR(50),
	@GIA_TRI NVARCHAR(250)
AS
SELECT [MS_CV], [MA_CV], [KY_HIEU_CV], CONG_VIEC.[MS_LOAI_CV], [MO_TA_CV], [PATH_HD],[AN_TOAN], 
CONG_VIEC.[MS_LOAI_MAY], [THOI_GIAN_DU_KIEN], [THAO_TAC], [TIEU_CHUAN_KT], CONG_VIEC.[GHI_CHU], 
	[MS_CHUYEN_MON], [MS_BAC_THO],TEN_LOAI_MAY ,DINH_MUC, NGOAI_TE
FROM CONG_VIEC INNER JOIN LOAI_MAY ON CONG_VIEC.MS_LOAI_MAY=LOAI_MAY.MS_LOAI_MAY 
		INNER JOIN NHOM_LOAI_CONG_VIEC ON CONG_VIEC.MS_LOAI_CV=NHOM_LOAI_CONG_VIEC.MS_LOAI_CV
		INNER JOIN NHOM ON  NHOM_LOAI_CONG_VIEC.GROUP_ID=NHOM.GROUP_ID 
		INNER JOIN USERS  ON NHOM.GROUP_ID=USERS.GROUP_ID
	WHERE USERNAME=@USERLOGED 
	AND (MS_CV LIKE '%' + @GIA_TRI + '%' or MO_TA_CV LIKE '%' + @GIA_TRI + '%' or KY_HIEU_CV LIKE '%' + @GIA_TRI + '%')
ORDER BY CONG_VIEC.MS_CV