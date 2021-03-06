
ALTER procedure [dbo].[MGetGIA_TRI_DINH_LUONGsDN]
	@MS_TS_GSTT INT ,
	@MS_MAY NVARCHAR(30),
	@Ngay Datetime
 AS

 --: MS thiết bị, Tên thiết bị, MS bộ phận, Tên bộ phận, Tên thông số giám sát, Giá trị, Đơn vị đo 

SELECT DISTINCT T2.MS_MAY, T5.TEN_MAY, T2.MS_BO_PHAN, T3.TEN_BO_PHAN,T1.TEN_TS_GSTT, CONVERT(nvarchar,NULL) AS GIA_TRI,
dbo.DON_VI_DO.TEN_DV_DO, ISNULL(T3.STT, 999) AS STT_BP, T2.MS_TS_GSTT, T4.TEN_NHOM_MAY,  T4.MS_LOAI_MAY, CONVERT(nvarchar,NULL) AS MS_TT
                         
FROM            dbo.THONG_SO_GSTT AS T1 INNER JOIN
                         dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T3 ON T2.MS_MAY = T3.MS_MAY AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
                             (SELECT        B.MS_MAY, B.MS_TS_GSTT, B.MS_BO_PHAN, B.MS_TT, MAX(A.NGAY_KT) AS NGAY_KT
                               FROM            dbo.GIAM_SAT_TINH_TRANG AS A INNER JOIN
                                                         dbo.GIAM_SAT_TINH_TRANG_TS AS B ON A.STT = B.STT
                               GROUP BY B.MS_MAY, B.MS_TS_GSTT, B.MS_BO_PHAN, B.MS_TT) AS NGAY_MAX ON T2.MS_MAY = NGAY_MAX.MS_MAY AND T2.MS_BO_PHAN = NGAY_MAX.MS_BO_PHAN AND 
                         T2.MS_TS_GSTT = NGAY_MAX.MS_TS_GSTT AND T2.MS_TT = NGAY_MAX.MS_TT LEFT OUTER JOIN
                         dbo.DON_VI_DO ON T1.MS_DV_DO = dbo.DON_VI_DO.MS_DV_DO LEFT OUTER JOIN
                         dbo.NHOM_MAY AS T4 INNER JOIN
                         dbo.MAY AS T5 ON T4.MS_NHOM_MAY = T5.MS_NHOM_MAY ON T2.MS_MAY = T5.MS_MAY

WHERE   
	(ISNULL(T2.ACTIVE,0) = 1) AND  (T1.LOAI_TS = 0) AND (CASE MS_DV_TG WHEN 1 THEN DATEADD(DAY, CHU_KY_DO, NGAY_MAX.NGAY_KT) 
			WHEN 2 THEN DATEADD(WEEK, CHU_KY_DO, NGAY_MAX.NGAY_KT) WHEN 3 THEN DATEADD(MONTH, CHU_KY_DO, NGAY_MAX.NGAY_KT) 
			ELSE DATEADD(YEAR, CHU_KY_DO, NGAY_MAX.NGAY_KT) END <= @Ngay)
			AND (T2.MS_MAY = @MS_MAY or @MS_MAY = '-1') 
			AND (T2.MS_TS_GSTT=@MS_TS_GSTT OR @MS_TS_GSTT = -1)
ORDER BY T2.MS_MAY, STT_BP, T1.TEN_TS_GSTT