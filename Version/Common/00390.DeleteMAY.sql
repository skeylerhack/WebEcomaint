
ALTER proc [dbo].[DeleteMAY]
	@MS_MAY NVARCHAR(30) = N'A1'
AS


DELETE FROM CAU_TRUC_THIET_BI_CONG_VIEC WHERE  MS_MAY=@MS_MAY
DELETE FROM CAU_TRUC_THIET_BI_PHU_TUNG WHERE  MS_MAY=@MS_MAY
DELETE FROM CAU_TRUC_THIET_BI_TS_GSTT WHERE  MS_MAY=@MS_MAY
DELETE FROM CAU_TRUC_THIET_BI WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY_LOAI_BTPN_CONG_VIEC WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY_LOAI_BTPN_CHU_KY  WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY_LOAI_BTPN WHERE  MS_MAY=@MS_MAY
DELETE FROM CHU_KY_HIEU_CHUAN WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY_TAI_LIEU WHERE  MS_MAY=@MS_MAY
DELETE FROM MAY WHERE MS_MAY=@MS_MAY
