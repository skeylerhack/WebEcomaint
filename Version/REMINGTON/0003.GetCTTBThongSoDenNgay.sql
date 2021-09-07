ALTER PROCEDURE [dbo].[GetCTTBThongSoDenNgay]
    @MS_MAY NVARCHAR(30) = '001' ,
    @MS_LOAI_CV INT = '1' ,
    @DenNgay DATETIME = '02/2/2030'
AS
SELECT * INTO #TS  FROM (
SELECT @MS_MAY MS_BO_PHAN,@MS_MAY TEN_BO_PHAN,NULL MS_BO_PHAN_CHA, CONVERT(NVARCHAR(10),NULL) AS MS_TS_GSTT, @MS_MAY AS MSBP
UNION
SELECT T1.MS_BO_PHAN, T1.MS_BO_PHAN + ' - ' + T1.TEN_BO_PHAN ,T1.MS_BO_PHAN_CHA, NULL AS MS_TS_GSTT,T1.MS_BO_PHAN AS MSBP
FROM            dbo.CAU_TRUC_THIET_BI AS T1 
WHERE T1.MS_MAY = @MS_MAY

UNION
				   SELECT DISTINCT  NULL, T1.TEN_TS_GSTT, T1.MS_BO_PHAN , T1.MS_TS_GSTT, T1.MS_BO_PHAN AS MSBP  FROM [dbo].[MGetHieuChuanKeGSTTTHEOMAY]('01/01/2020',@DenNgay,'admin','-1',-1,-1,'-1','-1',@MS_LOAI_CV,0,@MS_MAY,0) T1 INNER JOIN dbo.THONG_SO_GSTT T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT				   
				   WHERE T1.MS_MAY = @MS_MAY AND T2.LOAI_TS = 1
				   ) T1 ;
 WITH RET AS (
 SELECT  T1.MS_BO_PHAN_CHA,T1.MS_BO_PHAN
        FROM    (SELECT * FROM  #TS WHERE MS_BO_PHAN IS NULL   ) T1

        UNION ALL
        SELECT  T2.MS_BO_PHAN_CHA,T2.MS_BO_PHAN
        FROM   (SELECT * FROM  #TS WHERE MS_BO_PHAN IS NOT NULL  ) T2 INNER JOIN
                        RET r ON T2.MS_BO_PHAN = r.MS_BO_PHAN_CHA
)
DELETE #TS WHERE MS_BO_PHAN NOT IN(SELECT DISTINCT MS_BO_PHAN FROM RET  WHERE MS_BO_PHAN IS NOT NULL ) 
SELECT * FROM #TS ORDER BY MS_BO_PHAN
