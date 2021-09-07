IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Y_GET_TSGSTTDHKT_BAOCAO_VIFON')
   
exec('CREATE PROCEDURE SP_Y_GET_TSGSTTDHKT_BAOCAO_VIFON AS BEGIN SET NOCOUNT ON; END')

GO

--them ngay cuoi
--exec [SP_Y_GET_TSGSTTDHKT_BAOCAO_VIFON] 'administrator',0,'02/01/2018','02/28/2018',-1, -1,-1,'-1',-1,-1,-1,-1 
--exec [SP_Y_GET_TSGSTTDHKT_BAOCAO_VIFON] 'administrator',0,'01/01/2019','12/31/2019',-1, -1,-1,'-1',-1 ,0
ALTER PROCEDURE [dbo].[SP_Y_GET_TSGSTTDHKT_BAOCAO_VIFON]
    @USERNAME VARCHAR(64) ,
    @LANGUAGE INT ,
    @TU_NGAY DATETIME ,
    @DEN_NGAY DATETIME ,
    @MS_NHA_XUONG VARCHAR(50) ,
    @MS_HE_THONG INT ,
    @MS_LOAI_MAY VARCHAR(30) ,
    @MS_MAY VARCHAR(30) ,
    @MS_LOAI_CV INT ,
    @LOAIIN INT = 1
AS
    BEGIN 
        SET FMTONLY OFF 
        SELECT  *
        INTO    #MAY_USER
        FROM    [dbo].[MGetMayUserNgay](@DEN_NGAY, @USERNAME, @MS_NHA_XUONG,
                                        @MS_HE_THONG, -1, @MS_LOAI_MAY, '-1',
                                        @MS_MAY, @LANGUAGE)
        SELECT  T4.MS_TS_GSTT ,
				CASE @LANGUAGE WHEN 0 THEN T4.TEN_TS_GSTT WHEN 1 THEN ISNULL(NULLIF(T4.TEN_TS_GSTT_ANH,''),T4.TEN_TS_GSTT) ELSE ISNULL(NULLIF(T4.TEN_TS_GSTT_HOA,''),T4.TEN_TS_GSTT) END AS TEN_TS_GSTT ,
                T4.MS_DV_DO ,
                T4.LOAI_TS ,
                T4.GHI_CHU ,
                T4.MS_BP_GSTT,
                T4.DUONG_DAN,
                T4.MS_LOAI_CV
        INTO    #THONG_SO_GSTT
        FROM    dbo.NHOM_LOAI_CONG_VIEC AS T2
                INNER JOIN dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID
                INNER JOIN dbo.THONG_SO_GSTT AS T4 ON T2.MS_LOAI_CV = T4.MS_LOAI_CV
        WHERE   ( USERNAME = @USERNAME )
                AND ( T4.MS_LOAI_CV = @MS_LOAI_CV
                      OR @MS_LOAI_CV = -1
                    )
                AND ( ISNULL(T4.MS_LOAI_CV, '') <> '' )
        UNION
        SELECT  *
        FROM    ( SELECT DISTINCT
                            T4.MS_TS_GSTT ,
                            CASE @LANGUAGE
                              WHEN 0 THEN T4.TEN_TS_GSTT
                              WHEN 1
                              THEN ISNULL(NULLIF(T4.TEN_TS_GSTT_ANH, ''),
                                          T4.TEN_TS_GSTT)
                              ELSE ISNULL(NULLIF(T4.TEN_TS_GSTT_HOA, ''),
                                          T4.TEN_TS_GSTT)
                            END AS TEN_TS_GSTT ,
                            T4.MS_DV_DO ,
                            T4.LOAI_TS ,
                            T4.GHI_CHU ,
                            T4.MS_BP_GSTT ,
                            T4.DUONG_DAN ,
                            ISNULL(T4.MS_LOAI_CV, -99) AS MS_LOAI_CV
                  FROM      dbo.THONG_SO_GSTT AS T4
                  WHERE     ( ISNULL(MS_LOAI_CV, '') = '' )
                ) A
        WHERE   ( MS_LOAI_CV = @MS_LOAI_CV
                  OR @MS_LOAI_CV = -1
                )

        SELECT DISTINCT
                TEMP.MS_N_XUONG ,
                TEMP.TEN_MAY ,
                TEMP.MS_MAY ,
                TEMP.MS_DV_TG ,
				TEMP.CHU_KY_DO,
                TEMP.NGAY_CUOI AS NGAY_KT_CUOI,
                TEMP.NGAY_KT_KE,
                CASE @LANGUAGE
                  WHEN 0 THEN Ten_N_XUONG
                  WHEN 1 THEN ISNULL(NULLIF(TEN_N_XUONG_A, ''), Ten_N_XUONG)
                  ELSE ISNULL(NULLIF(TEN_N_XUONG_H, ''), Ten_N_XUONG)
                END AS Ten_N_XUONG
        INTO    #temptt
        FROM    ( SELECT  DISTINCT
                            T1.MS_MAY ,
                            T4.TEN_MAY ,
                            T2.MS_DV_TG ,
							RTRIM(CONVERT(CHAR(10),T2.CHU_KY_DO))+' '+ CASE @LANGUAGE WHEN 0 THEN T6.TEN_DV_TG WHEN 1 THEN ISNULL(NULLIF(T6.TEN_DV_TG_ANH,''),T6.TEN_DV_TG) ELSE ISNULL(NULLIF(T6.TEN_DV_TG_HOA,''),T6.TEN_DV_TG) END AS CHU_KY_DO,
							T2.NGAY_CUOI ,
                            T2.NGAY_KE AS NGAY_KT_KE ,
                            T4.MS_N_XUONG ,
                            T1.MS_TS_GSTT
		--					@NgayBD DATETIME,
	 --@NgayKT DATETIME,
	 --@UserName NVARCHAR(255),
	 --@MsNXuong nvarchar(50),
	 --@MsHeThong int,
	 --@MsBPCP int,
	 --@LoaiMay NVARCHAR (20),
	 --@NhomMay NVARCHAR (20), 
	 --@MsLCViec INT, 
	 --@MLoai BIT,
	 --@NNgu INT

                  FROM      dbo.CAU_TRUC_THIET_BI_TS_GSTT T1
				  INNER JOIN dbo.MGetHieuChuanKeGSTT(@TU_NGAY,@DEN_NGAY,
                                                   @USERNAME, @MS_NHA_XUONG,
                                                   @MS_HE_THONG,-1, @MS_LOAI_MAY,'-1',@MS_LOAI_CV, 1,@LANGUAGE) 
															  T2 ON T2.MS_MAY = T1.MS_MAY
                                                              AND T2.MS_BO_PHAN = T1.MS_BO_PHAN
                                                              AND T2.MS_TS_GSTT = T1.MS_TS_GSTT
                                                              AND T2.MS_TT = T1.MS_TT
                            INNER JOIN dbo.CAU_TRUC_THIET_BI T3 ON T3.MS_MAY = T1.MS_MAY
                                                              AND T3.MS_BO_PHAN = T1.MS_BO_PHAN
                            INNER JOIN #MAY_USER T4 ON T4.MS_MAY = T1.MS_MAY
                            INNER JOIN #THONG_SO_GSTT T5 ON T5.MS_TS_GSTT = T1.MS_TS_GSTT
							INNER JOIN dbo.DON_VI_THOI_GIAN	T6 ON T6.MS_DV_TG = T2.MS_DV_TG
                  WHERE     T5.LOAI_TS = 1
                            AND T1.ACTIVE = 1
	 AND  convert(date, T2.NGAY_KE) between convert(date, @TU_NGAY) and convert(date, @DEN_NGAY)
                ) TEMP
                INNER JOIN NHA_XUONG ON NHA_XUONG.MS_N_XUONG = TEMP.MS_N_XUONG
                                       
 --bao cao theo nam
        IF ( @LOAIIN = 2 )
            BEGIN
                SELECT  pvt.*
                INTO    #TMP2
                FROM    ( SELECT    T1.Ten_N_XUONG AS MS_N_XUONG ,
                                    T1.MS_MAY ,
                                    T1.TEN_MAY ,
									T1.MS_DV_TG,
									T1.CHU_KY_DO,
									T1.NGAY_KT_CUOI,
                                    T1.NGAY_KT_KE,
                                    CONVERT(NVARCHAR(5), MONTH(T1.NGAY_KT_KE)) AS THANG
                          FROM      #temptt T1
                        ) A PIVOT
		( COUNT(A.NGAY_KT_KE) FOR A.THANG IN ( [1], [2], [3], [4], [5], [6],
                                               [7], [8], [9], [10], [11], [12] ) )AS pvt	
                UPDATE  #TMP2
                SET     [1] = NULL
                WHERE   [1] = 0
                UPDATE  #TMP2
                SET     [2] = NULL
                WHERE   [2] = 0
                UPDATE  #TMP2
                SET     [3] = NULL
                WHERE   [3] = 0
                UPDATE  #TMP2
                SET     [4] = NULL
                WHERE   [4] = 0
                UPDATE  #TMP2
                SET     [5] = NULL
                WHERE   [5] = 0
                UPDATE  #TMP2
                SET     [6] = NULL
                WHERE   [6] = 0
                UPDATE  #TMP2
                SET     [7] = NULL
                WHERE   [7] = 0
                UPDATE  #TMP2
                SET     [8] = NULL
                WHERE   [8] = 0
                UPDATE  #TMP2
                SET     [9] = NULL
                WHERE   [9] = 0
                UPDATE  #TMP2
                SET     [10] = NULL
                WHERE   [10] = 0
                UPDATE  #TMP2
                SET     [11] = NULL
                WHERE   [11] = 0
                UPDATE  #TMP2
                SET     [12] = NULL
                WHERE   [12] = 0
                SELECT  MS_N_XUONG,
                        MS_MAY ,
                        TEN_MAY ,
						CHU_KY_DO,
						NGAY_KT_CUOI,
                        [1] ,
                        [2] ,
                        [3] ,
                        [4] ,
                        [5] ,
                        [6] ,
                        [7] ,
                        [8] ,
                        [9] ,
                        [10] ,
                        [11] ,
                        [12] ,
                        CONVERT(NVARCHAR(10), ISNULL([R], 0)) + ','
                        + CONVERT(NVARCHAR(10), ISNULL([G], 0)) + ','
                        + CONVERT(NVARCHAR(10), ISNULL([B], 0)) AS [CL]
                FROM    #TMP2 T1
                        LEFT JOIN dbo.DON_VI_THOI_GIAN_MAU T2 ON T1.MS_DV_TG = T2.MS_DV_TG

            END
-- bao cao theo thang
        ELSE
            BEGIN
                DECLARE @TN DATE;
                SET @TN = @TU_NGAY;
                DECLARE @DN DATE;
                SET @DN = @DEN_NGAY; 
                DECLARE @sSql NVARCHAR(MAX)
                DECLARE @sSqlL NVARCHAR(MAX)
                DECLARE @sSqlUpdate NVARCHAR(MAX) = ''
                SET @sSql = ''
                WHILE @TN < = @DN
                    BEGIN
                        SET @sSql = @sSql + ' ['
                            + CAST(CONVERT(VARCHAR, @TN, 103) AS NVARCHAR(20))
                            + '],';
                        SET @sSqlUpdate = @sSqlUpdate + 'UPDATE #TMP1 SET ['
                            + CAST(CONVERT(VARCHAR, @TN, 103) AS NVARCHAR(20))
                            + '] = NULL WHERE ['
                            + CAST(CONVERT(VARCHAR, @TN, 103) AS NVARCHAR(20))
                            + '] = 0; ';
                        SET @TN = DATEADD(DAY, 1, @TN);
                    END
                SET @sSql = LEFT(@sSql, LEN(@sSql) - 1) 

                SET @sSqlL = 'SELECT pvt.* into #TMP1 FROM 
(SELECT T1.Ten_N_XUONG AS MS_N_XUONG,T1.MS_MAY,T1.TEN_MAY,T1.NGAY_KT_KE, CONVERT(varchar, T1.NGAY_KT_KE, 103) AS NGAY,T1.CHU_KY_DO,T1.NGAY_KT_CUOI,T1.MS_DV_TG FROM #temptt T1)
 A
		PIVOT
		(
			COUNT(A.NGAY_KT_KE)
			FOR A.NGAY IN (' + @sSql + ')
		)AS pvt
		' + @sSqlUpdate + '
		
		SELECT MS_N_XUONG ,MS_MAY,TEN_MAY,CHU_KY_DO,NGAY_KT_CUOI, ' + @sSql
                    + ',		
		CONVERT(NVARCHAR(10),ISNULL([R],0)) + '','' + CONVERT(NVARCHAR(10),ISNULL([G],0)) + '','' + CONVERT(NVARCHAR(10),ISNULL([B],0)) AS [CL]   FROM #TMP1 T1 LEFT JOIN dbo.DON_VI_THOI_GIAN_MAU T2 ON T1.MS_DV_TG = T2.MS_DV_TG ORDER BY MS_N_XUONG ,MS_MAY,TEN_MAY'
                EXEC(@sSqlL)
            END
    END