IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditProDucRun')
exec('CREATE PROCEDURE spEditProDucRun AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditProDucRun]
	@IDPro BIGINT = -1,
	@MS_MAY NVARCHAR(30) = '2020-09-08 14:11:18.667',
	@CASTT  int = '2020-09-08 14:11:18.667',
	@OperatorID  BIGINT =5,
	@StartTime DATETIME,
	@EndTime DATETIME,
	@sBT NVARCHAR(500)='TMPProDucDetailsadmin'
AS 
BEGIN
CREATE TABLE #TEMPProRunDetails (
[ID] [bigint] NULL,
[ItemID] [bigint] NULL,
[POID] [bigint] NULL,
[AllocatedQuantity]  [numeric] (18, 2) NULL,
[ActualQuantity]  [numeric] (18, 2) NULL,
[DefectQuantity]  [numeric] (18, 2) NULL,
[ActualSpeed] [numeric] (18, 2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPProRunDetails SELECT * FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)

UPDATE dbo.ProductionRun
SET CaSTT =@CASTT,OperatorID=@OperatorID,StartTime = @StartTime,EndTime =@EndTime

UPDATE A
SET 
A.AllocatedQuantity =B.AllocatedQuantity,
A.ActualQuantity =B.ActualQuantity,
A.DefectQuantity =B.DefectQuantity,
A.ActualSpeed = B.ActualSpeed
FROM dbo.ProductionRunDetails A
INNER JOIN #TEMPProRunDetails B ON B.ID = A.ID
SELECT @IDPro
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetListProductionRunDetails')
exec('CREATE PROCEDURE spGetListProductionRunDetails AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetListProductionRunDetails]
	@ProductionRunID BIGINT =1,
	@USERNAME NVARCHAR(250) ='admin',
	@NNgu INT = 0
AS 
BEGIN
SELECT  ID,ItemID, POID,AllocatedQuantity,
       ActualQuantity, DefectQuantity, ActualSpeed FROM dbo.ProductionRunDetails WHERE ProductionRunID = @ProductionRunID
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetListProductionRun')
exec('CREATE PROCEDURE spGetListProductionRun AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetListProductionRun]
	@TuNgay DATE = '10/19/2020',
	@DenNgay DATE  ='10/31/2020',
	@USERNAME NVARCHAR(250) ='admin',
	@NNgu INT = 0
AS 
BEGIN
SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(@TuNgay,@username,'-1',-1,-1,'-1','-1','-1', @NNgu) A 
SELECT A.  ID,A.MS_MAY, CASE @NNgu WHEN 0 THEN B.TEN_MAY WHEN 1 THEN ISNULL(NULLIF(B.TEN_MAY_ANH,''),B.TEN_MAY) ELSE ISNULL(NULLIF(B.TEN_MAY_HOA,''),B.TEN_MAY) END AS TEN_MAY, StartTime, EndTime, CaSTT, OperatorID,ActualSpeed FROM dbo.ProductionRun A
INNER JOIN dbo.MAY B ON B.MS_MAY = A.MS_MAY
WHERE A.StartTime BETWEEN @TuNgay AND @DenNgay
END	

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spSaveProductionRun')
exec('CREATE PROCEDURE spSaveProductionRun AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spSaveProductionRun]
	@sBT nvarchar(100) ='TMPProDucRunadmin'
AS 
BEGIN
CREATE TABLE #PROOD
(
ProductionRunID BIGINT NULL,
[MS_MAY] [nvarchar] (30) NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[CaSTT] [int] NULL,
[OperatorID] [bigint] NULL,
[POID] [bigint] NULL,
[ItemID] [bigint] NULL,
[StandardSpeed] [numeric] (18, 2) NULL,
[StandardOutput] [numeric] (18, 2) NULL,
[AllocatedQuantity] [numeric] (18, 2) NULL,
[ActualQuantity] [numeric] (18, 2) NULL,
[DefectQuantity] [numeric] (18, 2) NULL,
[ActualSpeed] [numeric] (18, 2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO	#PROOD	 ( MS_MAY, StartTime, EndTime, CaSTT, OperatorID, POID,
                       ItemID,StandardSpeed, StandardOutput, AllocatedQuantity,
                      ActualQuantity, DefectQuantity, ActualSpeed ) SELECT * FROM ' + @SBT 
EXEC (@sSql)
--set @sSql = 'DROP TABLE ' + @SBT
--EXEC (@sSql)
INSERT INTO	dbo.ProductionRun ( MS_MAY, CaSTT, OperatorID, StartTime, EndTime,
                             ActualSpeed )
SELECT DISTINCT MS_MAY,CaSTT,OperatorID,StartTime,EndTime, SUM(ActualSpeed) FROM #PROOD GROUP BY MS_MAY,CaSTT,OperatorID,StartTime,EndTime
UPDATE a
SET a.ProductionRunID = b.ID
FROM #PROOD a INNER JOIN dbo.ProductionRun b ON b.MS_MAY = a.MS_MAY AND b.StartTime = a.StartTime AND b.EndTime = a.EndTime

INSERT INTO dbo.ProductionRunDetails ( ProductionRunID, ItemID, POID,
                                        DetailsID, AllocatedQuantity,
                                        ActualQuantity, DefectQuantity,
                                        ActualSpeed )
SELECT ProductionRunID,ItemID,POID,NULL,AllocatedQuantity,ActualQuantity,DefectQuantity,ActualSpeed FROM #PROOD
END




GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetProductOrDer')
exec('CREATE PROCEDURE spGetProductOrDer AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetProductOrDer]
	@MS_MAY NVARCHAR(30) ='-1'
AS 
BEGIN
SELECT DISTINCT A.ID,PrOrNumber FROM dbo.ProductionOrder A
INNER JOIN dbo.PrODetails B ON B.PROID = A.ID
WHERE	B.MS_MAY = @MS_MAY OR @MS_MAY ='-1'
ORDER BY A.PrOrNumber
END	



GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetMayItem')
exec('CREATE PROCEDURE spGetMayItem AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetMayItem]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@Item INT =1
---- @Item = 1 them item
---- @Item = 0 theo pro details
AS 
BEGIN
IF @Item = 1
BEGIN
SELECT DISTINCT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	INNER JOIN dbo.ItemMay ON ItemMay.MS_MAY = A.MS_MAY ORDER BY A.TEN_MAY
END

IF @Item = 0
BEGIN
SELECT DISTINCT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	INNER JOIN dbo.PrODetails ON PrODetails.MS_MAY = A.MS_MAY ORDER BY A.TEN_MAY
END



END	



GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetcbOperator')
exec('CREATE PROCEDURE spGetcbOperator AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetcbOperator]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT ID, OperatorName FROM dbo.Operator
UNION SELECT -1 AS ID,'< All >'AS Operator
ORDER BY OperatorName
END
ELSE
BEGIN
SELECT ID,OperatorName FROM dbo.Operator
ORDER BY OperatorName
END	
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spOperator')
exec('CREATE PROCEDURE spOperator AS BEGIN SET NOCOUNT ON; END')
GO
ALTER	PROCEDURE [dbo].[spOperator]
	@Loai NVARCHAR(50) = 'grd',
	@ID BIGINT = 3,
	@OperatorName NVARCHAR(250) = '-1',
	@OperatorCode NVARCHAR(50) = '-1',
	@CardID INT ='-1',
	@Note NVARCHAR(500) = '-1'
AS
BEGIN


--Get luoi 
IF UPPER(@Loai) = UPPER('Grd')
BEGIN
   SELECT ID, OperatorName,OperatorCode, CardID,
          Note FROM dbo.Operator ORDER BY OperatorName
END

--Save
IF UPPER(@Loai) = UPPER('Save')
BEGIN
--THEM
	IF @ID = -1
	BEGIN
		INSERT INTO	dbo.Operator(OperatorCode, OperatorName, CardID,
          Note)
		VALUES(@OperatorCode, @OperatorName, @CardID,
          @Note)
		SELECT SCOPE_IDENTITY();
	END
--SUA
	ELSE
	BEGIN
		UPDATE dbo.Operator SET OperatorCode = @OperatorCode,OperatorName = @OperatorName,CardID=@CardID, Note = @Note
		WHERE ID = @ID
		SELECT @ID;
	END
	END

--Delete 
IF UPPER(@Loai) = UPPER('Delete')
BEGIN
	IF EXISTS (SELECT	* FROM dbo.ProductionRun WHERE OperatorID = @ID)
	BEGIN
		SELECT 1 AS TT		
	END
	ELSE
	BEGIN
		DELETE dbo.Operator WHERE ID = @ID
		DBCC CHECKIDENT (ItemGroup,RESEED,0)
		DBCC CHECKIDENT (ItemGroup,RESEED)
		SELECT 0 AS TT		
	END
END	
END


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCTTBThongSoDenNgay_T')
exec('CREATE PROCEDURE GetCTTBThongSoDenNgay_T AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[GetCTTBThongSoDenNgay_T]
    @MS_MAY NVARCHAR(30) = 'MCLT3G' ,
    @MS_LOAI_CV INT = '1' ,
    @DenNgay DATETIME = '02/2/2020'
AS
SELECT * INTO #TS  FROM (
SELECT @MS_MAY MS_BO_PHAN,@MS_MAY TEN_BO_PHAN,NULL MS_BO_PHAN_CHA, CONVERT(NVARCHAR(10),NULL) AS MS_TS_GSTT, @MS_MAY AS MSBP

UNION
SELECT T1.MS_BO_PHAN, T1.MS_BO_PHAN + ' - ' + T1.TEN_BO_PHAN ,T1.MS_BO_PHAN_CHA, NULL AS MS_TS_GSTT,T1.MS_BO_PHAN AS MSBP
FROM            dbo.CAU_TRUC_THIET_BI AS T1 --INNER JOIN dbo.CAU_TRUC_THIET_BI_TS_GSTT T2 ON T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_MAY = T1.MS_MAY
WHERE T1.MS_MAY = @MS_MAY

UNION
--SELECT NULL, T2.TEN_TS_GSTT, T1.MS_BO_PHAN , T1.MS_TS_GSTT, T1.MS_BO_PHAN AS MSBP
--FROM CAU_TRUC_THIET_BI_TS_GSTT T1 INNER JOIN dbo.THONG_SO_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT
-- WHERE T1.MS_MAY = @MS_MAY AND T2.LOAI_TS = 1
-- AND ( ISNULL(MS_LOAI_CV, -99) = @MS_LOAI_CV
--                  OR @MS_LOAI_CV = -1)) T1;


				   SELECT DISTINCT  NULL, T1.TEN_TS_GSTT, T1.MS_BO_PHAN , T1.MS_TS_GSTT, T1.MS_BO_PHAN AS MSBP  FROM [dbo].[MGetHieuChuanKeGSTT]('01/01/2020',@DenNgay,'admin','-1',-1,-1,'-1','-1',@MS_LOAI_CV,0,0) T1 INNER JOIN dbo.THONG_SO_GSTT T2 ON T1.MS_TS_GSTT = T2.MS_TS_GSTT				   
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

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'getAllUsersOEE')
exec('CREATE PROCEDURE getAllUsersOEE AS BEGIN SET NOCOUNT ON; END')
GO
 ALTER PROCEDURE [dbo].[getAllUsersOEE]
	@NNgu INT =0
 AS 
 BEGIN
 SELECT A.USERNAME ,
        A.FULL_NAME ,
        B.GROUP_NAME,
        A.DESCRIPTION ,
        A.GROUP_ID,
        HO + ' ' + TEN AS HO_TEN ,
        D.TIME_LOGIN
 FROM   dbo.USERS AS A
        INNER JOIN dbo.NHOM AS B ON B.GROUP_ID = A.GROUP_ID
        LEFT JOIN CONG_NHAN C ON C.MS_CONG_NHAN = A.MS_CONG_NHAN
        LEFT JOIN dbo.LOGIN D ON a.USERNAME = D.USER_LOGIN
 ORDER BY D.TIME_LOGIN DESC ,
        B.GROUP_NAME ,
        A.USERNAME 
 END

 

 
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetMenuPQOEE')
exec('CREATE PROCEDURE spGetMenuPQOEE AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetMenuPQOEE]
		@ID_NHOM BIGINT = 1,
		@Them BIT= 1,
		@NNgu INT =0
AS 
BEGIN
SELECT MENU_ID, CASE @NNgu WHEN 0 THEN MENU_TEXT WHEN 1 THEN ISNULL(NULLIF(MENU_ENGLISH,''),MENU_TEXT) ELSE ISNULL(NULLIF(MENU_CHINESE,''),MENU_TEXT) END AS TEN_MENU, MENU_PARENT AS  [ROOT], AN_HIEN AS  HIDE,MENU_INDEX AS STT_MENU INTO #MENUTMP FROM MENU_OEE
SELECT CONVERT(BIT,0) AS CHON,T.MS_CHA, T.ID_MENU, T.TEN_MENU, T.STT_MENU,CONVERT(INT,1) AS ID_PERMISION INTO	#TEMPT  FROM (
SELECT   NULL AS MS_CHA, CONVERT(NVARCHAR(250),'-1') AS  ID_MENU,CONVERT(NVARCHAR(250),'VietSoft - OEE') AS TEN_MENU  ,-1 AS STT_MENU
UNION   
SELECT   '-1' AS MS_CHA, CONVERT(NVARCHAR(50),MENU_ID) ,TEN_MENU, STT_MENU FROM #MENUTMP WHERE ISNULL([ROOT],'') = '' 
UNION   
SELECT CONVERT(NVARCHAR(250),[ROOT]) AS MS_CHA,CONVERT(NVARCHAR(250),MENU_ID),TEN_MENU, STT_MENU FROM #MENUTMP WHERE    [ROOT] IN (SELECT MENU_ID FROM #MENUTMP WHERE ISNULL([ROOT],'') = '')   
UNION 
SELECT    CONVERT(NVARCHAR(250),[ROOT]) AS MS_CHA,CONVERT(NVARCHAR(250),MENU_ID),TEN_MENU, STT_MENU FROM #MENUTMP WHERE  [ROOT] IN (SELECT MENU_ID   FROM #MENUTMP WHERE   [ROOT] IN(SELECT MENU_ID FROM #MENUTMP WHERE ISNULL([ROOT],'') = ''))    
UNION  
SELECT    CONVERT(NVARCHAR(250),[ROOT]) AS MS_CHA,CONVERT(NVARCHAR(250),MENU_ID),TEN_MENU, STT_MENU FROM #MENUTMP WHERE  [ROOT] IN   (  SELECT MENU_ID FROM #MENUTMP WHERE  [ROOT] IN (SELECT MENU_ID   FROM #MENUTMP WHERE   [ROOT] IN(SELECT MENU_ID FROM #MENUTMP WHERE ISNULL([ROOT],'') = '')) )
)T


UPDATE a
SET CHON = 1,ID_PERMISION = dbo.NHOM_MENU_OEE.ID_PERMISION
FROM #TEMPT a INNER JOIN dbo.NHOM_MENU_OEE ON dbo.NHOM_MENU_OEE.MENU_ID = a.ID_MENU AND GROUP_ID =@ID_NHOM
WHERE EXISTS
 (
    SELECT b.GROUP_ID,b.MENU_ID,ID_PERMISION
      FROM dbo.NHOM_MENU_OEE AS b
      WHERE @ID_NHOM = b.GROUP_ID AND a.ID_MENU =b.MENU_ID
  );
  IF(@Them = 1)
  SELECT * FROM #TEMPT
  ELSE
  SELECT * FROM #TEMPT WHERE CHON =1
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditNhomUser')
exec('CREATE PROCEDURE spEditNhomUser AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditNhomUser]
@GROUP_ID INT ='1',
@GROUP_NAME NVARCHAR(50) ='HCM - Administrator',
@DESCRIPTION NVARCHAR(100) = 'aa',
@sBT NVARCHAR(50) ='BTUseradmin'
AS 
BEGIN
CREATE TABLE #TEMUSER (
[USERNAME] [nvarchar] (50),
[FULL_NAME] [nvarchar] (50) ,
[DESCRIPTION] [nvarchar] (100) ,
[MS_TO] [int] NULL,
[USER_MAIL] [nvarchar] (150) ,
[MS_CONG_NHAN] [nvarchar] (9) ,
[ACTIVE] [bit] NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
SET @sSql = 'INSERT INTO #TEMUSER(USERNAME, FULL_NAME, DESCRIPTION, MS_TO, USER_MAIL,
                        MS_CONG_NHAN, ACTIVE ) SELECT USERNAME, FULL_NAME, DESCRIPTION, MS_TO, USER_MAIL,
                        MS_CONG_NHAN, ACTIVE  FROM ' + @sBT
EXEC (@sSql)
--set @sSql = 'DROP TABLE ' + @sBT
--EXEC (@sSql)
IF @GROUP_ID = -1
BEGIN
-- them itemmay
INSERT INTO dbo.NHOM ( GROUP_NAME, DESCRIPTION, TYPE_LIC )
VALUES  (@GROUP_NAME,@DESCRIPTION,NULL)
SET @GROUP_ID =( SELECT SCOPE_IDENTITY() )
END
ELSE
BEGIN
--sua item may
UPDATE dbo.NHOM
SET GROUP_NAME =@GROUP_NAME,
DESCRIPTION = @DESCRIPTION
WHERE GROUP_ID =@GROUP_ID
END	

IF (SELECT COUNT(*) FROM #TEMUSER) > 0
BEGIN
UPDATE A
SET A.FULL_NAME = B.FULL_NAME,
	A.DESCRIPTION = B.DESCRIPTION,
	A.MS_TO = B.MS_TO,
	A.USER_MAIL = B.USER_MAIL,
	A.MS_CONG_NHAN = B.MS_CONG_NHAN,
	A.ACTIVE = B.ACTIVE
FROM dbo.USERS A
INNER JOIN #TEMUSER B ON B.USERNAME = A.USERNAME

INSERT INTO	dbo.USERS ( USERNAME, GROUP_ID, FULL_NAME, PASS, DESCRIPTION,
                         MS_TO, USER_MAIL, MS_CONG_NHAN, ACTIVE )
SELECT A.USERNAME,@GROUP_ID,A.FULL_NAME,N'̨̦̪',A.DESCRIPTION,A.MS_TO,A.USER_MAIL,A.MS_CONG_NHAN,A.ACTIVE FROM #TEMUSER A WHERE NOT EXISTS (SELECT * FROM dbo.USERS B 
WHERE B.USERNAME =A.USERNAME)
END	
SELECT @GROUP_ID
END	



GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GET_MENU_OF_PARENT_OEE')
exec('CREATE PROCEDURE SP_GET_MENU_OF_PARENT_OEE AS BEGIN SET NOCOUNT ON; END')
GO
ALTER procedure [dbo].[SP_GET_MENU_OF_PARENT_OEE]
@MENU_ID NVARCHAR (128) ='mnuMasterData',
@USERNAME NVARCHAR (128) ='admin'
AS
BEGIN
SELECT dbo.MENU.MENU_ID, dbo.MENU.MENU_TEXT, dbo.MENU.MENU_ENGLISH, dbo.MENU.MENU_CHINESE, dbo.MENU.MENU_PARENT,dbo.MENU.MENU_LINE, dbo.MENU.MENU_INDEX, dbo.MENU.SHORT_KEY, dbo.MENU.DLL_NAME, dbo.MENU.PROJECT_NAME, 
dbo.MENU.CLASS_NAME, dbo.MENU.FUNCTION_NAME, dbo.MENU.MENU_NOTE, 1 AS ID_PERMISION
FROM dbo.MENU 
INNER JOIN dbo.NHOM_MENU ON NHOM_MENU.MENU_ID = MENU.MENU_ID 
INNER JOIN dbo.USERS ON dbo.NHOM_MENU.GROUP_ID = dbo.USERS.GROUP_ID
WHERE dbo.MENU.MENU_PARENT = @MENU_ID AND dbo.USERS.USERNAME = @USERNAME
AND ISNULL(AN_HIEN, 0) = 1 AND MENU_TYPE = -1
ORDER BY dbo.MENU.MENU_INDEX

END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditProDucOrDer')
exec('CREATE PROCEDURE spEditProDucOrDer AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditProDucOrDer]
	@IDPro BIGINT = -1,
	@PrOrNumber  nvarchar(50) ='LSX-001',
	@OrderDate  DATETIME = '2020-09-08 14:11:18.667',
	@StartDate  DATETIME = '2020-09-08 14:11:18.667',
	@DueDate  DATETIME = '2020-09-08 14:11:18.667',
	@ItemID  BIGINT =5,
	@ItemDescription  nvarchar(50) ='aaa',
	@PlannedQuantity  NUMERIC(18,2) =2.3,
	@ActualQty  NUMERIC(18,2) =4.5,
	@ItemUOM  BIGINT =3,
	@Status  BIGINT =3,
	@OriginPrOID  BIGINT = NULL,
	@Stage  BIGINT =8,
	@sBT NVARCHAR(500)='TMPProDucDetailsadmin'
AS 
BEGIN
CREATE TABLE #TEMPProDuctDetails (
[ID] [bigint] NOT NULL ,
[PROID] [bigint] NOT NULL,
[MS_MAY] [nvarchar] (30) ,
[AllocatedQuantity] [numeric] (18, 2) NULL,
[PlannedStartTime] [datetime] NULL,
[DueTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[CaSTT] [int] NULL,
[StandardSpeed] [numeric] (18, 2) NULL,
[StandardOutput] [numeric] (18, 2) NULL,
[ActualQuantity] [numeric] (18, 2) NULL,
[WorkingCycle] [int] NULL,
[NumberPerCycle] [numeric] (18, 2) NULL,
[DownTimeRecord] [numeric] (18, 2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPProDuctDetails SELECT * FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)
IF @IDPro = -1
BEGIN
-- them itemmay
INSERT INTO dbo.ProductionOrder(PrOrNumber, OrderDate, StartDate, DueDate,
                                   ItemID, ItemDescription, PlannedQuantity,
                                   ActualQty, ItemUOM, [Status], OriginPrOID,
                                   Stage)
VALUES  ( @PrOrNumber, @OrderDate, @StartDate, @DueDate,
                                   @ItemID, @ItemDescription, @PlannedQuantity,
                                   @ActualQty, @ItemUOM, @Status, @OriginPrOID,
                                   @Stage)

SET @IDPro =( SELECT SCOPE_IDENTITY() )
END
ELSE
BEGIN
--sua item may
UPDATE dbo.ProductionOrder
SET 
PrOrNumber=@PrOrNumber,
OrderDate=@OrderDate,
StartDate=@StartDate,
DueDate =@DueDate,
ItemID =@ItemID,
ItemDescription =@ItemDescription,
PlannedQuantity = @PlannedQuantity,
ActualQty = @ActualQty,
ItemUOM= @ItemUOM,
Status=@Status,
OriginPrOID=@OriginPrOID,
Stage=@Stage
WHERE ID =@IDPro
END	
IF (SELECT COUNT(*) FROM #TEMPProDuctDetails) > 0
BEGIN

UPDATE A

SET A.AllocatedQuantity=B.AllocatedQuantity,
A.MS_MAY =B.MS_MAY,
A.MS_HE_THONG = (SELECT TOP 1 MS_HE_THONG FROM dbo.MAY_HE_THONG WHERE MS_MAY = A.MS_MAY),
A.PlannedStartTime=B.PlannedStartTime,
A.DueTime=B.DueTime, 
A.EndTime=B.EndTime,
A.CaSTT = B.CaSTT,
A.StandardSpeed=B.StandardSpeed,
A.StandardOutput=B.StandardOutput,
A.ActualQuantity=B.ActualQuantity,
A.WorkingCycle=B.WorkingCycle,
A.NumberPerCycle=B.NumberPerCycle,
A.DownTimeRecord=B.NumberPerCycle
FROM dbo.PrODetails A
INNER JOIN #TEMPProDuctDetails B ON B.ID = A.ID
INSERT INTO	dbo.PrODetails ( PROID, MS_MAY,MS_HE_THONG, AllocatedQuantity, PlannedStartTime,
                          DueTime, EndTime, CaSTT, StandardSpeed,
                          StandardOutput, ActualQuantity, WorkingCycle,
                          NumberPerCycle, DownTimeRecord )
SELECT @IDPro, A.MS_MAY,(SELECT TOP 1 MS_HE_THONG FROM dbo.MAY_HE_THONG WHERE MS_MAY = A.MS_MAY), A.AllocatedQuantity, A.PlannedStartTime,
       A.DueTime, A.EndTime, A.CaSTT, A.StandardSpeed, A.StandardOutput,
       A.ActualQuantity, A.WorkingCycle, A.NumberPerCycle, A.DownTimeRecord FROM #TEMPProDuctDetails A WHERE NOT EXISTS (SELECT * FROM dbo.PrODetails B 
WHERE B.ID =A.ID)
END	
SELECT @IDPro
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetItem')
exec('CREATE PROCEDURE spGetItem AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetItem]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll INT=2,
	@MS_MAY NVARCHAR(30) ='BTA-04-02'
AS 
---- @CoAll = 1 có all 
---- @CoAll = 0  
---- @CoAll = 2 lấy theo máy item
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM (SELECT ID,ItemName  FROM dbo.Item
UNION
SELECT -1,N'< ALL >') A
ORDER BY A.ItemName
END
ELSE
IF	@CoAll = 0
BEGIN
SELECT ID,ItemName  FROM dbo.Item
ORDER BY ItemName
END	
ELSE
BEGIN
------------lấy theo máy Item theo msMay
SELECT ID,ItemName  FROM dbo.Item A
INNER JOIN dbo.ItemMay B ON B.ItemID = A.ID
WHERE B.MS_MAY = @MS_MAY
ORDER BY ItemName
END

END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetSatusProDuct')
exec('CREATE PROCEDURE spGetSatusProDuct AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetSatusProDuct]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM (SELECT ID, CASE @NNgu WHEN 0 THEN NAME_STATUS WHEN 1 THEN ISNULL(NAME_STATUS_A,NAME_STATUS) WHEN 2 THEN	 ISNULL(NAME_STATUS_H,NAME_STATUS) END AS NAME_STATUS  FROM dbo.SatusProDuct
UNION
SELECT -1,N'< ALL >') A
ORDER BY A.ID
END
ELSE
BEGIN
SELECT ID, CASE @NNgu WHEN 0 THEN NAME_STATUS WHEN 1 THEN ISNULL(NAME_STATUS_A,NAME_STATUS) WHEN 2 THEN	 ISNULL(NAME_STATUS_H,NAME_STATUS) END AS NAME_STATUS  FROM dbo.SatusProDuct
ORDER BY ID
END	
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditGroupDetails')
exec('CREATE PROCEDURE spEditGroupDetails AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditGroupDetails]
	@ID [bigint],
	@GroupName [nvarchar](250),
	@GroupNameA [nvarchar](250),
	@GroupNameH [nvarchar](250),
	@BasedUOMID [bigint],
	@Note [nvarchar] (500), 
	@sBT NVARCHAR(50)
AS 
BEGIN
CREATE TABLE #TEMPGroupDetails (
[ID] [bigint] ,
[UOMConversionGroupID] [bigint],
[UOMID] [bigint],
[UOMQuantity] [numeric] (18, 2) ,
[BasedUOMID] [bigint],
[BasedUOMQuantity] [numeric] (18, 2),
[Note] [nvarchar] (500)
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPGroupDetails(ID,UOMConversionGroupID, UOMID,
                                             UOMQuantity,
                                             BasedUOMQuantity, Note ) SELECT ID,UOMConversionGroupID, UOMID,
                                             UOMQuantity,
                                             BasedUOMQuantity, Note FROM ' + @sBT

EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)
IF @ID = -1
BEGIN
-- them itemmay
INSERT INTO dbo.UOMConversionGroup ( GroupName,GroupNameA,GroupNameH, BasedUOMID, Note )
VALUES  (@GroupName,@GroupNameA,@GroupNameH,@BasedUOMID,@Note)
SET @ID = (SELECT SCOPE_IDENTITY())
END
ELSE
BEGIN
--sua item may
UPDATE dbo.UOMConversionGroup
SET GroupName =@GroupName,
GroupNameA =@GroupNameA,
GroupNameH =@GroupNameH,
BasedUOMID = @BasedUOMID,
Note = @Note
WHERE ID =@ID
END	

IF (SELECT COUNT(*) FROM #TEMPGroupDetails) > 0
BEGIN

UPDATE A
SET A.UOMID = B.UOMID,
	A.UOMQuantity = B.UOMQuantity,
	A.BasedUOMQuantity = B.BasedUOMQuantity,
	A.Note = B.Note
FROM dbo.UOMConversionGroupDetails A
INNER JOIN #TEMPGroupDetails B ON B.ID = A.ID

INSERT INTO	dbo.UOMConversionGroupDetails ( UOMConversionGroupID, UOMID,
                                             UOMQuantity,
                                             BasedUOMQuantity, Note )
SELECT @ID, A.UOMID, A.UOMQuantity,
       A.BasedUOMQuantity, A.Note FROM #TEMPGroupDetails A WHERE NOT EXISTS (SELECT * FROM dbo.UOMConversionGroupDetails B 
WHERE B.UOMConversionGroupID =@ID AND B.ID =A.ID)
END	
SELECT @ID
END	

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetUOMConversionGroupdetailByGroup')
exec('CREATE PROCEDURE spGetUOMConversionGroupdetailByGroup AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetUOMConversionGroupdetailByGroup]
@IDConversionGroup BIGINT =-1
AS 
BEGIN
SELECT A.ID,A.UOMQuantity,C.UOMName,A.BasedUOMQuantity,D.UOMName AS BasedUOMName FROM dbo.UOMConversionGroupDetails A 
INNER JOIN dbo.UOMConversionGroup B ON B.ID = A.UOMConversionGroupID
INNER JOIN dbo.UOM C ON C.ID = A.UOMID
INNER JOIN dbo.UOM D ON D.ID = B.BasedUOMID
WHERE A.UOMConversionGroupID = @IDConversionGroup OR @IDConversionGroup =-1
END



GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetcbUOM')
exec('CREATE PROCEDURE spGetcbUOM AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetcbUOM]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT ID,UOMName FROM dbo.UOM
ORDER BY UOMName
END
ELSE
BEGIN
SELECT ID,UOMName FROM dbo.UOM WHERE BasedUOM = 1
ORDER BY UOMName
END	
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spItemGroup')
exec('CREATE PROCEDURE spItemGroup AS BEGIN SET NOCOUNT ON; END')
GO
ALTER	PROCEDURE [dbo].[spItemGroup]
	@Loai NVARCHAR(50) = 'grd',
	@ID BIGINT = 3,
	@ItemGroupName NVARCHAR(250) = '-1',
	@ItemGroupNameA NVARCHAR(250) = '-1',
	@ItemGroupNameH NVARCHAR(250) = '-1',
	@Note NVARCHAR(500) = '-1'
AS
BEGIN


--Get luoi 
IF UPPER(@Loai) = UPPER('Grd')
BEGIN
   SELECT ID, ItemGroupName,ItemGroupNameA,ItemGroupNameH, Note FROM dbo.ItemGroup ORDER BY ItemGroupName
END

--Save
IF UPPER(@Loai) = UPPER('Save')
BEGIN
--THEM
	IF @ID = -1
	BEGIN
		INSERT INTO	dbo.ItemGroup(ItemGroupName,ItemGroupNameA,ItemGroupNameH, Note)
		VALUES(@ItemGroupName,@ItemGroupNameA,@ItemGroupNameH, @Note)
		SELECT SCOPE_IDENTITY();
	END
--SUA
	ELSE
	BEGIN
		UPDATE dbo.ItemGroup SET ItemGroupName = @ItemGroupName,ItemGroupNameA = @ItemGroupNameA,ItemGroupNameH = @ItemGroupNameH, Note = @Note
		WHERE ID = @ID
		SELECT @ID;
	END
	END

--Delete 
IF UPPER(@Loai) = UPPER('Delete')
BEGIN
	IF EXISTS (SELECT	* FROM dbo.Item WHERE IDItemGroup = @ID)
	BEGIN
		SELECT 1 AS TT		
	END
	ELSE
	BEGIN
		DELETE dbo.ItemGroup WHERE ID = @ID
		DBCC CHECKIDENT (ItemGroup,RESEED,0)
		DBCC CHECKIDENT (ItemGroup,RESEED)
		SELECT 0 AS TT		
	END
END	

END


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetListChosseMay')
exec('CREATE PROCEDURE spGetListChosseMay AS BEGIN SET NOCOUNT ON; END')
GO
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
set @sSql = 'INSERT INTO #TEMPItemMay SELECT * FROM ' + @sBT
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



GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditItemMay')
exec('CREATE PROCEDURE spEditItemMay AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditItemMay]
	@IDItem BIGINT,
	@ItemCode  nvarchar(50),
	@ItemName  nvarchar(250),
	@ItemNameA  nvarchar(250),
	@ItemNameH  nvarchar(250),
	@OtherName  nvarchar(250),
	@Barcode  nvarchar(50),
	@IDItemGroup  BIGINT,
	@Description  nvarchar(50),
	@UOMConverionGroupID  BIGINT,
	@BasedUOM  BIGINT,
	@sBT NVARCHAR(50)
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
[WorkingCycle] [int] NULL,
[NumberPerCyle] NUMERIC(18,2) NULL,
[TimeSendMgs] NUMERIC(18,2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPItemMay SELECT * FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)
IF @IDItem = -1
BEGIN
-- them itemmay
INSERT INTO dbo.Item (ItemCode, ItemName,ItemNameA,ItemNameH, OtherName, Barcode,
                        IDItemGroup, Description, UOMConverionGroupID,
                        BasedUOM )
VALUES  (@ItemCode ,@ItemName,@ItemNameA,@ItemNameH,@OtherName, @Barcode ,@IDItemGroup,@Description ,@UOMConverionGroupID ,
@BasedUOM )
SET @IDItem =( SELECT SCOPE_IDENTITY() )
END
ELSE
BEGIN
--sua item may
UPDATE dbo.Item
SET 
ItemCode =@ItemCode,
ItemName =@ItemName,
ItemNameA =@ItemNameA,
ItemNameH =@ItemNameH,
OtherName =@OtherName,
Barcode =@Barcode,
IDItemGroup =@IDItemGroup, 
Description = @Description, 
UOMConverionGroupID =@UOMConverionGroupID,
BasedUOM =@BasedUOM
WHERE ID =@IDItem
END	
IF (SELECT COUNT(*) FROM #TEMPItemMay) > 0
BEGIN
DELETE dbo.ItemMay WHERE ItemID =@IDItem
INSERT INTO	dbo.ItemMay(  MS_MAY, ItemID, StandardOutput, MS_DV_TG_Output,
                           StandardSpeed, MS_DV_TG_Speed, DataCollectionCycle,
                           DownTimeRecord, WorkingCycle, NumberPerCyle,
                           TimeSendMgs)
SELECT MS_MAY,@IDItem,StandardOutput, MS_DV_TG_Output, StandardSpeed, MS_DV_TG_Speed,
      DataCollectionCycle, DownTimeRecord, WorkingCycle, NumberPerCyle,
                           TimeSendMgs
      DownTimeRecord FROM #TEMPItemMay
END
ELSE
BEGIN
DELETE dbo.ItemMay WHERE ItemID =@IDItem
END
SELECT @IDItem
END	

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetMay')
exec('CREATE PROCEDURE spGetMay AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetMay]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll INT =0
AS 
BEGIN
IF	@CoAll = 1
BEGIN
SELECT * FROM (
SELECT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	
UNION
SELECT -1,'< All >')T
ORDER BY T.TEN_MAY
END
ELSE
BEGIN
SELECT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	
ORDER BY A.TEN_MAY
END	
END	



GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetItemMay')
exec('CREATE PROCEDURE spGetItemMay AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetItemMay]
	@ItemID BIGINT = 5,
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@sBT NVARCHAR(50)='BTAdmin'
AS 
BEGIN
SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	

SELECT A.MS_MAY,A.StandardOutput,A.MS_DV_TG_Output,A.StandardSpeed,A.MS_DV_TG_Speed,A.DataCollectionCycle,A.DownTimeRecord,A.WorkingCycle,A.NumberPerCyle,A.TimeSendMgs INTO #TMP FROM dbo.ItemMay A
INNER JOIN #MAY B ON B.MS_MAY = A.MS_MAY
WHERE A.ItemID = @ItemID
ORDER BY MS_MAY


IF	@sBT = 'NO'
BEGIN
SELECT * FROM #TMP
END
ELSE	
BEGIN
CREATE TABLE #TEMPItemMay
(
[CHON] [bit] NULL,
[MS_MAY] [nvarchar] (max),
[TEN_MAY] [nvarchar] (max),
[StandardSpeed] [real] NULL,
[DataCollectionCycle] [int] NULL,
[WorkingCycle] [int] NULL,
[NumberPerCyle] NUMERIC(18,2) NULL,
[TimeSendMgs] NUMERIC(18,2) NULL
) ON [PRIMARY] 
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPItemMay SELECT * FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)

IF (SELECT COUNT(*) FROM #TEMPItemMay) > 0
BEGIN
SELECT A.* FROM #TMP A
INNER JOIN #TEMPItemMay B ON B.MS_MAY = A.MS_MAY
UNION
SELECT A.MS_MAY,NULL AS StandardOutput,NULL AS MS_DV_TG_Output,A.StandardSpeed,NULL AS MS_DV_TG_Speed,A.DataCollectionCycle,NULL AS DownTimeRecord,A.WorkingCycle,A.NumberPerCyle,A.TimeSendMgs FROM #TEMPItemMay A
WHERE NOT EXISTS (SELECT * FROM #TMP B WHERE B.MS_MAY = A.MS_MAY)
END
ELSE
BEGIN
DELETE #TMP
SELECT * FROM #TMP 
END	
END	
END	

GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetItemGroup')
exec('CREATE PROCEDURE spGetItemGroup AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetItemGroup]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM (SELECT ID,CASE @NNgu WHEN 0 THEN ItemGroupName WHEN 1 THEN ISNULL(NULLIF(ItemGroupNameA,''),ItemGroupName) WHEN 2 THEN ISNULL(NULLIF(ItemGroupNameH,''),ItemGroupName) END AS   ItemGroupName FROM dbo.ItemGroup
UNION 
SELECT -1,'< All >')T
ORDER BY T.ItemGroupName


END
ELSE
BEGIN
SELECT ID,CASE @NNgu WHEN 0 THEN ItemGroupName WHEN 1 THEN ISNULL(NULLIF(ItemGroupNameA,''),ItemGroupName) WHEN 2 THEN ISNULL(NULLIF(ItemGroupNameH,''),ItemGroupName) END AS   ItemGroupName FROM dbo.ItemGroup
ORDER BY ItemGroupName
END	
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spUOMConversionGroup')
exec('CREATE PROCEDURE spUOMConversionGroup AS BEGIN SET NOCOUNT ON; END')
GO
--SELECT ID, GroupName, Note FROM dbo.UOMConversionGroup
ALTER	PROCEDURE [dbo].[spUOMConversionGroup]
	@Loai NVARCHAR(50) = 'grd',
	@ID BIGINT = 3,
	@GroupName NVARCHAR(250) = '-1',
	@Note NVARCHAR(500) = '-1'
AS
BEGIN


--Get luoi 
IF UPPER(@Loai) = UPPER('Grd')
BEGIN
   SELECT ID, GroupName, Note FROM dbo.UOMConversionGroup ORDER BY GroupName
END

--Save
IF UPPER(@Loai) = UPPER('Save')
BEGIN
--THEM
	IF @ID = -1
	BEGIN
		INSERT INTO	dbo.UOMConversionGroup(GroupName, Note)
		VALUES(@GroupName, @Note)
		SELECT SCOPE_IDENTITY();
	END
--SUA
	ELSE
	BEGIN
		UPDATE dbo.UOMConversionGroup	SET GroupName = @GroupName,Note = @Note
		WHERE ID = @ID
		SELECT @ID;
	END
	END

--Delete 
IF UPPER(@Loai) = UPPER('Delete')
BEGIN
	IF EXISTS (SELECT * FROM dbo.UOMConversionGroupDetails WHERE UOMConversionGroupID = @ID)
	BEGIN
		SELECT 1 AS TT		
	END
	ELSE
	BEGIN
		DELETE dbo.UOMConversionGroup WHERE ID = @ID
		DBCC CHECKIDENT (UOMConversionGroup,RESEED,0)
		DBCC CHECKIDENT (UOMConversionGroup,RESEED)
		SELECT 0 AS TT		
	END
END	

END


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetUOMConversionGroup')
exec('CREATE PROCEDURE spGetUOMConversionGroup AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetUOMConversionGroup]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM(
SELECT ID, CASE @NNgu WHEN 0 THEN GroupName WHEN 1 THEN ISNULL(NULLIF(GroupNameA,''),GroupName) WHEN 2 THEN ISNULL(NULLIF(GroupNameH,''),GroupName) END AS   GroupName FROM UOMConversionGroup
UNION 
SELECT -1,'< All >')T
ORDER BY T.GroupName;
END
ELSE
BEGIN
SELECT ID, CASE @NNgu WHEN 0 THEN GroupName WHEN 1 THEN ISNULL(NULLIF(GroupNameA,''),GroupName) WHEN 2 THEN ISNULL(NULLIF(GroupNameH,''),GroupName) END AS   GroupName FROM UOMConversionGroup
ORDER BY GroupName
END	
END	


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GET_MENU_OEE')
exec('CREATE PROCEDURE SP_GET_MENU_OEE AS BEGIN SET NOCOUNT ON; END')
GO
ALTER procedure [dbo].[SP_GET_MENU_OEE]
@USERNAME NVARCHAR (128) ='admin'
AS
BEGIN
--SELECT A.MENU_ID, MENU_TEXT, MENU_ENGLISH, MENU_CHINESE, MENU_PARENT, 
--MENU_LINE, MENU_INDEX, SHORT_KEY, DLL_NAME, PROJECT_NAME, 
--CLASS_NAME, FUNCTION_NAME, MENU_NOTE,B.ID_PERMISION
--FROM dbo.MENU_OEE A
--INNER JOIN dbo.NHOM_MENU_OEE B ON B.MENU_ID = A.MENU_ID
--INNER JOIN  dbo.USERS C ON C.GROUP_ID = B.GROUP_ID
--WHERE ISNULL(A.MENU_PARENT,'') ='' AND C.USERNAME =@USERNAME
--ORDER BY A.MENU_INDEX
SELECT A.MENU_ID, MENU_TEXT, MENU_ENGLISH, MENU_CHINESE, MENU_PARENT, 
MENU_LINE, MENU_INDEX, SHORT_KEY, DLL_NAME, PROJECT_NAME, 
CLASS_NAME, FUNCTION_NAME, MENU_NOTE,1 as ID_PERMISION
FROM dbo.MENU A
INNER JOIN dbo.NHOM_MENU B ON B.MENU_ID = A.MENU_ID
INNER JOIN  dbo.USERS C ON C.GROUP_ID = B.GROUP_ID
WHERE ISNULL(A.MENU_PARENT,'') ='' AND C.USERNAME = @USERNAME AND A.MENU_TYPE = -1 ORDER BY A.MENU_INDEX
END






GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spUOM')
exec('CREATE PROCEDURE spUOM AS BEGIN SET NOCOUNT ON; END')
GO
ALTER	PROCEDURE [dbo].[spUOM]
	@Loai NVARCHAR(50) = 'grd',
	@ID BIGINT = 3,
	@UOMCode NVARCHAR(50) = '-1',
	@UOMName NVARCHAR(250) = '-1',
	@UOMNameA NVARCHAR(250) = '-1',
	@UOMNameH NVARCHAR(250) = '-1',
	@Length NUMERIC(18, 2) = -1,
	@Width NUMERIC(18, 2) = -1,
	@Height NUMERIC(18, 2) = -1,
	@Volume NUMERIC(18, 2) = -1,
	@Weight NUMERIC(18, 2) = -1,
	@BasedUOM BIT = 0,
	@UOMNote NVARCHAR(500) = '-1'
AS
BEGIN


--Get luoi 
IF UPPER(@Loai) = UPPER('Grd')
BEGIN
   SELECT ID, UOMCode, UOMName,UOMNameA,UOMNameH, [Length], Width, Height, Volume, [Weight], BasedUOM,UOMNote FROM dbo.UOM ORDER BY UOMCode,UOMName
END

--Save
IF UPPER(@Loai) = UPPER('Save')
BEGIN
--THEM
	IF @ID = -1
	BEGIN
		INSERT INTO	dbo.UOM(UOMCode, UOMName,UOMNameA,UOMNameH, [Length], Width, Height, Volume, [Weight], BasedUOM,UOMNote)
		VALUES(@UOMCode,@UOMName,@UOMNameA,@UOMNameH ,@Length ,@Width ,@Height ,@Volume ,@Weight ,@BasedUOM,@UOMNote )
		SELECT SCOPE_IDENTITY();
	END
--SUA
	ELSE
	BEGIN
		UPDATE dbo.UOM	SET UOMCode = @UOMCode, UOMName = @UOMName, UOMNameA = @UOMNameA, UOMNameH = @UOMNameH, [Length] = @Length, Width = @Width, Height = @Height, Volume = @Volume, [Weight] = @Weight, BasedUOM = @BasedUOM,UOMNote = @UOMNote
		WHERE ID = @ID
		SELECT @ID;
	END
	END

--Delete 
IF UPPER(@Loai) = UPPER('Delete')
BEGIN
	IF EXISTS (SELECT * FROM dbo.UOMConversionGroupDetails WHERE UOMID = @ID)
	BEGIN
		SELECT 1 AS TT		
	END
	ELSE
	BEGIN
		DELETE dbo.UOM WHERE ID = @ID
		DBCC CHECKIDENT (UOM,RESEED,0)
		DBCC CHECKIDENT (UOM,RESEED)
		SELECT 0 AS TT		
	END
END	

END


GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetUOM')
exec('CREATE PROCEDURE spGetUOM AS BEGIN SET NOCOUNT ON; END')
GO
ALTER	PROCEDURE [dbo].[spGetUOM]
    @Loai NVARCHAR(50) = 'Save'
AS
BEGIN
   SELECT ID, UOMCode, UOMName, Length, Width, Height, Volume, Weight, basedUOM FROM dbo.UOM		
END
GO


