ALTER PROC  [dbo].[VS_ST_StopCard]
(
	@ACTION nvarchar(250) =NULL,
	@ID int  =NULL,
	@CreatedBy nvarchar(250) =NULL,
	@DocNum nvarchar(50) =NULL,
	@DocDate datetime =NULL,
	@DocTime datetime =NULL,
	@AdjPerPPE bit =NULL,
	@StopJob bit =NULL,
	@ChangingPosition bit =NULL,
	@RearrangingJob bit =NULL,
	@AttachingGrouds bit =NULL,
	@PerformingLocks bit =NULL,
	@OtherReaction bit= NULL,
	@Head bit =NULL,
	@ArmsAndHands bit =NULL,
	@EyesAndFace bit =NULL,
	@Trunk bit =NULL,
	@Ears bit =NULL,
	@LegsAndFeet bit =NULL,
	@RespiratorySystem bit =NULL,
	@OtherPPE bit =NULL,
	@HPES1 bit =NULL,
	@HPES2 bit =NULL,
	@HPES3 bit =NULL,
	@HPES4 bit =NULL,
	@HPES5 bit =NULL,
	@HPES6 bit =NULL,
	@StrikingAgaintObjects bit =NULL,
	@ChokingHazardousAir bit =NULL,
	@CaughtInOn bit =NULL,
	@Inhaling bit =NULL,
	@Falling bit =NULL,
	@RepettiveMotions bit =NULL,
	@Contacting bit =NULL,
	@PositionsToWork bit =NULL,
	@ContactSharpObject bit =NULL,
	@FlyingObjects bit =NULL,
	@ContactingElectric bit =NULL,
	@EmployeeWork bit =NULL,
	@NotRight bit =NULL,
	@Unknow bit =NULL,
	@UsedIncorrectly bit =NULL,
	@NotUnderstood bit =NULL,
	@InUnsafeCondition bit =NULL,
	@NotFlowed bit =NULL,
	@NotAequate bit =NULL,
	@OtherProcedure bit =NULL,
	@OtherTools bit =NULL,
	@NotIsolate bit =NULL,
	@ToolAndEquipment bit =NULL,
	@NoCollectGarbage bit =NULL,
	@EmergencyExit bit =NULL,
	@Slip bit =NULL,
	@OtherOderLine bit =NULL,
	@External bit =NULL,
	@TUNGAY DATE =NULL,
	@DENNGAY DATE =NULL,
	@NGUOIBAOCAO nvarchar(250) =NULL,
	@SOCHUNGTU nvarchar(250) =NULL
)
AS
BEGIN
	IF @ACTION='GET_DOCNUM'
	BEGIN
		DECLARE @DOCNO VARCHAR(20)
		DECLARE @DEM INT
		SET @DOCNO=''
		SELECT @DEM=MAX(right([DocNum],4)) FROM [dbo].[ST_StopCard]
		IF ISNULL(@DEM,0)=0
			SET @DEM=1
		ELSE
			SET @DEM=@DEM+1
		
		SET @DOCNO='ST' + REPLACE( CONVERT(VARCHAR(10), GETDATE(),104),'.','')+ CASE LEN(@DEM) WHEN 1 THEN '000'+ CONVERT(VARCHAR(4), @DEM) WHEN 2 THEN '00'+ CONVERT(VARCHAR(4), @DEM) WHEN 3 THEN '0'+ CONVERT(VARCHAR(4), @DEM) WHEN 4 THEN  CONVERT(VARCHAR(4), @DEM) END
		SELECT @DOCNO
	END
	IF @ACTION='LIST'
	BEGIN
		SELECT 
			[ID],[DocNum],convert(varchar(10),[DocDate],103) [DocDate],convert(varchar(8),[DocTime],114)[DocTime],[CreatedBy]
		FROM [dbo].[ST_StopCard] 
		WHERE CONVERT(DATE, DocDate) BETWEEN @TUNGAY AND @DENNGAY
			AND CreatedBy LIKE  CASE WHEN @NGUOIBAOCAO ='' THEN '%' ELSE '%'+ @NGUOIBAOCAO +'%' END
				AND DocNum LIKE  CASE WHEN @SOCHUNGTU ='' THEN '%' ELSE '%'+ @SOCHUNGTU +'%' END
		ORDER BY ID
	END
	IF @ACTION='GET_BY_ID'
	BEGIN
		SELECT 
			 [ID]
			,CreatedBy
			,[DocNum]
			,[DocDate]
			,[DocTime]
			,[AdjPerPPE]
			,[StopJob]
			,[ChangingPosition]
			,[RearrangingJob]
			,[AttachingGrouds]
			,[PerformingLocks]
			,[OtherReaction]
			,[Head]
			,[ArmsAndHands]
			,[EyesAndFace]
			,[Trunk]
			,[Ears]
			,[LegsAndFeet]
			,[RespiratorySystem]
			,[OtherPPE]
			,[HPES1]
			,[HPES2]
			,[HPES3]
			,[HPES4]
			,[HPES5]
			,[HPES6]
			,[StrikingAgaintObjects]
			,[ChokingHazardousAir]
			,[CaughtInOn]
			,[Inhaling]
			,[Falling]
			,[RepettiveMotions]
			,[Contacting]
			,[PositionsToWork]
			,[ContactSharpObject]
			,[FlyingObjects]
			,[ContactingElectric]
			,[EmployeeWork]
			,[NotRight]
			,[Unknow]
			,[UsedIncorrectly]
			,[NotUnderstood]
			,[InUnsafeCondition]
			,[NotFlowed]
			,[NotAequate]
			,[OtherProcedure]
			,[OtherTools]
			,[NotIsolate]
			,[ToolAndEquipment]
			,[NoCollectGarbage]
			,[EmergencyExit]
			,[Slip]
			,[OtherOderLine],
			ISNULL([External],'False')[External]
		FROM [CMMS_BARIA].[dbo].[ST_StopCard]
		WHERE ID=@ID
	END
	IF @ACTION='ADD'
	BEGIN
		IF NOT EXISTS(SELECT * FROM [dbo].[ST_StopCard] WHERE ID=@ID)
		BEGIN
			INSERT INTO [dbo].[ST_StopCard]
			   ([DocNum]
			   ,CreatedBy
			   ,[DocDate]
			   ,[DocTime]
			   ,[AdjPerPPE]
			   ,[StopJob]
			   ,[ChangingPosition]
			   ,[RearrangingJob]
			   ,[AttachingGrouds]
			   ,[PerformingLocks]
			   ,[OtherReaction]
			   ,[Head]
			   ,[ArmsAndHands]
			   ,[EyesAndFace]
			   ,[Trunk]
			   ,[Ears]
			   ,[LegsAndFeet]
			   ,[RespiratorySystem]
			   ,[OtherPPE]
			   ,[HPES1]
			   ,[HPES2]
			   ,[HPES3]
			   ,[HPES4]
			   ,[HPES5]
			   ,[HPES6]
			   ,[StrikingAgaintObjects]
			   ,[ChokingHazardousAir]
			   ,[CaughtInOn]
			   ,[Inhaling]
			   ,[Falling]
			   ,[RepettiveMotions]
			   ,[Contacting]
			   ,[PositionsToWork]
			   ,[ContactSharpObject]
			   ,[FlyingObjects]
			   ,[ContactingElectric]
			   ,[EmployeeWork]
			   ,[NotRight]
			   ,[Unknow]
			   ,[UsedIncorrectly]
			   ,[NotUnderstood]
			   ,[InUnsafeCondition]
			   ,[NotFlowed]
			   ,[NotAequate]
			   ,[OtherProcedure]
			   ,[OtherTools]
			   ,[NotIsolate]
			   ,[ToolAndEquipment]
			   ,[NoCollectGarbage]
			   ,[EmergencyExit]
			   ,[Slip]
			   ,[OtherOderLine],[External])
			 VALUES
			   (@DocNum
			   ,@CreatedBy
			   ,@DocDate
			   ,@DocTime
			   ,@AdjPerPPE
			   ,@StopJob
			   ,@ChangingPosition
			   ,@RearrangingJob
			   ,@AttachingGrouds
			   ,@PerformingLocks
			   ,@OtherReaction
			   ,@Head
			   ,@ArmsAndHands
			   ,@EyesAndFace
			   ,@Trunk
			   ,@Ears
			   ,@LegsAndFeet
			   ,@RespiratorySystem
			   ,@OtherPPE
			   ,@HPES1
			   ,@HPES2
			   ,@HPES3
			   ,@HPES4
			   ,@HPES5
			   ,@HPES6
			   ,@StrikingAgaintObjects
			   ,@ChokingHazardousAir
			   ,@CaughtInOn
			   ,@Inhaling
			   ,@Falling
			   ,@RepettiveMotions
			   ,@Contacting
			   ,@PositionsToWork
			   ,@ContactSharpObject
			   ,@FlyingObjects
			   ,@ContactingElectric
			   ,@EmployeeWork
			   ,@NotRight
			   ,@Unknow
			   ,@UsedIncorrectly
			   ,@NotUnderstood
			   ,@InUnsafeCondition
			   ,@NotFlowed
			   ,@NotAequate
			   ,@OtherProcedure
			   ,@OtherTools
			   ,@NotIsolate
			   ,@ToolAndEquipment
			   ,@NoCollectGarbage
			   ,@EmergencyExit
			   ,@Slip
			   ,@OtherOderLine,@External)
		   END
	END
	IF @ACTION='UPDATE'
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[ST_StopCard] WHERE ID=@ID)
		BEGIN
			UPDATE [dbo].[ST_StopCard]
			SET [DocNum] = @DocNum
			  ,CreatedBy=@CreatedBy
			  ,[DocDate] = @DocDate
			  ,[DocTime] = @DocTime
			  ,[AdjPerPPE] = @AdjPerPPE
			  ,[StopJob] = @StopJob
			  ,[ChangingPosition] = @ChangingPosition
			  ,[RearrangingJob] = @RearrangingJob
			  ,[AttachingGrouds] = @AttachingGrouds
			  ,[PerformingLocks] = @PerformingLocks
			  ,[OtherReaction] = @OtherReaction
			  ,[Head] = @Head
			  ,[ArmsAndHands] = @ArmsAndHands
			  ,[EyesAndFace] = @EyesAndFace
			  ,[Trunk] = @Trunk
			  ,[Ears] = @Ears
			  ,[LegsAndFeet] = @LegsAndFeet
			  ,[RespiratorySystem] = @RespiratorySystem
			  ,[OtherPPE] = @OtherPPE
			  ,[HPES1] = @HPES1
			  ,[HPES2] = @HPES2
			  ,[HPES3] = @HPES3
			  ,[HPES4] = @HPES4
			  ,[HPES5] = @HPES5
			  ,[HPES6] = @HPES6
			  ,[StrikingAgaintObjects] = @StrikingAgaintObjects
			  ,[ChokingHazardousAir] = @ChokingHazardousAir
			  ,[CaughtInOn] = @CaughtInOn
			  ,[Inhaling] = @Inhaling
			  ,[Falling] = @Falling
			  ,[RepettiveMotions] = @RepettiveMotions
			  ,[Contacting] = @Contacting
			  ,[PositionsToWork] = @PositionsToWork
			  ,[ContactSharpObject] = @ContactSharpObject
			  ,[FlyingObjects] = @FlyingObjects
			  ,[ContactingElectric] = @ContactingElectric
			  ,[EmployeeWork] = @EmployeeWork
			  ,[NotRight] = @NotRight
			  ,[Unknow] = @Unknow
			  ,[UsedIncorrectly] = @UsedIncorrectly
			  ,[NotUnderstood] = @NotUnderstood
			  ,[InUnsafeCondition] = @InUnsafeCondition
			  ,[NotFlowed] = @NotFlowed
			  ,[NotAequate] = @NotAequate
			  ,[OtherProcedure] = @OtherProcedure
			  ,[OtherTools] = @OtherTools
			  ,[NotIsolate] = @NotIsolate
			  ,[ToolAndEquipment] = @ToolAndEquipment
			  ,[NoCollectGarbage] = @NoCollectGarbage
			  ,[EmergencyExit] = @EmergencyExit
			  ,[Slip] = @Slip
			  ,[OtherOderLine] = @OtherOderLine
			  ,[External]=@External
			WHERE ID=@ID
		END
	END
	IF @ACTION='DELETE'
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[ST_StopCard] WHERE ID=@ID)
		BEGIN
			DELETE [dbo].[ST_StopCard] WHERE ID=@ID
		END
	END

END


