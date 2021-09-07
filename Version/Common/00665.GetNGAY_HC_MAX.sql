IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetNGAY_HC_MAX')
   exec('CREATE PROCEDURE GetNGAY_HC_MAX AS BEGIN SET NOCOUNT ON; END')
GO

ALTER proc [dbo].[GetNGAY_HC_MAX]
	
	@MS_MAY NVARCHAR(30),
	@MS_PT NVARCHAR(30),
	@MS_VI_TRI NVARCHAR(50),
	@LOAI_HC INT,
	@HC_DHD BIT

AS

IF @HC_DHD = 1
BEGIN
	SELECT MAX(T.NGAY) AS NGAY_HC_CUOI, CASE @LOAI_HC WHEN 0 THEN T1.CHU_KY_HC_NOI WHEN 1 THEN T1.CHU_KY_HC_NGOAI WHEN 2 THEN T1.CHU_KY_KD ELSE T1.CHU_KY_KT END AS CHU_KY, T1.MS_DV_TG AS DON_VI FROM HIEU_CHUAN_DHD T
	INNER JOIN CHU_KY_HIEU_CHUAN T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_PT = T1.MS_PT AND T.MS_VI_TRI = T1.MS_VI_TRI 
	WHERE T.MS_MAY = @MS_MAY AND MS_LOAI_HIEU_CHUAN = @LOAI_HC AND NGAY <= GETDATE() AND T.MS_VI_TRI = @MS_VI_TRI AND T.MS_PT = @MS_PT
	GROUP BY T1.CHU_KY_HC_NOI, T1.CHU_KY_HC_NGOAI,T1.CHU_KY_KD ,T1.CHU_KY_KT,T1.MS_DV_TG 
END
ELSE
BEGIN


SELECT MAX(NGAY_HC) AS NGAY_HC_CUOI,  CASE @LOAI_HC WHEN 0 THEN T1.CHU_KY_HC_TB WHEN 1 THEN T1.CHU_KY_HIEU_CHUAN_TB_NGOAI ELSE T1.CHU_KY_KD_TB END AS CHU_KY, T1.DON_VI_THOI_GIAN AS DON_VI FROM HIEU_CHUAN_MAY T
INNER JOIN MAY T1 ON T.MS_MAY = T1.MS_MAY
WHERE T.MS_MAY = @MS_MAY AND NGAY_HC <= GETDATE() AND T.MS_LOAI_HIEU_CHUAN = @LOAI_HC 
GROUP BY T1.CHU_KY_HC_TB, T1.CHU_KY_HC_TB,T1.CHU_KY_HIEU_CHUAN_TB_NGOAI ,T1.CHU_KY_KD_TB,T1.DON_VI_THOI_GIAN 


END

