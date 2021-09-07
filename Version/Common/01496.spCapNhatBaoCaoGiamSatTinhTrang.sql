IF NOT EXISTS ( SELECT  *
                FROM    sys.objects
                WHERE   type = 'P'
                        AND name = 'spCapNhatBaoCaoGiamSatTinhTrang' )
    EXEC('CREATE PROCEDURE spCapNhatBaoCaoGiamSatTinhTrang AS BEGIN SET NOCOUNT ON; END')
GO
 --EXEC spCapNhatspBaoCaoGiamSatTinhTrang '2019', 'admin', '-1', -1, '-1',GSTTAdmin
ALTER PROCEDURE spCapNhatBaoCaoGiamSatTinhTrang
    @NAM NVARCHAR(5) ,
    @USERNAME NVARCHAR(50),
    @MS_NHA_XUONG NVARCHAR(50),
    @MS_HE_THONG INT,
    @MS_LOAI_MAY NVARCHAR(20),
	@sBTam NVARCHAR(200) ='GSTTAdmin'
AS
    BEGIN
	DECLARE @sSql NVARCHAR(4000)
        DECLARE @tNgay AS NVARCHAR(15) = '01/01/' + @NAM
        DECLARE @dNgay AS NVARCHAR(15) = '12/31/' + @NAM
        DECLARE @NgayHT DATETIME
        SET @NgayHT = GETDATE()

		DECLARE @Month CHAR(10);
		SET @Month = MONTH(GETDATE());
		SELECT MS_MAY,MS_BO_PHAN,MS_TS_GSTT,MS_TT, COUNT(*) AS SO_LUONG
		INTO #tempt
		 FROM [dbo].[MGetHieuChuanKeGSTT](@tNgay,GETDATE(),@USERNAME, @MS_NHA_XUONG,@MS_HE_THONG,-1, @MS_LOAI_MAY,'-1',-1, 1, 0) 
		WHERE   CONVERT(DATE, NGAY_KE) BETWEEN CONVERT(DATE, @tNgay)
													  AND CONVERT(DATE, GETDATE())
													  AND MONTH(NGAY_KE) = MONTH(GETDATE())
		GROUP BY MS_MAY,MS_BO_PHAN,MS_TS_GSTT,MS_TT
		set @sSql = '
UPDATE T1
SET
    T1.['+RTRIM(@Month)+'.1] = T1.['+RTRIM(@Month)+'] - T2.SO_LUONG,
	T1.['+RTRIM(@Month)+'] = T2.SO_LUONG
FROM
    '+@sBTam+' AS T1
    INNER JOIN #tempt AS T2 ON T1.MS_MAY = T2.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_TS_GSTT = T1.MS_TS_GSTT AND T2.MS_TT =T1.MS_tt
WHERE
    T1.['+RTRIM(@Month)+']>0	


		UPDATE t2
		SET t2.['+RTRIM(@Month)+'.1] = t2.['+RTRIM(@Month)+'],
		t2.['+RTRIM(@Month)+'] = 0
		FROM dbo.GSTTadmin t2
		WHERE NOT EXISTS (SELECT MS_MAY,MS_BO_PHAN,MS_TS_GSTT,MS_TT FROM  #tempt t1 WHERE t1.MS_MAY = t2.MS_MAY AND t1.MS_BO_PHAN = t2.MS_BO_PHAN AND t1.MS_TS_GSTT = t2.MS_TS_GSTT AND t1.MS_TT = t2.MS_TT)

UPDATE  '+@sBTam+'
SET ['+RTRIM(@Month)+'.1] = null
WHERE ['+RTRIM(@Month)+'.1] = 0	
'
	EXEC (@sSql)

--lấy tất cả các mấy đã đi giám sát trong năm đó
  SELECT  IDENTITY( INT, 1,1 ) AS STT,
                        pvt.*
INTO	#TMP
FROM (
        SELECT MS_MAY,MS_BO_PHAN,MS_TS_GSTT,MS_TT,T1.NGAY_KT AS NGAY_KE,MONTH(T1.NGAY_KT) AS THANG   FROM 
dbo.GIAM_SAT_TINH_TRANG T1 
INNER JOIN dbo.GIAM_SAT_TINH_TRANG_TS ON GIAM_SAT_TINH_TRANG_TS.STT = T1.STT
WHERE YEAR(T1.NGAY_KT) =@NAM
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
-- cập nhật vào bảng tạm những lần đi giám sát
DECLARE @n INT = 1;
WHILE @n <= MONTH(GETDATE())
BEGIN
SET @sSql ='
UPDATE T1
SET
T1.['+ RTRIM(CONVERT(CHAR(2),@n)) +'] = - T2.['+ RTRIM(CONVERT(CHAR(2),@n)) +']
FROM '+@sBTam+' AS T1
    INNER JOIN #TMP AS T2 ON T1.MS_MAY = T2.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_TS_GSTT = T1.MS_TS_GSTT AND T2.MS_TT =T1.MS_tt 
where T2.['+ RTRIM(CONVERT(CHAR(2),@n)) +'] > 0'
	 EXEC (@sSql)
	 SET @n = @n + 1;
END
END