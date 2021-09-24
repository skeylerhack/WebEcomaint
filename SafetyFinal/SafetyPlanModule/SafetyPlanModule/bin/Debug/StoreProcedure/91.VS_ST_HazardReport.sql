CREATE  PROC  VS_ST_HazardReport
(
	@ACTION nvarchar(250) =NULL,
	@ID int = NULL,
	@DocNum nvarchar(50) =NULL,
	@DocDate datetime =NULL,
	@DocTime datetime =NULL,
	@Createdtime datetime =NULL,
	@CreatedBy nvarchar(250) =NULL,
	@Department nvarchar(250) =NULL,
	@UnsafeCondition bit =NULL,
	@BelongContractor bit =NULL,
	@Operation bit =NULL,
	@NearMiss bit =NULL,
	@HR bit =NULL,
	@UnsafeBehevior bit =NULL,
	@BelongToBSPort bit =NULL,
	@TechHSE bit =NULL,
	@Acount bit =NULL,
	@SatetySuggestion bit =NULL,
	@Tally bit =NULL,
	@Procu bit =NULL,
	@Other bit =NULL,
	@Stopwork bit =NULL,
	@Commercial bit =NULL,
	@HPES1 bit =NULL,
	@HPES2 bit =NULL,
	@HPES3 bit =NULL,
	@HPES4 bit =NULL,
	@HPES5 bit =NULL,
	@HPES6 bit =NULL,
	@Location nvarchar(250) =NULL,
	@Description nvarchar(250) =NULL,
	@External bit =NULL,
	@TB [ST_HazardReport1] READONLY
)
AS
BEGIN
	IF @ACTION='GET_DOCNUM'
	BEGIN
		DECLARE @DOCNO VARCHAR(20)
		DECLARE @DEM INT
		SET @DOCNO=''
		SELECT @DEM=COUNT(*) FROM [dbo].[ST_HazardReport]
		IF @DEM=0
			SET @DEM=1
		ELSE
			SET @DEM=@DEM+1
		SET @DOCNO='HZ.' + CONVERT(VARCHAR(10), GETDATE(),104)+ '.'+ CAST(@DEM AS VARCHAR(10))
		SELECT @DOCNO
	END
	IF @ACTION='LIST_DEPARTMENT'
	BEGIN
		SELECT [ID],[Department] FROM	[dbo].[ST_Department] ORDER BY ID
	END
	IF @ACTION='LIST_INCHARGE'
	BEGIN
		SELECT [ID],[Staffname],[Description] FROM	[dbo].[ST_Safety] ORDER BY ID
	END
	IF @ACTION='LIST'
	BEGIN
		SELECT 
			T1.[ID],[DocNum],convert(varchar(10),[DocDate],103) [DocDate],convert(varchar(8),[DocTime],114)[DocTime],[CreatedBy],T2.[Department]
		FROM [dbo].[ST_HazardReport] T1 INNER JOIN DBO.ST_Department T2 ON T1.Department=T2.ID
		ORDER BY ID
	END
	IF @ACTION='GET_BY_ID'
	BEGIN
		SELECT 
			[ID]
			,[DocNum]
			,[DocDate]
			,[DocTime]
			,[Createdtime]
			,[CreatedBy]
			,[Department]
			,[UnsafeCondition]
			,[BelongContractor]
			,[Operation]
			,[HR]
			,[UnsafeBehevior]
			,[BelongToBSPort]
			,[TechHSE]
			,[Acount]
			,[SatetySuggestion]
			,[Tally]
			,[Procu]
			,[Other]
			,[Stopwork]
			,[Commercial]
			,[HPES1]
			,[HPES2]
			,[HPES3]
			,[HPES4]
			,[HPES5]
			,[HPES6]
			,[Location]
			,[Description],
			isnull([External],'False')[External],
			NearMiss
		FROM [dbo].[ST_HazardReport]
		WHERE ID=@ID
	END
	IF @ACTION='GET_DETAIL'
	BEGIN
		SELECT 
			[ID]
			,[PreventiveAction]
			,[PersonIncharge]
			,[Deadline]
			,[CompletedDate]
			,[Status]
			,[PersonReport]
			,[Description]
		FROM [dbo].[ST_HazardReport1]
		WHERE [HazardReportID]=@ID
	END
	IF @ACTION='LIST_LOCATION'
	BEGIN
		SELECT [ID],[LocationName] [Name] FROM [dbo].[ST_Locations]
	END
	IF @ACTION='ADD'
	BEGIN
		IF NOT EXISTS(SELECT * FROM [dbo].[ST_HazardReport] WHERE ID=@ID)
		BEGIN
			INSERT INTO [dbo].[ST_HazardReport]
			   ([DocNum]
			   ,[DocDate]
			   ,[DocTime]
			   ,[Createdtime]
			   ,[CreatedBy]
			   ,[Department]
			   ,[UnsafeCondition]
			   ,[BelongContractor]
			   ,[Operation]
			   ,[HR]
			   ,[UnsafeBehevior]
			   ,[BelongToBSPort]
			   ,[TechHSE]
			   ,[Acount]
			   ,[SatetySuggestion]
			   ,[Tally]
			   ,[Procu]
			   ,[Other]
			   ,[Stopwork]
			   ,[Commercial]
			   ,[HPES1]
			   ,[HPES2]
			   ,[HPES3]
			   ,[HPES4]
			   ,[HPES5]
			   ,[HPES6]
			   ,[Location]
			   ,[Description],
			   [External],NearMiss)
			VALUES
			   (@DocNum
			   ,@DocDate
			   ,@DocTime
			   ,@Createdtime
			   ,@CreatedBy
			   ,@Department
			   ,@UnsafeCondition
			   ,@BelongContractor
			   ,@Operation
			   ,@HR
			   ,@UnsafeBehevior
			   ,@BelongToBSPort
			   ,@TechHSE
			   ,@Acount
			   ,@SatetySuggestion
			   ,@Tally
			   ,@Procu
			   ,@Other
			   ,@Stopwork
			   ,@Commercial
			   ,@HPES1
			   ,@HPES2
			   ,@HPES3
			   ,@HPES4
			   ,@HPES5
			   ,@HPES6
			   ,@Location
			   ,@Description,
			   @External,@NearMiss)
			SET @ID=ISNULL((SELECT MAX(ID) FROM [dbo].[ST_HazardReport]),1)
		END

		INSERT INTO [dbo].[ST_HazardReport1]
           ([HazardReportID]
           ,[PreventiveAction]
           ,[PersonIncharge]
           ,[Deadline]
		   ,[CompletedDate]
		   ,[Status]
		   ,[PersonReport]
		   ,[Description])
		SELECT @ID,[PreventiveAction],[PersonIncharge],[Deadline],[CompletedDate] ,[Status],[PersonReport],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN (SELECT ID FROM [dbo].[ST_HazardReport1])
	END
	IF @ACTION='UPDATE'
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[ST_HazardReport] WHERE ID=@ID)
		BEGIN
			UPDATE [dbo].[ST_HazardReport]
			SET [DocNum] = @DocNum
				,[DocDate] = @DocDate
				,[DocTime] = @DocTime
				,[Createdtime] = @Createdtime
				,[CreatedBy] = @CreatedBy
				,[Department] = @Department
				,[UnsafeCondition] = @UnsafeCondition
				,[BelongContractor] = @BelongContractor
				,[Operation] = @Operation
				,[HR] = @HR
				,[UnsafeBehevior] = @UnsafeBehevior
				,[BelongToBSPort] = @BelongToBSPort
				,[TechHSE] = @TechHSE
				,[Acount] = @Acount
				,[SatetySuggestion] = @SatetySuggestion
				,[Tally] = @Tally
				,[Procu] = @Procu
				,[Other] = @Other
				,[Stopwork] = @Stopwork
				,[Commercial] = @Commercial
				,[HPES1] = @HPES1
				,[HPES2] = @HPES2
				,[HPES3] = @HPES3
				,[HPES4] = @HPES4
				,[HPES5] = @HPES5
				,[HPES6] = @HPES6
				,[Location] = @Location
				,[Description] = @Description,
				[External]=@External,
				NearMiss=@NearMiss
			WHERE ID=@ID

			IF EXISTS(SELECT * FROM [dbo].[ST_HazardReport1] WHERE [HazardReportID]=@ID)
			BEGIN
				DELETE [dbo].[ST_HazardReport1] WHERE [HazardReportID]=@ID
			
				INSERT INTO [dbo].[ST_HazardReport1]
				   ([HazardReportID]
				   ,[PreventiveAction]
				   ,[PersonIncharge]
				   ,[Deadline]
				   ,[CompletedDate]
				   ,[Status]
				   ,[PersonReport]
				   ,[Description])
				SELECT @ID,[PreventiveAction],[PersonIncharge],[Deadline],[CompletedDate] ,[Status],[PersonReport],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN (SELECT ID FROM [dbo].[ST_HazardReport1])
			END
		END
	END
	IF @ACTION='DELETE'
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[ST_HazardReport] WHERE ID=@ID)
		BEGIN
			DELETE [dbo].[ST_HazardReport] WHERE ID=@ID
		END
		IF EXISTS(SELECT * FROM [dbo].[ST_HazardReport1] WHERE [HazardReportID]=@ID)
		BEGIN
			DELETE [dbo].[ST_HazardReport1] WHERE [HazardReportID]=@ID
		END
	END
	IF @ACTION='PRINT'
	BEGIN
		SELECT 
			t1.[ID]
			,[DocNum]
			,[DocDate]
			,[DocTime]
			,[Createdtime]
			,[CreatedBy]
			,t3.Department
			,[UnsafeCondition]
			,[BelongContractor]
			,[Operation]
			,[HR]
			,[UnsafeBehevior]
			,[BelongToBSPort]
			,[TechHSE]
			,[Acount]
			,[SatetySuggestion]
			,[Tally]
			,[Procu]
			,[Other]
			,[Stopwork]
			,[Commercial]
			,[HPES1]
			,[HPES2]
			,[HPES3]
			,[HPES4]
			,[HPES5]
			,[HPES6]
			,t2.[LocationName][Location]
			,t1.[Description],
			[External],
			t1.NearMiss
		FROM [dbo].[ST_HazardReport] t1 inner join [dbo].[ST_Locations] t2 on t1.Location=t2.id
			inner join [dbo].[ST_Department] t3 on t1.Department=t3.ID
		WHERE t1.ID=@ID

		SELECT t1.ID,t1.HazardReportID,t1.PreventiveAction,t2.Staffname,t1.Deadline FROM [dbo].[ST_HazardReport1] t1 inner join [dbo].[ST_Safety] t2 on t1.PersonIncharge=t2.ID WHERE [HazardReportID]=@ID
	END 
END


