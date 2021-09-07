
--exec [GET_CAU_TRUC_THIET_BI_TS_GSTT_1] 'AIC-0001','01.01.03',0
ALTER procedure [dbo].[GET_CAU_TRUC_THIET_BI_TS_GSTT_1]
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@NGON_NGU INT
AS

SELECT      
CASE @NGON_NGU WHEN 0 THEN TEN_TS_GSTT WHEN 1 THEN ISNULL(NULLIF(T2.TEN_TS_GSTT_ANH,''),TEN_TS_GSTT) ELSE ISNULL(NULLIF(T2.TEN_TS_GSTT_HOA,''),TEN_TS_GSTT) END  AS TEN_TS_GSTT,

T1.MS_MAY, T1.MS_BO_PHAN, T1.MS_TS_GSTT,
 T1.MS_TT , T1.CACH_THUC_HIEN,
                      T1.TEN_GT, T1.CHU_KY_DO, T1.MS_DV_TG,   ISNULL(T1.THOI_GIAN, 0) THOI_GIAN, T1.MS_UU_TIEN,
                      T1.DAT, T1.GHI_CHU, T1.ACTIVE ,T1.TIEU_CHUAN_KT, T1.YEU_CAU_NS, T1.YEU_CAU_DUNG_CU, T1.PATH_HD, NULL AS CT_CVIEC
					  FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1 INNER JOIN
                      dbo.THONG_SO_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT
	  WHERE MS_MAY= @MS_MAY  AND MS_BO_PHAN = @MS_BO_PHAN AND LOAI_TS= 1