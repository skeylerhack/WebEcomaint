
IF NOT EXISTS(SELECT *	FROM	sys.objects WHERE type='P' AND name='spGetBCGSTTDenHanKiemTra')
EXEC('CREATE PROCEDURE spGetBCGSTTDenHanKiemTra AS BEGIN SET NOCOUNT ON;  END');

GO
IF  EXISTS(SELECT *	FROM	sys.objects WHERE type='P' AND name='SP_Y_GET_TSGSTTDHKT_BAOCAO')
EXEC('DROP PROCEDURE  SP_Y_GET_TSGSTTDHKT_BAOCAO ');

GO
--exec [spGetBCGSTTDenHanKiemTra] 'admin',0,'01/01/2019','01/31/2019','-1', -1,-1,'-1','-1','-1',-1,1
ALTER PROCEDURE [dbo].[spGetBCGSTTDenHanKiemTra] 
    @UserName NVARCHAR(100) ='admin',
    @NNgu INT =0,
    @TuNgay DATETIME =  '01/01/2019',
    @DenNgay DATETIME = '12/31/2019',
    @MsNhaXuong NVARCHAR(50) ='-1',
    @MsHeThong INT =-1,
	@MsBPCP INT =-1,
    @MsLoaiMay NVARCHAR(30) ='-1',
	@MsNhomMay NVARCHAR(30) ='-1',
    @MsMay NVARCHAR(30) ='-1',
    @MsLoaiCV INT =-1,
    @LoaiIn INT = 2
AS
-- LoaiIn = 1 bao cao theo ngày tháng
-- LoaiIn = 2 bao cao theo nam
    BEGIN 
        SET FMTONLY OFF 

		SELECT	MS_MAY, T1.Ten_N_XUONG, T1.MS_N_XUONG
		INTO	#MAY_USER
		FROM	[dbo].[MGetMayUserNgay](@DenNgay, @UserName, @MsNhaXuong, @MsHeThong, @MsBPCP, @MsLoaiMay, @MsNhomMay, @MsMay, @NNgu) T1;

		SELECT	DISTINCT T2.MS_N_XUONG,T1.TEN_MAY,T1.TEN_BO_PHAN,T1.MS_MAY,T1.TEN_TS_GSTT,T1.MS_DV_TG,RTRIM(CONVERT(CHAR(10),T1.CHU_KY_DO))+' '+ T1.TEN_DV_TG AS CHU_KY_DO, T1.NGAY_CUOI AS NGAY_KT_CUOI ,T1.NGAY_KE AS NGAY_KT_KE,Ten_N_XUONG,ISNULL(CONVERT(NVARCHAR(5), MONTH(T1.NGAY_KE)),0) AS THANG
		INTO	#GSTT
		FROM	dbo.MGetHieuChuanKeGSTT(@TuNgay, @DenNgay, @UserName, @MsNhaXuong, @MsHeThong, @MsBPCP, @MsLoaiMay, @MsNhomMay, @MsLoaiCV, 1, @NNgu) T1
					INNER JOIN #MAY_USER T2 ON T1.MS_MAY=T2.MS_MAY INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT T3 ON  T3.MS_MAY = T1.MS_MAY
                                                              AND T3.MS_BO_PHAN = T1.MS_BO_PHAN
                                                              AND T3.MS_TS_GSTT = T1.MS_TS_GSTT
                                                              AND T3.MS_TT = T1.MS_TT
		WHERE (CONVERT(DATE, T1.NGAY_KE) BETWEEN CONVERT(DATE, @TuNgay)AND CONVERT(DATE, @DenNgay)) AND (T3.ACTIVE = 1)
             
 --bao cao theo nam
        IF ( @LoaiIn = 2 )
            BEGIN
                SELECT  pvt.*
                INTO    #TMP2
                FROM    ( SELECT    T1.MS_N_XUONG + ' - ' + T1.Ten_N_XUONG AS MS_N_XUONG,
                                    T1.MS_MAY ,
                                    T1.TEN_MAY ,
                                    T1.TEN_BO_PHAN ,
                                    T1.TEN_TS_GSTT ,
									T1.MS_DV_TG,
									T1.CHU_KY_DO,
									T1.NGAY_KT_CUOI,
                                    T1.NGAY_KT_KE,
									THANG
                          FROM      #GSTT T1
                        ) A PIVOT
		( COUNT(A.NGAY_KT_KE) FOR A.THANG IN ( [1], [2], [3], [4], [5], [6],
                                               [7], [8], [9], [10], [11], [12] ) )AS pvt	

				UPDATE  #TMP2 SET [1] = NULL WHERE   [1] = 0
				UPDATE  #TMP2 SET [2] = NULL WHERE   [2] = 0
				UPDATE  #TMP2 SET [3] = NULL WHERE   [3] = 0
				UPDATE  #TMP2 SET [4] = NULL WHERE   [4] = 0
				UPDATE  #TMP2 SET [5] = NULL WHERE   [5] = 0
				UPDATE  #TMP2 SET [6] = NULL WHERE   [6] = 0
				UPDATE  #TMP2 SET [7] = NULL WHERE   [7] = 0
				UPDATE  #TMP2 SET [8] = NULL WHERE   [8] = 0
				UPDATE  #TMP2 SET [9] = NULL WHERE   [9] = 0
				UPDATE  #TMP2 SET [10] = NULL WHERE   [10] = 0
				UPDATE  #TMP2 SET [11] = NULL WHERE   [11] = 0
				UPDATE  #TMP2 SET [12] = NULL WHERE   [12] = 0
				                
				SELECT  T1.MS_N_XUONG ,T1.MS_MAY ,T1.TEN_MAY ,T1.TEN_BO_PHAN ,T1.TEN_TS_GSTT ,T1.CHU_KY_DO,T1.NGAY_KT_CUOI,T1.[1], T1.[2], T1.[3], T1.[4], T1.[5], T1.[6],T1.[7], T1.[8], T1.[9], T1.[10], T1.[11], T1.[12] ,CONVERT(NVARCHAR(5), ISNULL([T2].[R], 0)) + ','+ CONVERT(NVARCHAR(5), ISNULL([T2].[G], 0)) + ','+ CONVERT(NVARCHAR(5), ISNULL([T2].[B], 0)) AS [CL]
				FROM    #TMP2 T1 LEFT JOIN dbo.DON_VI_THOI_GIAN_MAU T2 ON T1.MS_DV_TG = T2.MS_DV_TG

            END
-- bao cao theo thang
        ELSE
            BEGIN
                
                DECLARE @sSql NVARCHAR(MAX)
                DECLARE @sSqlL NVARCHAR(MAX)
				DECLARE @sSqlSelect NVARCHAR(MAX) = ''
				SET @sSql = ''
				SET @sSqlSelect = ''
				SELECT @sSql = COALESCE(ISNULL(@sSql,'') + CASE LEN(@sSql) WHEN 0 THEN '' ELSE ',' END , '') + ISNULL(NGAY,'')  ,
				 @sSqlSelect = COALESCE(ISNULL(@sSqlSelect,'') + CASE LEN(@sSqlSelect) WHEN 0 THEN '' ELSE ',' END , '') + 
					' CASE ' + NGAY + ' WHEN 0 THEN NULL ELSE ' + NGAY + ' END AS '  + NGAY
				 FROM 
				(
					SELECT DISTINCT number,
					N' [' +CONVERT(NVARCHAR(10), DATEADD(day,number,@TuNgay),103)+N']'  AS NGAY
					 from master.dbo.spt_values WHERE number between 0 and 1000 AND DATEADD(day,number,@TuNgay) <= @DenNgay
				 ) T1

				
				--SELECT @sSqlSelect = COALESCE(ISNULL(@sSqlSelect,'') + CASE LEN(@sSqlSelect) WHEN 0 THEN '' ELSE ',' END , '') + 
				--' CASE ' + NGAY + ' WHEN 0 THEN NULL ELSE ' + NGAY + ' END AS '  + NGAY
				-- FROM 
				--(
				--	SELECT DISTINCT number,
				--	N' [' +CONVERT(NVARCHAR(10), DATEADD(day,number,@TuNgay),103)+N']'  AS NGAY
				--	 from master.dbo.spt_values WHERE number between 0 and 1000 AND DATEADD(day,number,@TuNgay) <= @DenNgay
				-- ) T1
				 
                SET @sSqlL = 'SELECT pvt.* into #TMP1 FROM 
(SELECT T1.Ten_N_XUONG AS MS_N_XUONG,T1.MS_MAY,T1.TEN_MAY,T1.TEN_BO_PHAN,T1.TEN_TS_GSTT,T1.NGAY_KT_KE,ISNULL( CONVERT(NVARCHAR, T1.NGAY_KT_KE, 103),0) AS NGAY,T1.CHU_KY_DO,T1.NGAY_KT_CUOI,T1.MS_DV_TG FROM #GSTT T1)
 A
		PIVOT
		(
			COUNT(A.NGAY_KT_KE)
			FOR A.NGAY IN (' + @sSql + ')
		)AS pvt

		
		SELECT MS_N_XUONG ,MS_MAY,TEN_MAY,TEN_BO_PHAN,TEN_TS_GSTT,CHU_KY_DO,NGAY_KT_CUOI, ' + @sSqlSelect
                    + ',		
		CONVERT(NVARCHAR(5),ISNULL([R],0)) + '','' + CONVERT(NVARCHAR(5),ISNULL([G],0)) + '','' + CONVERT(NVARCHAR(5),ISNULL([B],0)) AS [CL]   FROM #TMP1 T1 LEFT JOIN dbo.DON_VI_THOI_GIAN_MAU T2 ON T1.MS_DV_TG = T2.MS_DV_TG ORDER BY MS_N_XUONG ,MS_MAY,TEN_MAY,TEN_BO_PHAN'
                EXEC(@sSqlL)
            END
    END