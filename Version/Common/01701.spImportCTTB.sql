--SELECT * INTO CTTBDCM630 FROM  CTTBAdmin
--SELECT *  FROM CTTBAdmin
ALTER	 PROCEDURE [dbo].[spImportCTTB]
	@BTam AS NVARCHAR(250) = 'CTTBAdmin'
    
AS
BEGIN
--Tao table tạm chứa dữ liệu
CREATE TABLE  #CTTB (
	[STT] [INT] NULL,
	[MSCHA] [NVARCHAR](255) NULL,
	[TENBP] [NVARCHAR](255) NULL,
	[TENBP2] [NVARCHAR](255) NULL,
	[TENBP3] [NVARCHAR](255) NULL,
	[TENBP4] [NVARCHAR](255) NULL,
	[TENBP5] [NVARCHAR](255) NULL,
	[TENBP6] [NVARCHAR](255) NULL,
	[MSBP] [NVARCHAR](255) NULL,
	[MSCHA2] [NVARCHAR](255) NULL,
	[MSBP2] [NVARCHAR](255) NULL,
	[MSCHA3] [NVARCHAR](255) NULL,
	[MSBP3] [NVARCHAR](255) NULL,
	[MSCHA4] [NVARCHAR](255) NULL,
	[MSBP4] [NVARCHAR](255) NULL,
	[MSCHA5] [NVARCHAR](255) NULL,
	[MSBP5] [NVARCHAR](255) NULL,
	[MSCHA6] [NVARCHAR](255) NULL,
	[MSBP6] [NVARCHAR](255) NULL
) ;

DECLARE @Sql NVARCHAR(MAX)
SET @Sql = 'INSERT INTO #CTTB (STT, MSCHA, TENBP, TENBP2, TENBP3, TENBP4, TENBP5, TENBP6, MSBP, MSCHA2, MSBP2, MSCHA3, MSBP3, MSCHA4, MSBP4, MSCHA5, MSBP5, MSCHA6, MSBP6)	 
SELECT STT, MSCHA, TENBP, TENBP2, TENBP3, TENBP4, TENBP5, TENBP6, MSBP, MSCHA2, MSBP2, MSCHA3, MSBP3, MSCHA4, MSBP4, MSCHA5, MSBP5, MSCHA6, MSBP6 FROM ' + @BTam ;
EXEC (@Sql);

SET @Sql = 'DROP TABLE ' + @BTam;
EXEC (@Sql);


DECLARE @STT INT, @MSCHA nvarchar (1000),@MSBP nvarchar (1000),@TENBP nvarchar (1000),@I INT, @MSchac nvarchar (1000)

Declare  Cap1 CURSOR FOR
	SELECT DISTINCT MAX(STT) AS STT,  MSCHA,MSBP,TENBP FROM #CTTB GROUP  BY MSCHA,MSBP,TENBP   ORDER BY    MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1

	--cap 1	
	--Kiem max ms bo phan trong table theo dung may 
	IF @I = 1
		SELECT @I = ISNULL( MAX(ISNULL(CONVERT(INT,MS_BO_PHAN,0),0)),0) + 1 FROM dbo.CAU_TRUC_THIET_BI WHERE MS_MAY = @MSCHA AND MS_BO_PHAN_CHA = MS_MAY 

	---- bat dau tu 2
	--IF @I = 1
	--	SET @I = 1


	SET @MSBP = CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I ) ELSE CONVERT(NVARCHAR(2), @I) END)
	
	UPDATE #CTTB SET	MSBP = T2.MSBP,MSCHA2 =  T2.MSBP	FROM #CTTB  T1 INNER JOIN (
		SELECT  @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP] = T2.TENBP AND 	T1.MSCHA = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP],'') <> '' 
	UPDATE #CTTB SET	MSCHA2 = NULL WHERE	ISNULL([TENBP2],'') = '' 
	


	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1

--cap 2
SET @STT = NULL
SET @MSCHA = NULL
SET @MSBP = NULL
SET @TENBP = NULL
SET @I = NULL
SET @MSchac = NULL
Declare  Cap1 CURSOR FOR
	SELECT DISTINCT  MAX(STT) AS STT,MSCHA2,MSBP2,TENBP2 FROM #CTTB    GROUP  BY mSCHA2,MSBP2,TENBP2  ORDER BY    MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1


	--cap 2
	SET @MSBP = @MSCHA +'.'+ CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR(2), @I) END)
	UPDATE #CTTB SET	MSBP2 = T2.MSBP,MSCHA3 =  T2.MSBP	
	FROM #CTTB  T1 INNER JOIN (
		SELECT  @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP2] = T2.TENBP AND 	T1.MSBP = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP2],'') <> '' 

	UPDATE #CTTB SET	MSCHA3 = NULL WHERE	ISNULL([TENBP3],'') = '' 



	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1

 
--cap 3

SET @STT = NULL SET @MSCHA = NULL SET @MSBP = NULL SET @TENBP = NULL SET @I = NULL SET @MSchac = NULL
Declare  Cap1 CURSOR FOR
	SELECT DISTINCT  MAX(STT) AS STT, MSCHA3,MSBP3,TENBP3 FROM #CTTB    GROUP  BY MSCHA3,MSBP3,TENBP3   ORDER BY    MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
--INTO   @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1

	
	--cap 3
	SET @MSBP = @MSCHA +'.'+ CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR(2), @I) END)
	UPDATE #CTTB SET	MSBP3 = T2.MSBP,MSCHA4 =  T2.MSBP	FROM #CTTB  T1 INNER JOIN (
		SELECT  @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP3] = T2.TENBP AND 	T1.MSBP2 = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP3],'') <> '' 
	UPDATE #CTTB SET	MSCHA4 = NULL WHERE	ISNULL([TENBP4],'') = '' 



	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1


--cap4
SET @STT = NULL SET @MSCHA = NULL SET @MSBP = NULL SET @TENBP = NULL SET @I = NULL SET @MSchac = NULL
Declare  Cap1 CURSOR FOR
	SELECT DISTINCT   MAX(STT) AS STT,MSCHA4,MSBP4,TENBP4 FROM #CTTB     GROUP  BY MSCHA4,MSBP4,TENBP4   ORDER BY    MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1

	--cap 4
	SET @MSBP = @MSCHA +'.'+ CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR(2), @I) END)
	UPDATE #CTTB SET	MSBP4 = T2.MSBP,MSCHA5 =  T2.MSBP	FROM #CTTB  T1 INNER JOIN (
		SELECT  @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP4] = T2.TENBP AND 	T1.MSBP3 = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP4],'') <> '' 
	UPDATE #CTTB SET	MSCHA5 = NULL WHERE	ISNULL([TENBP5],'') = '' 



	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1
 
--CAP 5
SET @STT = NULL SET @MSCHA = NULL SET @MSBP = NULL SET @TENBP = NULL SET @I = NULL SET @MSchac = NULL
Declare  Cap1 CURSOR FOR
	SELECT DISTINCT  MAX(STT) AS STT, MSCHA5,MSBP5,TENBP5 FROM #CTTB     GROUP  BY MSCHA5,MSBP5,TENBP5   ORDER BY    MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1

		--cap 5 chua cuoi
	SET @MSBP = @MSCHA +'.'+ CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR(2), @I) END)
	UPDATE #CTTB SET	MSBP5 = T2.MSBP,MSCHA6 =  T2.MSBP	FROM #CTTB  T1 INNER JOIN (
		SELECT   @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP5] = T2.TENBP AND 	T1.MSBP4 = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP5],'') <> '' 
	UPDATE #CTTB SET	MSCHA6 = NULL WHERE	ISNULL([TENBP6],'') = '' 




	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1

-- cap 6
SET @STT = NULL SET @MSCHA = NULL SET @MSBP = NULL SET @TENBP = NULL SET @I = NULL SET @MSchac = NULL
Declare  Cap1 CURSOR FOR
SELECT DISTINCT   MAX(STT) AS STT,MSCHA6,MSBP6,TENBP6 FROM #CTTB     GROUP  BY MSCHA6,MSBP6,TENBP6  ORDER BY MAX(STT)
OPEN Cap1
SET @I = 1
FETCH NEXT FROM Cap1
INTO @STT,  @MSCHA ,@MSBP ,@TENBP
WHILE @@Fetch_Status = 0
BEGIN

	IF LTRIM(RTRIM(@MSchac)) <> LTRIM(RTRIM(@MSCHA))SET @I = 1
	IF LTRIM(RTRIM(ISNULL(@MSchac,''))) = '' SET @I = 1


		--  cap 6 cấp cuối 
	SET @MSBP = @MSCHA +'.'+ CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR(2), @I) END)
	--SET @MSBP =  CONVERT(NVARCHAR(2), CASE	WHEN LEN(@I) = 1 THEN '0' + CONVERT(NVARCHAR(2), @I) ELSE CONVERT(NVARCHAR (2), @I) END)
	UPDATE #CTTB SET	MSBP6 = T2.MSBP	FROM #CTTB  T1 INNER JOIN (
		SELECT  @MSCHA AS MSCHA, 	@MSBP AS	MSBP	,@TENBP AS TENBP
	) T2 ON T1.[TENBP6] = T2.TENBP AND 	T1.MSBP5 = T2.MSCHA	  WHERE	ISNULL(T1.[TENBP6],'') <> '' 
	

	-----------------------------------------------------




	SET @MSchac = @MSCHA
	SET @I = @I +1
    FETCH NEXT FROM Cap1
    INTO @STT,  @MSCHA ,@MSBP ,@TENBP
    --INTO   @MSCHA ,@MSBP ,@TENBP

End

Close Cap1
Deallocate Cap1

	INSERT INTO dbo.CAU_TRUC_THIET_BI
	( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 1
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP],[TENBP], 1 AS sl ,[MSCHA], CONVERT(INT,T1.MSBP) AS STT 	FROM #CTTB T1 WHERE	ISNULL(T1.TENBP,'') <> ''  ORDER BY MSBP

	

	INSERT INTO dbo.CAU_TRUC_THIET_BI ( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 2
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP2],[TENBP2], 1 AS sl ,[MSCHA2], CONVERT(INT,RIGHT(T1.[MSBP2],2))  AS STT 	FROM #CTTB T1 WHERE	ISNULL(T1.[TENBP2],'') <> '' ORDER BY [MSCHA],MSBP2 
	
	INSERT INTO dbo.CAU_TRUC_THIET_BI ( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 3
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP3],[TENBP3], 1 AS sl ,[MSCHA3], CONVERT(INT,RIGHT(T1.[MSBP3],2))  AS STT 	FROM #CTTB T1 WHERE	ISNULL(T1.[TENBP3],'') <> '' ORDER BY [MSBP3]

	INSERT INTO dbo.CAU_TRUC_THIET_BI ( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 4
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP4],[TENBP4], 1 AS sl ,[MSCHA4],CONVERT(INT,RIGHT(T1.[MSBP4],2))  AS STT 	FROM #CTTB  T1 WHERE	ISNULL(T1.[TENBP4],'') <> '' ORDER BY MSBP4
	

	INSERT INTO dbo.CAU_TRUC_THIET_BI ( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 5
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP5],[TENBP5], 1 AS sl ,[MSCHA5], CONVERT(INT,RIGHT(T1.[MSBP5],2))  AS STT 	FROM #CTTB  T1 WHERE	ISNULL(T1.[TENBP5],'') <> '' ORDER BY [MSBP5]



	INSERT INTO dbo.CAU_TRUC_THIET_BI ( MS_MAY,MS_BO_PHAN,TEN_BO_PHAN,SO_LUONG,MS_BO_PHAN_CHA,STT)
--cap 6
	SELECT DISTINCT [MSCHA] AS ms_may,[MSBP6],[TENBP6], 1 AS sl ,[MSCHA6], CONVERT(INT,RIGHT(T1.[MSBP6],2))  AS STT 	FROM #CTTB  T1 WHERE	ISNULL(T1.[TENBP6],'') <> '' ORDER BY [MSBP6]

end