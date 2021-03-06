IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GET_CAU_TRUC_THIET_BI_TS_GSTT_1')
   exec('CREATE PROCEDURE GET_CAU_TRUC_THIET_BI_TS_GSTT_1 AS BEGIN SET NOCOUNT ON; END')
GO


--exec [GET_CAU_TRUC_THIET_BI_TS_GSTT_1] 'AIC-0001','01.01.03',0
alter procedure [dbo].[GET_CAU_TRUC_THIET_BI_TS_GSTT_1]
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@NGON_NGU INT
AS



SELECT     case @NGON_NGU when 0 then TSGSTT.TEN_TS_GSTT when 1 then isnull(TSGSTT.TEN_TS_GSTT_ANH,TSGSTT.TEN_TS_GSTT) WHEN 2 THEN ISNULL(TSGSTT.TEN_TS_GSTT_HOA,TSGSTT.TEN_TS_GSTT) end as TEN_TS_GSTT, CTTBTSGSTT.MS_MAY, CTTBTSGSTT.MS_BO_PHAN, CTTBTSGSTT.MS_TS_GSTT, CTTBTSGSTT.MS_TT, 
                      CTTBTSGSTT.TEN_GT, CTTBTSGSTT.GIA_TRI_TREN, CTTBTSGSTT.GIA_TRI_DUOI, CTTBTSGSTT.CHU_KY_DO, CTTBTSGSTT.MS_DV_TG, 
                      CTTBTSGSTT.DAT, CTTBTSGSTT.GHI_CHU, CTTBTSGSTT.ACTIVE 
					  FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT AS CTTBTSGSTT INNER JOIN
                      dbo.THONG_SO_GSTT AS TSGSTT ON CTTBTSGSTT.MS_TS_GSTT = TSGSTT.MS_TS_GSTT
	  WHERE MS_MAY= @MS_MAY  AND MS_BO_PHAN = @MS_BO_PHAN AND LOAI_TS= 1