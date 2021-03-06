
ALTER PROC [dbo].[getDSThongSoGS]
	@MsNX NVARCHAR(100) = '-1',
	@MSHThong INT = -1,
	@MsLoaiMay NVARCHAR(100) = '-1',
	@MsMay NVARCHAR(100) = 'aaabbb'  ,
	@MsLoaiCV INT = -1,
	@UserName NVARCHAR(50) = 'ADMIN',
    @Dat BIT = 1,
	@BT NVARCHAR(100) = 'GIA_TRI_TMPADMIN'
AS
    BEGIN

CREATE TABLE #BTGT 
(
	[CHON] [BIT] NULL,
	[TEN_GIA_TRI] [NVARCHAR](255) NOT NULL,
	[DAT] [BIT] NULL,
	[GHI_CHU] [NVARCHAR](255) NULL,
	[STT] [INT] NOT NULL,
	[MS_MAY] [NVARCHAR](30) NOT NULL,
	[MS_TS_GSTT] [NVARCHAR](10) NOT NULL,
	[MS_BO_PHAN] [NVARCHAR](50) NOT NULL,
	[MS_TT] [INT] NOT NULL,
	THOI_GIAN FLOAT,
	TG_TT FLOAT
)
DECLARE @sSql	NVARCHAR(MAX)
SELECT MS_MAY,TEN_MAY,MS_N_XUONG,MS_HE_THONG,MS_LOAI_MAY INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(),@UserName,@MsNX,@MSHThong,-1,@MsLoaiMay,'-1', @MsMay,0)

--insert bang tam vao trong de xu ly
SET @sSql	= 'INSERT INTO #BTGT ([CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT]) SELECT [CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],T1.[STT],T1.[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT] FROM ' + @BT + ' T1 INNER JOIN #MAY T2 ON T1.MS_MAY = T2.MS_MAY '
EXEC (@sSql)
		
		INSERT INTO #BTGT ([CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT])
        SELECT  DISTINCT
				CASE @Dat WHEN 1  THEN
					CASE T5.DAT WHEN 1 THEN 1 ELSE 0 END
				ELSE 
					CASE T5.DAT WHEN 0 THEN 1 ELSE 0 END 
				END	
				AS CHON
				,T5.TEN_GIA_TRI ,T5.DAT,T5.GHI_CHU,T5.STT,T1.MS_MAY ,T1.MS_TS_GSTT,T1.MS_BO_PHAN,T1.MS_TT,T1.THOI_GIAN,T1.THOI_GIAN AS TG_TT
        FROM    dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1
                INNER JOIN #MAY AS T2 ON T1.MS_MAY = T2.MS_MAY                
                INNER JOIN dbo.THONG_SO_GSTT AS T4 ON T1.MS_TS_GSTT = T4.MS_TS_GSTT
                INNER JOIN dbo.GIA_TRI_TS_GSTT AS T5 ON T4.MS_TS_GSTT = T5.MS_TS_GSTT
                INNER JOIN dbo.CAU_TRUC_THIET_BI AS T6 ON T1.MS_MAY = T6.MS_MAY
                                                          AND T1.MS_BO_PHAN = T6.MS_BO_PHAN
                                                          AND T2.MS_MAY = T6.MS_MAY
                
        WHERE   ( ISNULL(T1.ACTIVE, 0) = 1 )
                AND ( T4.LOAI_TS = 1)
                AND ( T2.MS_HE_THONG = @MSHThong OR  @MSHThong  = -1)
				--AND ( T2.MS_N_XUONG = @MsNX OR @MsNX = '-1')
				AND ( T2.MS_LOAI_MAY = @MsLoaiMay OR @MsLoaiMay = '-1')
                AND ( ISNULL(T4.MS_LOAI_CV, -99) = @MsLoaiCV OR -1 = @MsLoaiCV)                
				AND NOT EXISTS(SELECT * FROM #BTGT T10 WHERE T1.MS_MAY = T10.MS_MAY AND T1.MS_BO_PHAN = T10.MS_BO_PHAN AND T1.MS_TS_GSTT = T10.MS_TS_GSTT  AND T10.MS_TT = T1.MS_TT)



SET @sSql	= 'INSERT INTO '  +  @BT + ' ([CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT]) SELECT DISTINCT [CHON],[TEN_GIA_TRI],[DAT],[GHI_CHU],[STT],	[MS_MAY],[MS_TS_GSTT],[MS_BO_PHAN],[MS_TT],[THOI_GIAN],[TG_TT] FROM #BTGT T1 WHERE NOT EXISTS ( SELECT DISTINCT * FROM ' +  @BT + ' T10 WHERE T1.MS_MAY = T10.MS_MAY AND T1.MS_BO_PHAN = T10.MS_BO_PHAN AND T1.MS_TS_GSTT = T10.MS_TS_GSTT  AND T10.MS_TT = T1.MS_TT )'
EXEC (@sSql)

IF(@MsMay <>'-1')
BEGIN
SET @sSql	= 'UPDATE '  +  @BT + ' SET CHON = 1 FROM '  +  @BT + ' T1 WHERE ISNULL(DAT,0) = ' +  CONVERT(NVARCHAR,@Dat) + ' 
AND (MS_MAY = '''+@MsMay+''' OR '''+@MsMay+''' = ''-1'')'
EXEC (@sSql)
END
ELSE
BEGIN
SET @sSql	= 'UPDATE '  +  @BT + ' SET CHON = 1 FROM '  +  @BT + ' T1 WHERE ISNULL(DAT,0) = ' +  CONVERT(NVARCHAR,@Dat) + ' AND 
NOT EXISTS (SELECT DISTINCT MS_MAY,MS_BO_PHAN,MS_TS_GSTT,MS_TT FROM '  +  @BT + ' T2 WHERE CHON = 1
AND T1.MS_MAY = T2.MS_MAY AND T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.MS_TS_GSTT = T2.MS_TS_GSTT  AND T2.MS_TT = T1.MS_TT )  '
EXEC (@sSql)
END	
END

