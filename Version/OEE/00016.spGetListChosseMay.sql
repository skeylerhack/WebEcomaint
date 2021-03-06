
ALTER PROCEDURE [dbo].[spGetListChosseMay]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@sBT nvarchar(50) ='TMPItemMayChooseadmin'
AS 
BEGIN
CREATE TABLE #TEMPItemMay (
[MS_MAY] [nvarchar] (30) NULL,
[StandardOutput] NUMERIC(18,2) NULL,
[MS_DV_TG_Output] [bigint] NULL,
[StandardSpeed] NUMERIC(18,2) NULL,
[MS_DV_TG_Speed] [bigint] NULL,
[DataCollectionCycle] [bigint] NULL,
[DownTimeRecord] [bigint] NULL,
[WorkingCycle] INT NULL,
 [NumberPerCyle] NUMERIC(18,2) NULL,
  [TimeSendMgs] NUMERIC(18,2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPItemMay SELECT  MS_MAY, StandardOutput, MS_DV_TG_Output, StandardSpeed,
       MS_DV_TG_Speed, DataCollectionCycle, DownTimeRecord, WorkingCycle,
       NumberPerCyle, TimeSendMgs  FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)
SELECT MS_MAY,TEN_MAY INTO #TMP FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu)	
SELECT CONVERT(BIT,0) AS CHON, A.MS_MAY,A.TEN_MAY,StandardSpeed,DataCollectionCycle,WorkingCycle,NumberPerCyle,A.TimeSendMgs INTO #TEMP FROM dbo.MAY A
INNER JOIN #TMP B ON B.MS_MAY = A.MS_MAY
ORDER BY A.TEN_MAY

UPDATE A
set A.CHON = 1
FROM #TEMP A
INNER JOIN #TEMPItemMay B ON B.MS_MAY = A.MS_MAY
SELECT * FROM #TEMP ORDER BY TEN_MAY
END	



