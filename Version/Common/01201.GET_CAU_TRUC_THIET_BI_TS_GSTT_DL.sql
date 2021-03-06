
ALTER procedure [dbo].[GET_CAU_TRUC_THIET_BI_TS_GSTT_DL]
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@NGON_NGU INT
AS


SELECT     TEN_TS_GSTT, CTTBTSGSTT.MS_MAY, CTTBTSGSTT.MS_BO_PHAN, CTTBTSGSTT.MS_TS_GSTT, ISNULL(CTTBTSGSTT.THOI_GIAN, 0) THOI_GIAN , ISNULL(CTTBTSGSTT.CACH_THUC_HIEN, '') CACH_THUC_HIEN,
 CTTBTSGSTT.MS_TT, 
                      CTTBTSGSTT.TEN_GT, CTTBTSGSTT.GIA_TRI_TREN, CTTBTSGSTT.GIA_TRI_DUOI, CTTBTSGSTT.CHU_KY_DO, CTTBTSGSTT.MS_DV_TG, 
                      CTTBTSGSTT.DAT, CTTBTSGSTT.GHI_CHU
					  , dbo.DON_VI_DO.TEN_DV_DO, CTTBTSGSTT.ACTIVE 
					  FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT AS CTTBTSGSTT INNER JOIN
                      dbo.THONG_SO_GSTT AS TSGSTT ON CTTBTSGSTT.MS_TS_GSTT = TSGSTT.MS_TS_GSTT 
					  INNER JOIN dbo.DON_VI_DO ON TSGSTT.MS_DV_DO = dbo.DON_VI_DO.MS_DV_DO
					  WHERE MS_MAY= @MS_MAY AND MS_BO_PHAN=@MS_BO_PHAN AND LOAI_TS= 0
