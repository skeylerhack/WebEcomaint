IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spBaoCaoGiamSatTinhTrang' )
    EXEC('CREATE PROCEDURE spBaoCaoGiamSatTinhTrang AS BEGIN SET NOCOUNT ON; END')
GO
 --EXEC spBaoCaoGiamSatTinhTrang '2019', 'admin', '-1', -1, '-1',1,0
ALTER PROCEDURE spBaoCaoGiamSatTinhTrang
    @NAM NVARCHAR(5) ,
    @USERNAME NVARCHAR(50) ,
    @MS_NHA_XUONG NVARCHAR(50) ,
    @MS_HE_THONG INT ,
    @MS_LOAI_MAY NVARCHAR(20) ,
    @LoaiBC INT ,
    @LANGUAGE INT
AS
    BEGIN
--LOAIBT -1: TẤT CẢ	
--LOAIBT 1: Định Tính
--LOAIBT 0: định lượng
        DECLARE @tNgay AS NVARCHAR(15) = '01/01/' + @NAM
        DECLARE @dNgay AS NVARCHAR(15) = '12/31/' + @NAM
        DECLARE @NgayHT DATETIME
        SET @NgayHT = GETDATE()
        SELECT  A.*
        INTO    #MAY
        FROM    dbo.MGetMayUserNgay(@NgayHT, @USERNAME, @MS_NHA_XUONG, @MS_HE_THONG,
                                    -1, @MS_LOAI_MAY, '-1', '-1', @LANGUAGE) A


                SELECT  IDENTITY( INT, 1,1 ) AS STT,
                        pvt.*
INTO	#TMP
FROM (
        SELECT  DISTINCT
                T1.MS_MAY ,
                T4.TEN_MAY ,
				T1.MS_BO_PHAN + ' - ' + CASE @LANGUAGE WHEN 0 THEN T3.TEN_BO_PHAN
				 WHEN 1 THEN ISNULL(NULLIF(T3.TEN_BO_PHAN_ANH,''),T3.TEN_BO_PHAN) 
				 ELSE ISNULL(NULLIF(T3.TEN_BO_PHAN_HOA,''),T3.TEN_BO_PHAN) END AS TEN_BO_PHAN,			
				CASE @LANGUAGE WHEN 0 THEN T5.TEN_TS_GSTT
				 WHEN 1 THEN ISNULL(NULLIF(T5.TEN_TS_GSTT_ANH,''),T5.TEN_TS_GSTT) 
				 ELSE ISNULL(NULLIF(T5.TEN_TS_GSTT_HOA,''),T5.TEN_TS_GSTT) END AS TEN_TS_GSTT,
				 CASE T5.LOAI_TS WHEN 0 THEN N'Định Lượng'
				ELSE N'Định Tính' END AS LOAI_TS,
				 T1.CHU_KY_DO,
	CASE @LANGUAGE WHEN 0 THEN T6.TEN_DV_TG
				 WHEN 1 THEN ISNULL(NULLIF(T6.TEN_DV_TG_ANH,''),T6.TEN_DV_TG) 
				 ELSE ISNULL(NULLIF(T6.TEN_DV_TG_HOA,''),T6.TEN_DV_TG) END AS TEN_DV_TG,	
               T2.NGAY_CUOI,
			   T1.MS_BO_PHAN,T1.MS_TS_GSTT,T1.MS_TT ,
                T2.NGAY_KE,
				CONVERT(NVARCHAR(5), MONTH(T2.NGAY_KE)) AS THANG
        FROM    dbo.CAU_TRUC_THIET_BI_TS_GSTT T1
                INNER JOIN dbo.MGetHieuChuanKeGSTT(@tNgay,@dNgay,
                                                   @USERNAME, @MS_NHA_XUONG,
                                                   @MS_HE_THONG, @MS_LOAI_MAY,-1,
                                                   '-1', -1,1,0) T2 ON T2.MS_MAY = T1.MS_MAY
                                                              AND T2.MS_BO_PHAN = T1.MS_BO_PHAN
                                                              AND T2.MS_TS_GSTT = T1.MS_TS_GSTT
                                                              AND T2.MS_TT = T1.MS_TT
                INNER JOIN dbo.CAU_TRUC_THIET_BI T3 ON T3.MS_MAY = T1.MS_MAY
                                                       AND T3.MS_BO_PHAN = T1.MS_BO_PHAN
                INNER JOIN #MAY T4 ON T4.MS_MAY = T1.MS_MAY
				INNER JOIN dbo.THONG_SO_GSTT T5 ON T5.MS_TS_GSTT = T1.MS_TS_GSTT
				INNER JOIN dbo.DON_VI_THOI_GIAN T6 ON T6.MS_DV_TG = T1.MS_DV_TG
        WHERE   T1.ACTIVE = 1
                AND CONVERT(DATE, T2.NGAY_KE) BETWEEN CONVERT(DATE, @tNgay)
                                              AND     CONVERT(DATE, @dNgay)
				AND (T5.LOAI_TS = @LoaiBC OR @LoaiBC = '-1')

)A PIVOT
( COUNT(A.NGAY_KE) FOR A.THANG IN ( [1], [2], [3], [4], [5], [6],
                                               [7], [8], [9], [10], [11], [12] ))AS pvt	
    UPDATE  #TMP
                SET     [1] = NULL
                WHERE   [1] = 0
                UPDATE  #TMP
                SET     [2] = NULL
                WHERE   [2] = 0
                UPDATE  #TMP
                SET     [3] = NULL
                WHERE   [3] = 0
                UPDATE  #TMP
                SET     [4] = NULL
                WHERE   [4] = 0
                UPDATE  #TMP
                SET     [5] = NULL
                WHERE   [5] = 0
                UPDATE  #TMP
                SET     [6] = NULL
                WHERE   [6] = 0
                UPDATE  #TMP
                SET     [7] = NULL
                WHERE   [7] = 0
                UPDATE  #TMP
                SET     [8] = NULL
                WHERE   [8] = 0
                UPDATE  #TMP
                SET     [9] = NULL
                WHERE   [9] = 0
                UPDATE  #TMP
                SET     [10] = NULL
                WHERE   [10] = 0
                UPDATE  #TMP
                SET     [11] = NULL
                WHERE   [11] = 0
                UPDATE  #TMP
                SET     [12] = NULL
                WHERE   [12] = 0
                SELECT  *
                FROM    #TMP 
    END