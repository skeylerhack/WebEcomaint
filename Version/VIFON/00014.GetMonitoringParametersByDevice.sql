
--GetMonitoringParametersByDevice '10-05-CVM-024-00', 0
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetMonitoringParametersByDevice')
   exec('CREATE PROCEDURE GetMonitoringParametersByDevice AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROC GetMonitoringParametersByDevice
	@deviceID nvarchar(50),
	@isDue bit = 0
as
begin
	SELECT DISTINCT @deviceID DeviceID, THONG_SO_GSTT.TEN_TS_GSTT MonitoringParamsName, CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT  MonitoringParamsID, T.MS_BO_PHAN ComponentID, T.TEN_BO_PHAN ComponentName,
    THONG_SO_GSTT.LOAI_TS TypeOfParam, ''  MeasurementUnitName,  GIA_TRI_TS_GSTT.TEN_GIA_TRI ValueParamName, GIA_TRI_TS_GSTT.DAT Pass, CONVERT(FLOAT, 0) Measurement,GIA_TRI_TS_GSTT.STT ValueParamID, 
	'' Note 
	FROM THONG_SO_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI T ON T.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY AND T.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN 
	LEFT JOIN GIA_TRI_TS_GSTT ON THONG_SO_GSTT.MS_TS_GSTT = GIA_TRI_TS_GSTT.MS_TS_GSTT 
	WHERE (CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = @deviceID) AND  THONG_SO_GSTT.LOAI_TS = 1 AND (@isDue = 'FALSE' OR (@isDue = 'TRUE' AND [dbo].[WEB_GET_NGAY_KE_GSTT_ONLINE](T.MS_MAY, T.MS_BO_PHAN,
	THONG_SO_GSTT.MS_TS_GSTT) <= GETDATE()))
	UNION
	SELECT DISTINCT @deviceID DeviceID,  THONG_SO_GSTT.TEN_TS_GSTT MonitoringParamsName, CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT MonitoringParamsID, T.MS_BO_PHAN ComponentID, T.TEN_BO_PHAN ComponentName,
    THONG_SO_GSTT.LOAI_TS TypeOfParam, ISNULL(T4.TEN_DV_DO, '') MeasurementUnitName, dbo.GetGiaTriThongSo(@deviceID,T.MS_BO_PHAN, CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT) ValueParamName, -1 Pass, CONVERT(FLOAT, 0)  Measurement,-1 ValueParamID, 
	'' Note 
	FROM THONG_SO_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT ON CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT = THONG_SO_GSTT.MS_TS_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI T ON T.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY AND T.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT.MS_BO_PHAN 
	LEFT JOIN dbo.DON_VI_DO AS T4 ON THONG_SO_GSTT.MS_DV_DO = T4.MS_DV_DO WHERE (CAU_TRUC_THIET_BI_TS_GSTT.MS_MAY = @deviceID) AND THONG_SO_GSTT.LOAI_TS = 0 AND (@isDue = 'FALSE' OR (@isDue = 'TRUE' AND [dbo].[WEB_GET_NGAY_KE_GSTT_ONLINE](T.MS_MAY, T.MS_BO_PHAN, THONG_SO_GSTT.MS_TS_GSTT) <= GETDATE()))
	GROUP BY THONG_SO_GSTT.TEN_TS_GSTT, CAU_TRUC_THIET_BI_TS_GSTT.MS_TS_GSTT, T.MS_BO_PHAN, T.TEN_BO_PHAN,
    THONG_SO_GSTT.LOAI_TS, TEN_DV_DO,CAU_TRUC_THIET_BI_TS_GSTT.MS_TT 
end