

-- EXEC GetGIA_TRI_DINH_LUONGs -1 ,-1

ALTER procedure [dbo].[GetGIA_TRI_DINH_LUONGs]
	@MS_TS_GSTT INT ,
	@MS_MAY NVARCHAR(30)
 AS
 --: MS thiết bị, Tên thiết bị, MS bộ phận, Tên bộ phận, Tên thông số giám sát, Giá trị, Đơn vị đo 

SELECT DISTINCT T2.MS_MAY, T6.TEN_MAY, T2.MS_BO_PHAN, T3.TEN_BO_PHAN, T1.TEN_TS_GSTT, CONVERT(nvarchar,NULL) AS GIA_TRI,
T4.TEN_DV_DO,ISNULL(T3.STT,999) AS STT_BP,T2.MS_TS_GSTT, T5.TEN_NHOM_MAY, T5.MS_LOAI_MAY, CONVERT(nvarchar,NULL) AS MS_TT


FROM            dbo.THONG_SO_GSTT AS T1 INNER JOIN
                         dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T3 ON T2.MS_MAY = T3.MS_MAY AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
                         dbo.DON_VI_DO AS T4 ON T1.MS_DV_DO = T4.MS_DV_DO LEFT OUTER JOIN
                         dbo.NHOM_MAY AS T5 INNER JOIN
                         dbo.MAY AS T6 ON T5.MS_NHOM_MAY = T6.MS_NHOM_MAY ON T2.MS_MAY = T6.MS_MAY
WHERE   (ISNULL(T2.ACTIVE,0) = 1) AND 
(T2.MS_MAY = @MS_MAY) AND (T2.MS_TS_GSTT = @MS_TS_GSTT) OR
                         (T2.MS_MAY = @MS_MAY) AND (@MS_TS_GSTT = - 1) OR
                         (T2.MS_TS_GSTT = @MS_TS_GSTT) AND (@MS_MAY = '-1') OR
                         (@MS_TS_GSTT = - 1) AND (@MS_MAY = '-1')
ORDER BY T2.MS_MAY,ISNULL(T3.STT,999),T1.TEN_TS_GSTT


