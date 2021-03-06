
-----------------------------------
ALTER PROCEDURE [dbo].[spGetGSTTBTDK]
    @NGAY_BAT_DAU DATETIME = '01/01/2020',
    @NGAY_KET_THUC DATETIME = '12/31/2020',
    @MS_NHA_XUONG NVARCHAR(50) = 'NM1' ,
    @MsHThong INT =-1,
    @MsLMay NVARCHAR(100) ='-1',
    @MsMay NVARCHAR(100) ='-1',
    @MS_LOAI_CV INT =-1,
    @iLoaiIn INT =-1,
    @USERNAME NVARCHAR(50) ='admin',
    @TYPELANG INT =0,
    @LoaiBC INT = 1
AS
    BEGIN
--@LoaiBC = 0 chi tiet
--@LoaiBC = 1 Tong


        SELECT  *
        INTO    #MAY_USER
        FROM    [dbo].[MGetMayUserNgay](@NGAY_KET_THUC, @USERNAME,
                                        @MS_NHA_XUONG, @MsHThong, -1, @MsLMay,
                                        '-1', @MsMay, @TYPELANG)

        SELECT TOP ( 100 ) PERCENT
                A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI AS NGAY_CUOI, A.CHU_KY,
                A.MS_DV_TG, A.NGAY_KE AS NGAY_BTKT
        INTO    #HIEU_CHUAN_KE
        FROM    dbo.MGetNgayHieuChuanKeBaoTri(@NGAY_BAT_DAU, @NGAY_KET_THUC,
                                              @USERNAME, @MS_NHA_XUONG,
                                              @MsHThong, @MsLMay, '-1', 1) AS A
        ORDER BY A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG,
                A.NGAY_KE

--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con
        DELETE  T1
        FROM    dbo.LOAI_BAO_TRI_QH
                INNER JOIN #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT
                INNER JOIN #HIEU_CHUAN_KE AS T2 ON T1.MS_MAY = T2.MS_MAY
                                                   AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT
        WHERE   DATEADD(DAY, CASE T1.MS_DV_TG
                               WHEN 2 THEN T1.CHU_KY * 7
                               WHEN 3 THEN T1.CHU_KY * 30
                               WHEN 4 THEN T1.CHU_KY * 365
                               ELSE T1.CHU_KY
                             END / 4, T1.NGAY_BTKT) >= T2.NGAY_BTKT
                AND DATEADD(DAY, -( CASE T1.MS_DV_TG
                                      WHEN 2 THEN T1.CHU_KY * 7
                                      WHEN 3 THEN T1.CHU_KY * 30
                                      WHEN 4 THEN T1.CHU_KY * 365
                                      ELSE T1.CHU_KY
                                    END / 4 ), T1.NGAY_BTKT) <= T2.NGAY_BTKT 
 
--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong PBT
        DELETE  T1
        FROM    dbo.LOAI_BAO_TRI_QH
                INNER JOIN #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT
                INNER JOIN PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY
                                                  AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT
        WHERE   DATEADD(DAY, CASE T1.MS_DV_TG
                               WHEN 2 THEN T1.CHU_KY * 7
                               WHEN 3 THEN T1.CHU_KY * 30
                               WHEN 4 THEN T1.CHU_KY * 365
                               ELSE T1.CHU_KY
                             END / 4, T1.NGAY_BTKT) >= T2.NGAY_BD_KH
                AND DATEADD(DAY, -( CASE T1.MS_DV_TG
                                      WHEN 2 THEN T1.CHU_KY * 7
                                      WHEN 3 THEN T1.CHU_KY * 30
                                      WHEN 4 THEN T1.CHU_KY * 365
                                      ELSE T1.CHU_KY
                                    END / 4 ), T1.NGAY_BTKT) <= T2.NGAY_BD_KH

--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong KHTT 
        DELETE  T1
        FROM    dbo.LOAI_BAO_TRI_QH
                INNER JOIN #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT
                INNER JOIN KE_HOACH_TONG_THE AS T2 ON T1.MS_MAY = T2.MS_MAY
                                                      AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT
        WHERE   DATEADD(DAY, CASE T1.MS_DV_TG
                               WHEN 2 THEN T1.CHU_KY * 7
                               WHEN 3 THEN T1.CHU_KY * 30
                               WHEN 4 THEN T1.CHU_KY * 365
                               ELSE T1.CHU_KY
                             END / 4, T1.NGAY_BTKT) >= T2.NGAY
                AND DATEADD(DAY, -( CASE T1.MS_DV_TG
                                      WHEN 2 THEN T1.CHU_KY * 7
                                      WHEN 3 THEN T1.CHU_KY * 30
                                      WHEN 4 THEN T1.CHU_KY * 365
                                      ELSE T1.CHU_KY
                                    END / 4 ), T1.NGAY_BTKT) <= T2.NGAY

--@LoaiBC = 0 Co xoa trong KHTT va PBT da lap
--@LoaiBC = 1 Khong xoa trong KHTT va PBT da lap
        BEGIN
	--Xóa bảo trì định kỳ đã lập bên kế hoạch tổng thể và phiếu bảo trì TRONG 1/4 CHU KY
            DELETE  T
            FROM    #HIEU_CHUAN_KE T
                    INNER JOIN dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY
                                                           AND T.MS_LOAI_BT = T1.MS_LOAI_BT
            WHERE   DATEADD(DAY, CASE T.MS_DV_TG
                                   WHEN 2 THEN T.CHU_KY * 7
                                   WHEN 3 THEN T.CHU_KY * 30
                                   WHEN 4 THEN T.CHU_KY * 365
                                   ELSE T.CHU_KY
                                 END / 4, T.NGAY_BTKT) >= T1.NGAY
                    AND DATEADD(DAY, -( CASE T.MS_DV_TG
                                          WHEN 2 THEN T.CHU_KY * 7
                                          WHEN 3 THEN T.CHU_KY * 30
                                          WHEN 4 THEN T.CHU_KY * 365
                                          ELSE T.CHU_KY
                                        END / 4 ), T.NGAY_BTKT) <= T1.NGAY 

            DELETE  T
            FROM    #HIEU_CHUAN_KE T
                    INNER JOIN dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY
                                                       AND T.MS_LOAI_BT = T1.MS_LOAI_BT
            WHERE   DATEADD(DAY, CASE T.MS_DV_TG
                                   WHEN 2 THEN T.CHU_KY * 7
                                   WHEN 3 THEN T.CHU_KY * 30
                                   WHEN 4 THEN T.CHU_KY * 365
                                   ELSE T.CHU_KY
                                 END / 4, T.NGAY_BTKT) >= T1.NGAY_BD_KH
                    AND DATEADD(DAY, -( CASE T.MS_DV_TG
                                          WHEN 2 THEN T.CHU_KY * 7
                                          WHEN 3 THEN T.CHU_KY * 30
                                          WHEN 4 THEN T.CHU_KY * 365
                                          ELSE T.CHU_KY
                                        END / 4 ), T.NGAY_BTKT) <= T1.NGAY_BD_KH 
        END	



        SELECT DISTINCT
                T.MS_MAY, MAY.TEN_MAY, T.MS_LOAI_BT, A.TEN_LOAI_BT,
                T.NGAY_CUOI, T.CHU_KY, T.NGAY_BTKT AS NGAY_KE, CONG_VIEC.MS_CV,
                CONG_VIEC.MO_TA_CV, MAY.NGAY_DUA_VAO_SD,
                CONG_VIEC.THOI_GIAN_DU_KIEN, CAU_TRUC_THIET_BI.MS_BO_PHAN,
                CAU_TRUC_THIET_BI.TEN_BO_PHAN, A.THU_TU, C.TEN_PT
        INTO    #KHBT_YEAR_TD
        FROM    #HIEU_CHUAN_KE T
                INNER JOIN #MAY_USER MAY ON T.MS_MAY = MAY.MS_MAY
                INNER JOIN LOAI_BAO_TRI A ON T.MS_LOAI_BT = A.MS_LOAI_BT
                INNER JOIN MAY_LOAI_BTPN_CONG_VIEC ON T.MS_MAY = MAY_LOAI_BTPN_CONG_VIEC.MS_MAY
                                                      AND T.MS_LOAI_BT = MAY_LOAI_BTPN_CONG_VIEC.MS_LOAI_BT
                INNER JOIN CONG_VIEC ON MAY_LOAI_BTPN_CONG_VIEC.MS_CV = CONG_VIEC.MS_CV
                INNER JOIN CAU_TRUC_THIET_BI ON MAY_LOAI_BTPN_CONG_VIEC.MS_MAY = CAU_TRUC_THIET_BI.MS_MAY
                                                AND MAY_LOAI_BTPN_CONG_VIEC.MS_BO_PHAN = CAU_TRUC_THIET_BI.MS_BO_PHAN
                LEFT JOIN dbo.MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG B ON B.MS_MAY = MAY_LOAI_BTPN_CONG_VIEC.MS_MAY
                                                              AND B.MS_LOAI_BT = MAY_LOAI_BTPN_CONG_VIEC.MS_LOAI_BT
                                                              AND B.MS_CV = MAY_LOAI_BTPN_CONG_VIEC.MS_CV
                                                              AND B.MS_BO_PHAN = MAY_LOAI_BTPN_CONG_VIEC.MS_BO_PHAN
                LEFT JOIN dbo.IC_PHU_TUNG C ON C.MS_PT = B.MS_PT
        WHERE   ( CONG_VIEC.MS_LOAI_CV = @MS_LOAI_CV
                  OR @MS_LOAI_CV = -1
                )
        SELECT DISTINCT
                TEMP.MS_MAY, TEMP.TEN_MAY,
                TEMP.MS_BO_PHAN + ' - ' + TEMP.TEN_BO_PHAN AS TEN_BO_PHAN,
                TEMP.MO_TA_CV, TEMP.TEN_PT,
                CONVERT(NVARCHAR(10), TEMP.CHU_KY) + ' '
                + CASE @TYPELANG
                    WHEN 0 THEN T2.TEN_DV_TG
                    WHEN 1 THEN T2.TEN_DV_TG_ANH
                    ELSE T2.TEN_DV_TG_HOA
                  END AS CHU_KY, TEMP.NGAY_CUOI, TEMP.NGAY_KE
        INTO    #TMPCV
        FROM    #KHBT_YEAR_TD AS TEMP
                LEFT JOIN MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG C ON TEMP.MS_MAY = C.MS_MAY
                                                              AND TEMP.MS_LOAI_BT = C.MS_LOAI_BT
                                                              AND TEMP.MS_CV = C.MS_CV
                                                              AND TEMP.MS_BO_PHAN = C.MS_BO_PHAN
                INNER JOIN CAU_TRUC_THIET_BI_CONG_VIEC D ON TEMP.MS_MAY = D.MS_MAY
                                                            AND TEMP.MS_BO_PHAN = D.MS_BO_PHAN
                                                            AND TEMP.MS_CV = D.MS_CV
                INNER JOIN V_MAY_LOAI_BTPN_CHU_KY_MAX T1 ON TEMP.MS_MAY = T1.MS_MAY
                                                            AND T1.MS_LOAI_BT = TEMP.MS_LOAI_BT
                INNER JOIN dbo.DON_VI_THOI_GIAN AS T2 ON T1.MS_DV_TG = T2.MS_DV_TG
                INNER JOIN dbo.CAU_TRUC_THIET_BI AS X ON D.MS_MAY = X.MS_MAY
                                                         AND D.MS_BO_PHAN = X.MS_BO_PHAN
        WHERE   TEMP.NGAY_KE BETWEEN @NGAY_BAT_DAU
                             AND     @NGAY_KET_THUC
        ORDER BY MS_MAY, TEN_BO_PHAN


		      --  SELECT  MS_MAY ,
        --        TEN_MAY ,
        --        MS_N_XUONG
        --INTO    #MAY_USER
        --FROM    [dbo].[MGetMayUserNgay](@DEN_NGAY, @USERNAME, @MS_NHA_XUONG,
        --                                @MS_HE_THONG, -1, @MS_LOAI_MAY, '-1',
        --                                @MS_MAY, @LANGUAGE);

        SELECT  T2.*,
                --dbo.MGetGiaTriThongSoGSTT(T2.MS_TS_GSTT) AS TEN_GT_GSTT ,
                '' AS TEN_GT_GSTT, T1.MS_N_XUONG
        INTO    #HC
        FROM    dbo.MGetHieuChuanKeGSTT(@NGAY_BAT_DAU, @NGAY_KET_THUC,
                                        @USERNAME, @MS_NHA_XUONG, @MsHThong,
                                        -1, @MsLMay, '-1', @MS_LOAI_CV, 1,
                                        @TYPELANG) T2
                INNER JOIN #MAY_USER T1 ON T1.MS_MAY = T2.MS_MAY
                INNER JOIN dbo.THONG_SO_GSTT T3 ON T3.MS_TS_GSTT = T2.MS_TS_GSTT
        WHERE   ( CONVERT(DATE, T2.NGAY_KE) BETWEEN CONVERT(DATE, @NGAY_BAT_DAU)
                                            AND     CONVERT(DATE, @NGAY_KET_THUC) ) 

        SELECT DISTINCT
                TEMP.MS_MAY, TEMP.TEN_MAY,
                TEMP.TEN_BO_PHAN,
                TEMP.TEN_TS_GSTT, TEMP.TEN_GT_GSTT, TEMP.CHU_KY_DO,
                TEMP.NGAY_KT_CUOI, MIN(TEMP.NGAY_KT_KE) AS NGAY_KT_KE
        INTO    #TMPGS
        FROM    ( SELECT	DISTINCT
                            T1.MS_MAY, T2.TEN_MAY,
                            T1.MS_BO_PHAN + ' - '
                            + CASE @TYPELANG
                                WHEN 0 THEN T3.TEN_BO_PHAN
                                WHEN 1
                                THEN ISNULL(NULLIF(T3.TEN_BO_PHAN_ANH, ''),
                                            T3.TEN_BO_PHAN)
                                ELSE ISNULL(NULLIF(T3.TEN_BO_PHAN_HOA, ''),
                                            T3.TEN_BO_PHAN)
                              END AS TEN_BO_PHAN, T2.TEN_TS_GSTT,
                            CONVERT(NVARCHAR(10), T1.CHU_KY_DO) + ' '
                            + T2.TEN_DV_TG AS CHU_KY_DO,
                            T2.NGAY_CUOI AS NGAY_KT_CUOI, T2.TEN_GT_GSTT,
                            T2.NGAY_KE AS NGAY_KT_KE, T1.MS_BO_PHAN
                  FROM      dbo.CAU_TRUC_THIET_BI_TS_GSTT T1
                            INNER JOIN #HC T2 ON T2.MS_MAY = T1.MS_MAY
                                                 AND T2.MS_BO_PHAN = T1.MS_BO_PHAN
                                                 AND T2.MS_TS_GSTT = T1.MS_TS_GSTT
                                                 AND T2.MS_TT = T1.MS_TT
                            INNER JOIN dbo.CAU_TRUC_THIET_BI T3 ON T3.MS_MAY = T1.MS_MAY
                                                              AND T3.MS_BO_PHAN = T1.MS_BO_PHAN
                  WHERE     T1.ACTIVE = 1
                ) TEMP
        GROUP BY TEMP.MS_MAY, TEMP.TEN_MAY, TEMP.TEN_BO_PHAN, TEMP.TEN_TS_GSTT,
                TEMP.MS_BO_PHAN, TEMP.CHU_KY_DO, TEMP.NGAY_KT_CUOI,
                TEMP.TEN_GT_GSTT
				
				


        IF @LoaiBC = 0
            BEGIN
                SELECT  ROW_NUMBER() OVER ( ORDER BY T.MS_MAY, T.SAPXEP, T.TEN_BO_PHAN, T.TEN_TS_GSTT, T.NGAY_KT_KE )
                        AS STT, T.MS_MAY, T.TEN_MAY, T.TEN_BO_PHAN,
                        T.TEN_TS_GSTT, CASE T.SAPXEP
                                         WHEN 1 THEN 'D C B A'
                                         ELSE ''
                                       END AS TEN_GT_GSTT, T.CHU_KY_DO,
                        T.NGAY_KT_CUOI, '' AS NGAY_KT, '' AS TG_TH,
                        '' AS NGUOI_TH, '' AS XN_DVSD, '' AS GHI_CHU
                FROM    ( SELECT DISTINCT
                                    MS_MAY, TEN_MAY, TEN_BO_PHAN, TEN_TS_GSTT,
                                    TEN_GT_GSTT, CHU_KY_DO, NGAY_KT_CUOI,
                                    NGAY_KT_KE, 1 AS SAPXEP
                          FROM      #TMPGS
                          UNION
                          SELECT DISTINCT
                                    MS_MAY, TEN_MAY, TEN_BO_PHAN, MO_TA_CV,
                                    TEN_PT, CHU_KY, NGAY_CUOI, NGAY_KE,
                                    0 AS SAPXEP
                          FROM      #TMPCV
                        ) T
                WHERE   T.SAPXEP = @iLoaiIn
                        OR @iLoaiIn = -1
                ORDER BY T.MS_MAY, T.SAPXEP, T.TEN_BO_PHAN, T.TEN_TS_GSTT,
                        T.NGAY_KT_KE
            END	
        ELSE
            BEGIN
                SELECT  ROW_NUMBER() OVER ( ORDER BY T.MS_MAY, T.SAPXEP ) AS STT,
                        T.MS_MAY,T.TEN_MAY, CASE T.SAPXEP
                                    WHEN 1 THEN 'GSTT'
                                    ELSE 'BTDK'
                                  END AS LOAI_BT, T.CHU_KY_DO, T.NGAY_KT_CUOI,T.SAPXEP,
                        NGAY_KT_KE INTO #TMPCHUNG
                FROM    ( SELECT DISTINCT
                                    MS_MAY, TEN_MAY, CHU_KY_DO, NGAY_KT_CUOI,
                                    NGAY_KT_KE, 1 AS SAPXEP
                          FROM      #TMPGS
                          UNION
                          SELECT DISTINCT
                                    MS_MAY, TEN_MAY, CHU_KY, NGAY_CUOI,
                                    NGAY_KE, 0 AS SAPXEP
                          FROM      #TMPCV
                        ) T
                WHERE   T.SAPXEP = @iLoaiIn
                        OR @iLoaiIn = -1
             
				SELECT A.STT, A.MS_MAY, A.TEN_MAY, A.LOAI_BT, A.CHU_KY_DO, A.NGAY_KT_CUOI,
                       A.NGAY_KT_KE,B.Ten_N_XUONG,B.TEN_HE_THONG,B.TEN_NHOM_MAY,B.NGAY_DUA_VAO_SD,''AS GHI_CHU FROM #TMPCHUNG A INNER JOIN #MAY_USER B ON B.MS_MAY = A.MS_MAY
					      ORDER BY A.MS_MAY, A.SAPXEP,A.NGAY_KT_KE
            END	
		
    END
