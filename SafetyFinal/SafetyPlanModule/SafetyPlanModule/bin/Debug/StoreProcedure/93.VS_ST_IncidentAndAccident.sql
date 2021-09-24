CREATE  PROC VS_ST_IncidentAndAccident(
@Action nvarchar(250)=NULL,
@UserLogin nvarchar(250)=NULL,
@ID int  =NULL,
@DocNum nvarchar(50)=NULL,
@DocDate datetime=NULL,
@DetailofTheInjured nvarchar(250)=NULL,
@TimeofIncident datetime=NULL,
@PleaseStateCompany nvarchar(250)=NULL,
@IncidentPlace nvarchar(250)=NULL,
@IncidentReportingPerson nvarchar(250)=NULL,
@EquipTag nvarchar(150)=NULL,
@WorkingTime datetime=NULL,
@External BIT =NULL,
@HPES1 bit=NULL,
@HPES2 bit=NULL,
@HPES3 bit=NULL,
@HPES4 bit=NULL,
@HPES5 bit=NULL,
@HPES6 bit=NULL,
@Normal bit=NULL,
@Overtime bit=NULL,
@InChargeOfAccident nvarchar(250)=NULL,
@JobPosition nvarchar(250)=NULL,
@DeptManComments nvarchar(250)=NULL,
@DateIncharge datetime=NULL,
@ApprovalBy nvarchar(250)=NULL,
@ApprovalDate datetime=NULL,
@FirstAID bit=NULL,
@NearMiss bit=NULL,
@MTC bit=NULL,
@PropertyDamage bit=NULL,
@RWC bit=NULL,
@LTA bit=NULL,
@Fatality bit=NULL,
@Environment bit=NULL,
@WorkRelatedIllness bit=NULL,
@Fire bit=NULL,
@NonEmployee bit=NULL,
@EstimatedCCST float=NULL,
@Minor bit=NULL,
@Senious bit=NULL,
@Major bit=NULL,
@IfPropertyDamage nvarchar(250)=NULL,
@EstimatedCost float=NULL,
@Head bit=NULL,
@LeftRight bit=NULL,
@Eye bit=NULL,
@Back bit=NULL,
@Leg bit=NULL,
@Arm bit=NULL,
@Finger bit=NULL,
@OtherIncident bit=NULL,
@Poor bit=NULL,
@Fair bit=NULL,
@Good bit=NULL,
@Wet bit=NULL,
@Slippery bit=NULL,
@Tripping bit=NULL,
@Uneven bit=NULL,
@Rainy bit=NULL,
@Fog bit=NULL,
@Windy bit=NULL,
@Dark bit=NULL,
@Hot bit=NULL,
@IncidentDescription ntext=NULL,
@ImmediateCauses ntext=NULL,
@LackOfKnowledge nvarchar(MAX)=NULL,
@EmployeePlacement nvarchar(MAX)=NULL,
@NotEnforcingST nvarchar(MAX)=NULL,
@DesignInstallation nvarchar(MAX)=NULL,
@InadequatePPE nvarchar(MAX)=NULL,
@InadequateInspection nvarchar(MAX)=NULL,
@InadequateEquipment nvarchar(MAX)=NULL,
@InadequateObservation nvarchar(MAX)=NULL,
@UnsafeMethod nvarchar(MAX)=NULL,
--@EstimatedCost1 float=NULL,
--@EstimatedCost2 float=NULL,
@ImproperUOE bit=NULL,
@InadequateEFT bit=NULL,
@SafeMNK bit=NULL,
@EmployeeNQPT bit=NULL,
@OtherLOK bit=NULL,
@OtherLOKText nvarchar(250)=NULL,
@InadequateGuarding bit=NULL,
@UnsafeDesign bit=NULL,
@NoAssistForFrequently bit=NULL,
@DiffcultPTS bit=NULL,
@ExposedPPoOH bit=NULL,
@OtherDesgn bit=NULL,
@OtheDesignText nvarchar(250)=NULL,
@DefectiveTools bit=NULL,
@InoperativeSafety bit=NULL,
@InadequateLabeling bit=NULL,
@HazardByNWT bit=NULL,
@EquipdeviceUNR bit=NULL,
@EquipDeviceFDU bit=NULL,
@OtherInadequateInspection bit=NULL,
@OtherInadequateInspectionText nvarchar(250)=NULL,
@PhysicalOver bit=NULL,
@TaskExceededMR bit=NULL,
@RecurrenceOAPI bit=NULL,
@Illness bit=NULL,
@OtherEmplyeePlacement bit=NULL,
@OtherEmplyeePlacementText nvarchar(250)=NULL,
@NecessarySafetyEquip bit=NULL,
@InadequateProtection bit=NULL,
@InadequateEyeProtection bit=NULL,
@InadequateRespirationProtection bit=NULL,
@OtherIPPE bit=NULL,
@OtherIPPEText nvarchar(250)=NULL,
@SafeBehavior bit=NULL,
@UnsafeBehavior bit=NULL,
@TaskCompletion bit=NULL,
@InadequateFeedback bit=NULL,
@SimilarUnacceptable bit=NULL,
@ProductionOverSafe bit=NULL,
@OtherIFS bit=NULL,
@OtherIFSText nvarchar(250)=NULL,
@RequiredSFNP bit=NULL,
@FrequentMaintenanceRequired bit=NULL,
@OtherIIE bit=NULL,
@OtherIIEText nvarchar(250)=NULL,
@InconsistentEOSP bit=NULL,
@SimilarUBNC bit=NULL,
@writtenPractices bit=NULL,
@OtherNESP bit=NULL,
@OtherNESPText nvarchar(250)=NULL,
@NoEstablishedProcedure bit=NULL,
@ExistingProcedureDNRH bit=NULL,
@OtherUnsafeMethod bit=NULL,
@OtherUnsafeMethodText nvarchar(250)=NULL,
@NASOI bit=NULL,
@ConfinedSpace bit=NULL,
@Clothing bit=NULL,
@FireOrSmoke bit=NULL,
@Conveyor bit=NULL,
@HandTool bit=NULL,
@ElectricalApparatus bit=NULL,
@AirContanminants bit=NULL,
@NoiseExposure bit=NULL,
@DrumContainerPallet bit=NULL,
@PackingEquipment bit=NULL,
@HandlingEquipment bit=NULL,
@OperationTools bit=NULL,
@Machinery bit=NULL,
@Vehicle bit=NULL,
@QuayVessel bit=NULL,
@TemperatureExtremes bit=NULL,
@Door bit=NULL,
@PlatformWS bit=NULL,
@CompressedAG bit=NULL,
@HotWork bit=NULL,
@HazardousMaterial bit=NULL,
@HazardousChemical bit=NULL,
@GlassItems bit=NULL,
@HoistingApparatus bit=NULL,
@GangwayLadder bit=NULL,
@WoodLCE bit=NULL,
@StairwayWalkway bit=NULL,
@FloorWarkingSurface bit=NULL,
@EmergencyAction bit=NULL,
@AnimalInsect bit=NULL,
@WiresBands bit=NULL,
@SharpMetalEdge bit=NULL,
@ExcavationTrench bit=NULL,
@HeatingEquipment bit=NULL,
@OtherSOI bit=NULL,
@OtherSOIText nvarchar(250)=NULL,
@Weeks01 bit=NULL,
@Weeks23 bit=NULL,
@Months15 bit=NULL,
@Months611 bit=NULL,
@Years14 bit=NULL,
@Years59 bit=NULL,
@Year1019 bit=NULL,
@YearOver20 bit=NULL,
@NAIncidentType bit=NULL,
@StruckBy bit=NULL,
@StruckAgainst bit=NULL,
@CaughtInUnderBetween bit=NULL,
@Overexertion bit=NULL,
@LiftingTwisting bit=NULL,
@Inhalation bit=NULL,
@FallFromElevation bit=NULL,
@SlipStripFSL bit=NULL,
@RubbebOrAbraded bit=NULL,
@BiteOrSting bit=NULL,
@OtherIncidentType bit=NULL,
@OtherIncidentTypeText nvarchar(250)=NULL,
@NAOperatingStatus bit=NULL,
@Startup bit=NULL,
@NormalOS bit=NULL,
@Upset bit=NULL,
@ShutdownOrMaintenance bit=NULL,
@OtherOperatingStatus bit=NULL,
@OtherOperatingStatusText nvarchar(250)=NULL,
@Quay bit=NULL,
@Vessel bit=NULL,
@Warehouse bit=NULL,
@Office bit=NULL,
@Workshop bit=NULL,
@Yard bit=NULL,
@Road bit=NULL,
@OtherIncidentArea bit=NULL,
@OtherIncidentAreaText nvarchar(250)=NULL,
@Sunday bit=NULL,
@Monday bit=NULL,
@Tuesday bit=NULL,
@Wednesday bit=NULL,
@Thursday bit=NULL,
@Friday bit=NULL,
@Saturday bit=NULL,
@NoUnsafeCondition bit=NULL,
@PoorHouseKeeping bit=NULL,
@GuardingPNIP bit=NULL,
@FireAEH bit=NULL,
@InadequateWarningSystem bit=NULL,
@InadequatePPEUC bit=NULL,
@DefectiveTE bit=NULL,
@HighTemperatureExtrems bit=NULL,
@RadiationNSE bit=NULL,
@InadequateLighting bit=NULL,
@InadequateVentilation bit=NULL,
@OtherUnsafeConditions bit=NULL,
@OtherUnsafeConditionsText nvarchar(250)=NULL,
@NoUnsafeAct bit=NULL,
@WorkingOnME bit=NULL,
@UnderTheIOAD bit=NULL,
@InadequatePersonalAttire bit=NULL,
@OperatingEWA bit=NULL,
@FailuretoSOW bit=NULL,
@Horseplay bit=NULL,
@ImproperUseOfEquipment bit=NULL,
@MakingSafetyDevices bit=NULL,
@FailureTPUPPE bit=NULL,
@WorkingAtUS bit=NULL,
@TakingUPP bit=NULL,
@UnsafeLiftingCarrying bit=NULL,
@UsingUnsafeEquipment bit=NULL,
@OtherUnsafeActs bit=NULL,
@OtherUnsafeActsText nvarchar(250)=NULL,
@Lock bit=null,
@ApprovalByHSE nvarchar(200)=NULL,
@ApprovalDateHSE datetime=null,
@Pic1 image=null,
@Pic2 image=null,
@Pic1_Des nvarchar(200)=NULL,
@Pic2_Des nvarchar(200)=NULL,
@TB [ST_IncidentAndAccident_ImmediateAction] READONLY,
@TB1 [ST_IncidentAndAccident_PermanentAction] READONLY
)
AS
BEGIN
	IF @ACTION ='LOCK'
	BEGIN
		UPDATE [dbo].[ST_IncidentAndAccident] SET Lock='True' WHERE  ID=@ID
	END
	IF @ACTION='LIST_INCHARGE'
	BEGIN
		SELECT [ID],[Staffname],[Description] FROM	[dbo].[ST_Safety] ORDER BY ID
	END
	IF @ACTION ='CHECK_APPROVAL'
	BEGIN
		SELECT 1 FROM [dbo].[ST_IncidentAndAccident] WHERE ISNULL(ApprovalBy,'') <> '' AND ID=@ID
	END
	IF @ACTION ='CHECK_APPROVAL_HSE'
	BEGIN
		SELECT 1 FROM [dbo].[ST_IncidentAndAccident] WHERE ISNULL(ApprovalByHSE,'') <> '' AND ID=@ID
	END
	IF @ACTION='GET_USER'
	BEGIN
		SELECT USERNAME,PASS FROM W_USERS WHERE USERNAME=@UserLogin
	END
	IF @Action='LIST'
	BEGIN
		SELECT [ID],[DocNum],convert(varchar(10),[DocDate],103)[DocDate],[DetailofTheInjured],convert(varchar(8),[TimeofIncident],114)[TimeofIncident] 
		FROM [dbo].[ST_IncidentAndAccident]
		ORDER BY [ID]
	END
	IF @Action='GET_BY_ID'
	BEGIN
		SELECT 
			[ID]
			,[DocNum]
			,[DocDate]
			,[DetailofTheInjured]
			,[TimeofIncident]
			,[PleaseStateCompany]
			,[IncidentPlace]
			,[IncidentReportingPerson]
			,[EquipTag]
			,[WorkingTime]
			,ISNULL([External],'False')[External]
			,[HPES1]
			,[HPES2]
			,[HPES3]
			,[HPES4]
			,[HPES5]
			,[HPES6]
			,[Normal]
			,[Overtime]
			,[InChargeOfAccident]
			,[JobPosition]
			,[DeptManComments]
			,[DateIncharge]
			,[ApprovalBy]
			,[ApprovalDate]
			,[FirstAID]
			,[NearMiss]
			,[MTC]
			,[PropertyDamage]
			,[RWC]
			,[LTA]
			,[Fatality]
			,[Environment]
			,[WorkRelatedIllness]
			,[Fire]
			,[NonEmployee]
			,[EstimatedCCST]
			,[Minor]
			,[Senious]
			,[Major]
			,[IfPropertyDamage]
			,[EstimatedCost]
			,[Head]
			,[LeftRight]
			,[Eye]
			,[Back]
			,[Leg]
			,[Arm]
			,[Finger]
			,[OtherIncident]
			,[Poor]
			,[Fair]
			,[Good]
			,[Wet]
			,[Slippery]
			,[Tripping]
			,[Uneven]
			,[Rainy]
			,[Fog]
			,[Windy]
			,[Dark]
			,[Hot]
			,[IncidentDescription]
			,[ImmediateCauses]
			,[LackOfKnowledge]
			,[EmployeePlacement]
			,[NotEnforcingST]
			,[DesignInstallation]
			,[InadequatePPE]
			,[InadequateInspection]
			,[InadequateEquipment]
			,[InadequateObservation]
			,[UnsafeMethod]
			--,[EstimatedCost1]
			--,[EstimatedCost2]
			,[ImproperUOE]
			,[InadequateEFT]
			,[SafeMNK]
			,[EmployeeNQPT]
			,[OtherLOK]
			,[OtherLOKText]
			,[InadequateGuarding]
			,[UnsafeDesign]
			,[NoAssistForFrequently]
			,[DiffcultPTS]
			,[ExposedPPoOH]
			,[OtherDesgn]
			,[OtheDesignText]
			,[DefectiveTools]
			,[InoperativeSafety]
			,[InadequateLabeling]
			,[HazardByNWT]
			,[EquipdeviceUNR]
			,[EquipDeviceFDU]
			,[OtherInadequateInspection]
			,[OtherInadequateInspectionText]
			,[PhysicalOver]
			,[TaskExceededMR]
			,[RecurrenceOAPI]
			,[Illness]
			,[OtherEmplyeePlacement]
			,[OtherEmplyeePlacementText]
			,[NecessarySafetyEquip]
			,[InadequateProtection]
			,[InadequateEyeProtection]
			,[InadequateRespirationProtection]
			,[OtherIPPE]
			,[OtherIPPEText]
			,[SafeBehavior]
			,[UnsafeBehavior]
			,[TaskCompletion]
			,[InadequateFeedback]
			,[SimilarUnacceptable]
			,[ProductionOverSafe]
			,[OtherIFS]
			,[OtherIFSText]
			,[RequiredSFNP]
			,[FrequentMaintenanceRequired]
			,[OtherIIE]
			,[OtherIIEText]
			,[InconsistentEOSP]
			,[SimilarUBNC]
			,[writtenPractices]
			,[OtherNESP]
			,[OtherNESPText]
			,[NoEstablishedProcedure]
			,[ExistingProcedureDNRH]
			,[OtherUnsafeMethod]
			,[OtherUnsafeMethodText]
			,[NASOI]
			,[ConfinedSpace]
			,[Clothing]
			,[FireOrSmoke]
			,[Conveyor]
			,[HandTool]
			,[ElectricalApparatus]
			,[AirContanminants]
			,[NoiseExposure]
			,[DrumContainerPallet]
			,[PackingEquipment]
			,[HandlingEquipment]
			,[OperationTools]
			,[Machinery]
			,[Vehicle]
			,[QuayVessel]
			,[TemperatureExtremes]
			,[Door]
			,[PlatformWS]
			,[CompressedAG]
			,[HotWork]
			,[HazardousMaterial]
			,[HazardousChemical]
			,[GlassItems]
			,[HoistingApparatus]
			,[GangwayLadder]
			,[WoodLCE]
			,[StairwayWalkway]
			,[FloorWarkingSurface]
			,[EmergencyAction]
			,[AnimalInsect]
			,[WiresBands]
			,[SharpMetalEdge]
			,[ExcavationTrench]
			,[HeatingEquipment]
			,[OtherSOI]
			,[OtherSOIText]
			,[Weeks01]
			,[Weeks23]
			,[Months15]
			,[Months611]
			,[Years14]
			,[Years59]
			,[Year1019]
			,[YearOver20]
			,[NAIncidentType]
			,[StruckBy]
			,[StruckAgainst]
			,[CaughtInUnderBetween]
			,[Overexertion]
			,[LiftingTwisting]
			,[Inhalation]
			,[FallFromElevation]
			,[SlipStripFSL]
			,[RubbebOrAbraded]
			,[BiteOrSting]
			,[OtherIncidentType]
			,[OtherIncidentTypeText]
			,[NAOperatingStatus]
			,[Startup]
			,[NormalOS]
			,[Upset]
			,[ShutdownOrMaintenance]
			,[OtherOperatingStatus]
			,[OtherOperatingStatusText]
			,[Quay]
			,[Vessel]
			,[Warehouse]
			,[Office]
			,[Workshop]
			,[Yard]
			,[Road]
			,[OtherIncidentArea]
			,[OtherIncidentAreaText]
			,[Sunday]
			,[Monday]
			,[Tuesday]
			,[Wednesday]
			,[Thursday]
			,[Friday]
			,[Saturday]
			,[NoUnsafeCondition]
			,[PoorHouseKeeping]
			,[GuardingPNIP]
			,[FireAEH]
			,[InadequateWarningSystem]
			,[InadequatePPEUC]
			,[DefectiveTE]
			,[HighTemperatureExtrems]
			,[RadiationNSE]
			,[InadequateLighting]
			,[InadequateVentilation]
			,[OtherUnsafeConditions]
			,[OtherUnsafeConditionsText]
			,[NoUnsafeAct]
			,[WorkingOnME]
			,[UnderTheIOAD]
			,[InadequatePersonalAttire]
			,[OperatingEWA]
			,[FailuretoSOW]
			,[Horseplay]
			,[ImproperUseOfEquipment]
			,[MakingSafetyDevices]
			,[FailureTPUPPE]
			,[WorkingAtUS]
			,[TakingUPP]
			,[UnsafeLiftingCarrying]
			,[UsingUnsafeEquipment]
			,[OtherUnsafeActs]
			,[OtherUnsafeActsText]
			,[Lock]
			,[ApprovalByHSE]
			,[ApprovalDateHSE]
			,[Pic1]
			,[Pic1_Des]
			,[Pic2]
			,[Pic2_Des]
		FROM [dbo].[ST_IncidentAndAccident]
		WHERE ID=@ID
	END
	IF @Action='GET_DETAIL'
	BEGIN
		SELECT 
			[ID]
			,[IncidentAndAccidentID]
			,[Actions]
			,[Date]
			,[Incharge]
			,[FollowUpDate]
			,[FollowUpInCharge]
		FROM [dbo].[ST_IncidentAndAccident_ImmediateAction]
		WHERE [IncidentAndAccidentID]=@ID
	END
	IF @Action='GET_DETAIL_1'
	BEGIN
		SELECT 
			[ID]
			,[IncidentAndAccidentID]
			,[Actions]
			,[Date]
			,[Incharge]
			,[FollowUpDate]
			,[FollowUpInCharge]
		FROM [dbo].[ST_IncidentAndAccident_PermanentAction]
		WHERE [IncidentAndAccidentID]=@ID
	END
	IF @ACTION='ADD'
	BEGIN
		IF NOT EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident] WHERE ID=@ID)
		BEGIN
			INSERT INTO [dbo].[ST_IncidentAndAccident]
           ([DocNum]
           ,[DocDate]
           ,[DetailofTheInjured]
           ,[TimeofIncident]
           ,[PleaseStateCompany]
           ,[IncidentPlace]
           ,[IncidentReportingPerson]
           ,[EquipTag]
           ,[WorkingTime]
		   ,[External]
           ,[HPES1]
           ,[HPES2]
           ,[HPES3]
           ,[HPES4]
           ,[HPES5]
           ,[HPES6]
           ,[Normal]
           ,[Overtime]
           ,[InChargeOfAccident]
           ,[JobPosition]
           ,[DeptManComments]
           ,[DateIncharge]
           ,[ApprovalBy]
           ,[ApprovalDate]
           ,[FirstAID]
           ,[NearMiss]
           ,[MTC]
           ,[PropertyDamage]
           ,[RWC]
           ,[LTA]
           ,[Fatality]
           ,[Environment]
           ,[WorkRelatedIllness]
           ,[Fire]
           ,[NonEmployee]
           ,[EstimatedCCST]
           ,[Minor]
           ,[Senious]
           ,[Major]
           ,[IfPropertyDamage]
           ,[EstimatedCost]
           ,[Head]
           ,[LeftRight]
           ,[Eye]
           ,[Back]
           ,[Leg]
           ,[Arm]
           ,[Finger]
           ,[OtherIncident]
           ,[Poor]
           ,[Fair]
           ,[Good]
           ,[Wet]
           ,[Slippery]
           ,[Tripping]
           ,[Uneven]
           ,[Rainy]
           ,[Fog]
           ,[Windy]
           ,[Dark]
           ,[Hot]
           ,[IncidentDescription]
           ,[ImmediateCauses]
           ,[LackOfKnowledge]
           ,[EmployeePlacement]
           ,[NotEnforcingST]
           ,[DesignInstallation]
           ,[InadequatePPE]
           ,[InadequateInspection]
           ,[InadequateEquipment]
           ,[InadequateObservation]
           ,[UnsafeMethod]
           --,[EstimatedCost1]
           --,[EstimatedCost2]
           ,[ImproperUOE]
           ,[InadequateEFT]
           ,[SafeMNK]
           ,[EmployeeNQPT]
           ,[OtherLOK]
           ,[OtherLOKText]
           ,[InadequateGuarding]
           ,[UnsafeDesign]
           ,[NoAssistForFrequently]
           ,[DiffcultPTS]
           ,[ExposedPPoOH]
           ,[OtherDesgn]
           ,[OtheDesignText]
           ,[DefectiveTools]
           ,[InoperativeSafety]
           ,[InadequateLabeling]
           ,[HazardByNWT]
           ,[EquipdeviceUNR]
           ,[EquipDeviceFDU]
           ,[OtherInadequateInspection]
           ,[OtherInadequateInspectionText]
           ,[PhysicalOver]
           ,[TaskExceededMR]
           ,[RecurrenceOAPI]
           ,[Illness]
           ,[OtherEmplyeePlacement]
           ,[OtherEmplyeePlacementText]
           ,[NecessarySafetyEquip]
           ,[InadequateProtection]
           ,[InadequateEyeProtection]
           ,[InadequateRespirationProtection]
           ,[OtherIPPE]
           ,[OtherIPPEText]
           ,[SafeBehavior]
           ,[UnsafeBehavior]
           ,[TaskCompletion]
           ,[InadequateFeedback]
           ,[SimilarUnacceptable]
           ,[ProductionOverSafe]
           ,[OtherIFS]
           ,[OtherIFSText]
           ,[RequiredSFNP]
           ,[FrequentMaintenanceRequired]
           ,[OtherIIE]
           ,[OtherIIEText]
           ,[InconsistentEOSP]
           ,[SimilarUBNC]
           ,[writtenPractices]
           ,[OtherNESP]
           ,[OtherNESPText]
           ,[NoEstablishedProcedure]
           ,[ExistingProcedureDNRH]
           ,[OtherUnsafeMethod]
           ,[OtherUnsafeMethodText]
           ,[NASOI]
           ,[ConfinedSpace]
           ,[Clothing]
           ,[FireOrSmoke]
           ,[Conveyor]
           ,[HandTool]
           ,[ElectricalApparatus]
           ,[AirContanminants]
           ,[NoiseExposure]
           ,[DrumContainerPallet]
           ,[PackingEquipment]
           ,[HandlingEquipment]
           ,[OperationTools]
           ,[Machinery]
           ,[Vehicle]
           ,[QuayVessel]
           ,[TemperatureExtremes]
           ,[Door]
           ,[PlatformWS]
           ,[CompressedAG]
           ,[HotWork]
           ,[HazardousMaterial]
           ,[HazardousChemical]
           ,[GlassItems]
           ,[HoistingApparatus]
           ,[GangwayLadder]
           ,[WoodLCE]
           ,[StairwayWalkway]
           ,[FloorWarkingSurface]
           ,[EmergencyAction]
           ,[AnimalInsect]
           ,[WiresBands]
           ,[SharpMetalEdge]
           ,[ExcavationTrench]
           ,[HeatingEquipment]
           ,[OtherSOI]
           ,[OtherSOIText]
           ,[Weeks01]
           ,[Weeks23]
           ,[Months15]
           ,[Months611]
           ,[Years14]
           ,[Years59]
           ,[Year1019]
           ,[YearOver20]
           ,[NAIncidentType]
           ,[StruckBy]
           ,[StruckAgainst]
           ,[CaughtInUnderBetween]
           ,[Overexertion]
           ,[LiftingTwisting]
           ,[Inhalation]
           ,[FallFromElevation]
           ,[SlipStripFSL]
           ,[RubbebOrAbraded]
           ,[BiteOrSting]
           ,[OtherIncidentType]
           ,[OtherIncidentTypeText]
           ,[NAOperatingStatus]
           ,[Startup]
           ,[NormalOS]
           ,[Upset]
           ,[ShutdownOrMaintenance]
           ,[OtherOperatingStatus]
           ,[OtherOperatingStatusText]
           ,[Quay]
           ,[Vessel]
           ,[Warehouse]
           ,[Office]
           ,[Workshop]
           ,[Yard]
           ,[Road]
           ,[OtherIncidentArea]
           ,[OtherIncidentAreaText]
           ,[Sunday]
           ,[Monday]
           ,[Tuesday]
           ,[Wednesday]
           ,[Thursday]
           ,[Friday]
           ,[Saturday]
           ,[NoUnsafeCondition]
           ,[PoorHouseKeeping]
           ,[GuardingPNIP]
           ,[FireAEH]
           ,[InadequateWarningSystem]
           ,[InadequatePPEUC]
           ,[DefectiveTE]
           ,[HighTemperatureExtrems]
           ,[RadiationNSE]
           ,[InadequateLighting]
           ,[InadequateVentilation]
           ,[OtherUnsafeConditions]
           ,[OtherUnsafeConditionsText]
           ,[NoUnsafeAct]
           ,[WorkingOnME]
           ,[UnderTheIOAD]
           ,[InadequatePersonalAttire]
           ,[OperatingEWA]
           ,[FailuretoSOW]
           ,[Horseplay]
           ,[ImproperUseOfEquipment]
           ,[MakingSafetyDevices]
           ,[FailureTPUPPE]
           ,[WorkingAtUS]
           ,[TakingUPP]
           ,[UnsafeLiftingCarrying]
           ,[UsingUnsafeEquipment]
           ,[OtherUnsafeActs]
           ,[OtherUnsafeActsText]
		   ,[Lock]
		   ,[ApprovalByHSE]
		   ,[ApprovalDateHSE]
		   ,[Pic1]
		   ,[Pic1_Des]
		   ,[Pic2]
		   ,[Pic2_Des])
		VALUES
           (@DocNum
           ,@DocDate
           ,@DetailofTheInjured
           ,@TimeofIncident
           ,@PleaseStateCompany
           ,@IncidentPlace
           ,@IncidentReportingPerson
           ,@EquipTag
           ,@WorkingTime
		   ,@External
           ,@HPES1
           ,@HPES2
           ,@HPES3
           ,@HPES4
           ,@HPES5
           ,@HPES6
           ,@Normal
           ,@Overtime
           ,@InChargeOfAccident
           ,@JobPosition
           ,@DeptManComments
           ,@DateIncharge
           ,@ApprovalBy
           ,@ApprovalDate
           ,@FirstAID
           ,@NearMiss
           ,@MTC
           ,@PropertyDamage
           ,@RWC
           ,@LTA
           ,@Fatality
           ,@Environment
           ,@WorkRelatedIllness
           ,@Fire
           ,@NonEmployee
           ,@EstimatedCCST
           ,@Minor
           ,@Senious
           ,@Major
           ,@IfPropertyDamage
           ,@EstimatedCost
           ,@Head
           ,@LeftRight
           ,@Eye
           ,@Back
           ,@Leg
           ,@Arm
           ,@Finger
           ,@OtherIncident
           ,@Poor
           ,@Fair
           ,@Good
           ,@Wet
           ,@Slippery
           ,@Tripping
           ,@Uneven
           ,@Rainy
           ,@Fog
           ,@Windy
           ,@Dark
           ,@Hot
           ,@IncidentDescription
           ,@ImmediateCauses
           ,@LackOfKnowledge
           ,@EmployeePlacement
           ,@NotEnforcingST
           ,@DesignInstallation
           ,@InadequatePPE
           ,@InadequateInspection
           ,@InadequateEquipment
           ,@InadequateObservation
           ,@UnsafeMethod
           --,@EstimatedCost1
           --,@EstimatedCost2
           ,@ImproperUOE
           ,@InadequateEFT
           ,@SafeMNK
           ,@EmployeeNQPT
           ,@OtherLOK
           ,@OtherLOKText
           ,@InadequateGuarding
           ,@UnsafeDesign
           ,@NoAssistForFrequently
           ,@DiffcultPTS
           ,@ExposedPPoOH
           ,@OtherDesgn
           ,@OtheDesignText
           ,@DefectiveTools
           ,@InoperativeSafety
           ,@InadequateLabeling
           ,@HazardByNWT
           ,@EquipdeviceUNR
           ,@EquipDeviceFDU
           ,@OtherInadequateInspection
           ,@OtherInadequateInspectionText
           ,@PhysicalOver
           ,@TaskExceededMR
           ,@RecurrenceOAPI
           ,@Illness
           ,@OtherEmplyeePlacement
           ,@OtherEmplyeePlacementText
           ,@NecessarySafetyEquip
           ,@InadequateProtection
           ,@InadequateEyeProtection
           ,@InadequateRespirationProtection
           ,@OtherIPPE
           ,@OtherIPPEText
           ,@SafeBehavior
           ,@UnsafeBehavior
           ,@TaskCompletion
           ,@InadequateFeedback
           ,@SimilarUnacceptable
           ,@ProductionOverSafe
           ,@OtherIFS
           ,@OtherIFSText
           ,@RequiredSFNP
           ,@FrequentMaintenanceRequired
           ,@OtherIIE
           ,@OtherIIEText
           ,@InconsistentEOSP
           ,@SimilarUBNC
           ,@writtenPractices
           ,@OtherNESP
           ,@OtherNESPText
           ,@NoEstablishedProcedure
           ,@ExistingProcedureDNRH
           ,@OtherUnsafeMethod
           ,@OtherUnsafeMethodText
           ,@NASOI
           ,@ConfinedSpace
           ,@Clothing
           ,@FireOrSmoke
           ,@Conveyor
           ,@HandTool
           ,@ElectricalApparatus
           ,@AirContanminants
           ,@NoiseExposure
           ,@DrumContainerPallet
           ,@PackingEquipment
           ,@HandlingEquipment
           ,@OperationTools
           ,@Machinery
           ,@Vehicle
           ,@QuayVessel
           ,@TemperatureExtremes
           ,@Door
           ,@PlatformWS
           ,@CompressedAG
           ,@HotWork
           ,@HazardousMaterial
           ,@HazardousChemical
           ,@GlassItems
           ,@HoistingApparatus
           ,@GangwayLadder
           ,@WoodLCE
           ,@StairwayWalkway
           ,@FloorWarkingSurface
           ,@EmergencyAction
           ,@AnimalInsect
           ,@WiresBands
           ,@SharpMetalEdge
           ,@ExcavationTrench
           ,@HeatingEquipment
           ,@OtherSOI
           ,@OtherSOIText
           ,@Weeks01
           ,@Weeks23
           ,@Months15
           ,@Months611
           ,@Years14
           ,@Years59
           ,@Year1019
           ,@YearOver20
           ,@NAIncidentType
           ,@StruckBy
           ,@StruckAgainst
           ,@CaughtInUnderBetween
           ,@Overexertion
           ,@LiftingTwisting
           ,@Inhalation
           ,@FallFromElevation
           ,@SlipStripFSL
           ,@RubbebOrAbraded
           ,@BiteOrSting
           ,@OtherIncidentType
           ,@OtherIncidentTypeText
           ,@NAOperatingStatus
           ,@Startup
           ,@NormalOS
           ,@Upset
           ,@ShutdownOrMaintenance
           ,@OtherOperatingStatus
           ,@OtherOperatingStatusText
           ,@Quay
           ,@Vessel
           ,@Warehouse
           ,@Office
           ,@Workshop
           ,@Yard
           ,@Road
           ,@OtherIncidentArea
           ,@OtherIncidentAreaText
           ,@Sunday
           ,@Monday
           ,@Tuesday
           ,@Wednesday
           ,@Thursday
           ,@Friday
           ,@Saturday
           ,@NoUnsafeCondition
           ,@PoorHouseKeeping
           ,@GuardingPNIP
           ,@FireAEH
           ,@InadequateWarningSystem
           ,@InadequatePPEUC
           ,@DefectiveTE
           ,@HighTemperatureExtrems
           ,@RadiationNSE
           ,@InadequateLighting
           ,@InadequateVentilation
           ,@OtherUnsafeConditions
           ,@OtherUnsafeConditionsText
           ,@NoUnsafeAct
           ,@WorkingOnME
           ,@UnderTheIOAD
           ,@InadequatePersonalAttire
           ,@OperatingEWA
           ,@FailuretoSOW
           ,@Horseplay
           ,@ImproperUseOfEquipment
           ,@MakingSafetyDevices
           ,@FailureTPUPPE
           ,@WorkingAtUS
           ,@TakingUPP
           ,@UnsafeLiftingCarrying
           ,@UsingUnsafeEquipment
           ,@OtherUnsafeActs
           ,@OtherUnsafeActsText
		   ,@Lock
		   ,@ApprovalByHSE
		   ,@ApprovalDateHSE
		   ,@Pic1
		   ,@Pic1_Des
		   ,@Pic2
		   ,@Pic2_Des)
		END
		SET @ID=ISNULL((SELECT MAX(ID) FROM [dbo].[ST_IncidentAndAccident]),1)
		IF NOT EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident_ImmediateAction] WHERE [IncidentAndAccidentID]=@ID)
		BEGIN
			INSERT INTO [dbo].[ST_IncidentAndAccident_ImmediateAction]
			([IncidentAndAccidentID]
			,[Actions]
			,[Date]
			,[Incharge]
			,[FollowUpDate]
			,[FollowUpInCharge])
			SELECT @ID,[Actions],[Date],[Incharge],[FollowUpDate],[FollowUpInCharge] FROM @TB
		END
		IF NOT EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident_PermanentAction] WHERE [IncidentAndAccidentID]=@ID)
		BEGIN
			INSERT INTO [dbo].[ST_IncidentAndAccident_PermanentAction]
			   ([IncidentAndAccidentID]
			   ,[Actions]
			   ,[Date]
			   ,[Incharge]
			   ,[FollowUpDate]
			   ,[FollowUpInCharge])
			SELECT @ID,[Actions],[Date],[Incharge],[FollowUpDate],[FollowUpInCharge] FROM @TB1
		END
	END
	IF @Action='UPDATE'
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident] WHERE ID=@ID)
		BEGIN
			UPDATE [dbo].[ST_IncidentAndAccident]
			SET [DocNum] = @DocNum
				,[DocDate] = @DocDate
				,[DetailofTheInjured] = @DetailofTheInjured
				,[TimeofIncident] = @TimeofIncident
				,[PleaseStateCompany] = @PleaseStateCompany
				,[IncidentPlace] = @IncidentPlace
				,[IncidentReportingPerson] = @IncidentReportingPerson
				,[EquipTag] = @EquipTag
				,[WorkingTime] = @WorkingTime
				,[External]=@External
				,[HPES1] = @HPES1
				,[HPES2] = @HPES2
				,[HPES3] = @HPES3
				,[HPES4] = @HPES4
				,[HPES5] = @HPES5
				,[HPES6] = @HPES6
				,[Normal] = @Normal
				,[Overtime] = @Overtime
				,[InChargeOfAccident] = @InChargeOfAccident
				,[JobPosition] = @JobPosition
				,[DeptManComments] = @DeptManComments
				,[DateIncharge] = @DateIncharge
				,[ApprovalBy] = @ApprovalBy
				,[ApprovalDate] = @ApprovalDate
				,[FirstAID] = @FirstAID
				,[NearMiss] = @NearMiss
				,[MTC] = @MTC
				,[PropertyDamage] = @PropertyDamage
				,[RWC] = @RWC
				,[LTA] = @LTA
				,[Fatality] = @Fatality
				,[Environment] = @Environment
				,[WorkRelatedIllness] = @WorkRelatedIllness
				,[Fire] = @Fire
				,[NonEmployee] = @NonEmployee
				,[EstimatedCCST] = @EstimatedCCST
				,[Minor] = @Minor
				,[Senious] = @Senious
				,[Major] = @Major
				,[IfPropertyDamage] = @IfPropertyDamage
				,[EstimatedCost] = @EstimatedCost
				,[Head] = @Head
				,[LeftRight] = @LeftRight
				,[Eye] = @Eye
				,[Back] = @Back
				,[Leg] = @Leg
				,[Arm] = @Arm
				,[Finger] = @Finger
				,[OtherIncident] = @OtherIncident
				,[Poor] = @Poor
				,[Fair] = @Fair
				,[Good] = @Good
				,[Wet] = @Wet
				,[Slippery] = @Slippery
				,[Tripping] = @Tripping
				,[Uneven] = @Uneven
				,[Rainy] = @Rainy
				,[Fog] = @Fog
				,[Windy] = @Windy
				,[Dark] = @Dark
				,[Hot] = @Hot
				,[IncidentDescription] = @IncidentDescription
				,[ImmediateCauses] = @ImmediateCauses
				,[LackOfKnowledge] = @LackOfKnowledge
				,[EmployeePlacement] = @EmployeePlacement
				,[NotEnforcingST] = @NotEnforcingST
				,[DesignInstallation] = @DesignInstallation
				,[InadequatePPE] = @InadequatePPE
				,[InadequateInspection] = @InadequateInspection
				,[InadequateEquipment] = @InadequateEquipment
				,[InadequateObservation] = @InadequateObservation
				,[UnsafeMethod] = @UnsafeMethod
				--,[EstimatedCost1] = @EstimatedCost1
				--,[EstimatedCost2] = @EstimatedCost2
				,[ImproperUOE] = @ImproperUOE
				,[InadequateEFT] = @InadequateEFT
				,[SafeMNK] = @SafeMNK
				,[EmployeeNQPT] = @EmployeeNQPT
				,[OtherLOK] = @OtherLOK
				,[OtherLOKText] = @OtherLOKText
				,[InadequateGuarding] = @InadequateGuarding
				,[UnsafeDesign] = @UnsafeDesign
				,[NoAssistForFrequently] = @NoAssistForFrequently
				,[DiffcultPTS] = @DiffcultPTS
				,[ExposedPPoOH] = @ExposedPPoOH
				,[OtherDesgn] = @OtherDesgn
				,[OtheDesignText] = @OtheDesignText
				,[DefectiveTools] = @DefectiveTools
				,[InoperativeSafety] = @InoperativeSafety
				,[InadequateLabeling] = @InadequateLabeling
				,[HazardByNWT] = @HazardByNWT
				,[EquipdeviceUNR] = @EquipdeviceUNR
				,[EquipDeviceFDU] = @EquipDeviceFDU
				,[OtherInadequateInspection] = @OtherInadequateInspection
				,[OtherInadequateInspectionText] = @OtherInadequateInspectionText
				,[PhysicalOver] = @PhysicalOver
				,[TaskExceededMR] = @TaskExceededMR
				,[RecurrenceOAPI] = @RecurrenceOAPI
				,[Illness] = @Illness
				,[OtherEmplyeePlacement] = @OtherEmplyeePlacement
				,[OtherEmplyeePlacementText] = @OtherEmplyeePlacementText
				,[NecessarySafetyEquip] = @NecessarySafetyEquip
				,[InadequateProtection] = @InadequateProtection
				,[InadequateEyeProtection] = @InadequateEyeProtection
				,[InadequateRespirationProtection] = @InadequateRespirationProtection
				,[OtherIPPE] = @OtherIPPE
				,[OtherIPPEText] = @OtherIPPEText
				,[SafeBehavior] = @SafeBehavior
				,[UnsafeBehavior] = @UnsafeBehavior
				,[TaskCompletion] = @TaskCompletion
				,[InadequateFeedback] = @InadequateFeedback
				,[SimilarUnacceptable] = @SimilarUnacceptable
				,[ProductionOverSafe] = @ProductionOverSafe
				,[OtherIFS] = @OtherIFS
				,[OtherIFSText] = @OtherIFSText
				,[RequiredSFNP] = @RequiredSFNP
				,[FrequentMaintenanceRequired] = @FrequentMaintenanceRequired
				,[OtherIIE] = @OtherIIE
				,[OtherIIEText] = @OtherIIEText
				,[InconsistentEOSP] = @InconsistentEOSP
				,[SimilarUBNC] = @SimilarUBNC
				,[writtenPractices] = @writtenPractices
				,[OtherNESP] = @OtherNESP
				,[OtherNESPText] = @OtherNESPText
				,[NoEstablishedProcedure] = @NoEstablishedProcedure
				,[ExistingProcedureDNRH] = @ExistingProcedureDNRH
				,[OtherUnsafeMethod] = @OtherUnsafeMethod
				,[OtherUnsafeMethodText] = @OtherUnsafeMethodText
				,[NASOI] = @NASOI
				,[ConfinedSpace] = @ConfinedSpace
				,[Clothing] = @Clothing
				,[FireOrSmoke] = @FireOrSmoke
				,[Conveyor] = @Conveyor
				,[HandTool] = @HandTool
				,[ElectricalApparatus] = @ElectricalApparatus
				,[AirContanminants] = @AirContanminants
				,[NoiseExposure] = @NoiseExposure
				,[DrumContainerPallet] = @DrumContainerPallet
				,[PackingEquipment] = @PackingEquipment
				,[HandlingEquipment] = @HandlingEquipment
				,[OperationTools] = @OperationTools
				,[Machinery] = @Machinery
				,[Vehicle] = @Vehicle
				,[QuayVessel] = @QuayVessel
				,[TemperatureExtremes] = @TemperatureExtremes
				,[Door] = @Door
				,[PlatformWS] = @PlatformWS
				,[CompressedAG] = @CompressedAG
				,[HotWork] = @HotWork
				,[HazardousMaterial] = @HazardousMaterial
				,[HazardousChemical] = @HazardousChemical
				,[GlassItems] = @GlassItems
				,[HoistingApparatus] = @HoistingApparatus
				,[GangwayLadder] = @GangwayLadder
				,[WoodLCE] = @WoodLCE
				,[StairwayWalkway] = @StairwayWalkway
				,[FloorWarkingSurface] = @FloorWarkingSurface
				,[EmergencyAction] = @EmergencyAction
				,[AnimalInsect] = @AnimalInsect
				,[WiresBands] = @WiresBands
				,[SharpMetalEdge] = @SharpMetalEdge
				,[ExcavationTrench] = @ExcavationTrench
				,[HeatingEquipment] = @HeatingEquipment
				,[OtherSOI] = @OtherSOI
				,[OtherSOIText] = @OtherSOIText
				,[Weeks01] = @Weeks01
				,[Weeks23] = @Weeks23
				,[Months15] = @Months15
				,[Months611] = @Months611
				,[Years14] = @Years14
				,[Years59] = @Years59
				,[Year1019] = @Year1019
				,[YearOver20] = @YearOver20
				,[NAIncidentType] = @NAIncidentType
				,[StruckBy] = @StruckBy
				,[StruckAgainst] = @StruckAgainst
				,[CaughtInUnderBetween] = @CaughtInUnderBetween
				,[Overexertion] = @Overexertion
				,[LiftingTwisting] = @LiftingTwisting
				,[Inhalation] = @Inhalation
				,[FallFromElevation] = @FallFromElevation
				,[SlipStripFSL] = @SlipStripFSL
				,[RubbebOrAbraded] = @RubbebOrAbraded
				,[BiteOrSting] = @BiteOrSting
				,[OtherIncidentType] = @OtherIncidentType
				,[OtherIncidentTypeText] = @OtherIncidentTypeText
				,[NAOperatingStatus] = @NAOperatingStatus
				,[Startup] = @Startup
				,[NormalOS] = @NormalOS
				,[Upset] = @Upset
				,[ShutdownOrMaintenance] = @ShutdownOrMaintenance
				,[OtherOperatingStatus] = @OtherOperatingStatus
				,[OtherOperatingStatusText] = @OtherOperatingStatusText
				,[Quay] = @Quay
				,[Vessel] = @Vessel
				,[Warehouse] = @Warehouse
				,[Office] = @Office
				,[Workshop] = @Workshop
				,[Yard] = @Yard
				,[Road] = @Road
				,[OtherIncidentArea] = @OtherIncidentArea
				,[OtherIncidentAreaText] = @OtherIncidentAreaText
				,[Sunday] = @Sunday
				,[Monday] = @Monday
				,[Tuesday] = @Tuesday
				,[Wednesday] = @Wednesday
				,[Thursday] = @Thursday
				,[Friday] = @Friday
				,[Saturday] = @Saturday
				,[NoUnsafeCondition] = @NoUnsafeCondition
				,[PoorHouseKeeping] = @PoorHouseKeeping
				,[GuardingPNIP] = @GuardingPNIP
				,[FireAEH] = @FireAEH
				,[InadequateWarningSystem] = @InadequateWarningSystem
				,[InadequatePPEUC] = @InadequatePPEUC
				,[DefectiveTE] = @DefectiveTE
				,[HighTemperatureExtrems] = @HighTemperatureExtrems
				,[RadiationNSE] = @RadiationNSE
				,[InadequateLighting] = @InadequateLighting
				,[InadequateVentilation] = @InadequateVentilation
				,[OtherUnsafeConditions] = @OtherUnsafeConditions
				,[OtherUnsafeConditionsText] = @OtherUnsafeConditionsText
				,[NoUnsafeAct] = @NoUnsafeAct
				,[WorkingOnME] = @WorkingOnME
				,[UnderTheIOAD] = @UnderTheIOAD
				,[InadequatePersonalAttire] = @InadequatePersonalAttire
				,[OperatingEWA] = @OperatingEWA
				,[FailuretoSOW] = @FailuretoSOW
				,[Horseplay] = @Horseplay
				,[ImproperUseOfEquipment] = @ImproperUseOfEquipment
				,[MakingSafetyDevices] = @MakingSafetyDevices
				,[FailureTPUPPE] = @FailureTPUPPE
				,[WorkingAtUS] = @WorkingAtUS
				,[TakingUPP] = @TakingUPP
				,[UnsafeLiftingCarrying] = @UnsafeLiftingCarrying
				,[UsingUnsafeEquipment] = @UsingUnsafeEquipment
				,[OtherUnsafeActs] = @OtherUnsafeActs
				,[OtherUnsafeActsText] = @OtherUnsafeActsText
				,[Lock]=@Lock
				,[ApprovalByHSE]=@ApprovalByHSE
				,[ApprovalDateHSE]=@ApprovalDateHSE
				,[Pic1]=@Pic1
				,[Pic1_Des]=@Pic1_Des
				,[Pic2]=@Pic2
				,[Pic2_Des]=@Pic2_Des
			WHERE ID=@ID
		END
		IF EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident_ImmediateAction] WHERE [IncidentAndAccidentID] =@ID)
		BEGIN
			DELETE [dbo].[ST_IncidentAndAccident_ImmediateAction] WHERE [IncidentAndAccidentID] =@ID
			INSERT INTO [dbo].[ST_IncidentAndAccident_ImmediateAction]
			([IncidentAndAccidentID]
			,[Actions]
			,[Date]
			,[Incharge]
			,[FollowUpDate]
			,[FollowUpInCharge])
		   SELECT @ID,[Actions],[Date],[Incharge],[FollowUpDate],[FollowUpInCharge] FROM @TB 
		END
		IF EXISTS(SELECT * FROM [dbo].[ST_IncidentAndAccident_PermanentAction] WHERE [IncidentAndAccidentID] =@ID)
		BEGIN
			DELETE  [dbo].[ST_IncidentAndAccident_PermanentAction] WHERE [IncidentAndAccidentID] =@ID
			INSERT INTO [dbo].[ST_IncidentAndAccident_PermanentAction]
			([IncidentAndAccidentID]
			,[Actions]
			,[Date]
			,[Incharge]
			,[FollowUpDate]
			,[FollowUpInCharge])
		   SELECT @ID,[Actions],[Date],[Incharge],[FollowUpDate],[FollowUpInCharge] FROM @TB1 
		END
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE [dbo].[ST_IncidentAndAccident] WHERE ID=@ID
		DELETE [dbo].[ST_IncidentAndAccident_ImmediateAction] WHERE [IncidentAndAccidentID]=@ID
		DELETE [dbo].[ST_IncidentAndAccident_PermanentAction] WHERE [IncidentAndAccidentID]=@ID
	END
	IF @Action='PRINT'
	BEGIN
		SELECT 
			[ID]
			,[DocNum]
			,(CONVERT(VARCHAR(10),[DocDate],103)+' '+CONVERT(VARCHAR(8),[DocDate],114))[DocDate]
			,[DetailofTheInjured]
			,CONVERT(VARCHAR(8),[TimeofIncident],114)[TimeofIncident]
			,[PleaseStateCompany]
			,[IncidentPlace]
			,[IncidentReportingPerson]
			,[EquipTag]
			,CONVERT(VARCHAR(8),[WorkingTime],114)[WorkingTime]
			,[External]
			,[HPES1]
			,[HPES2]
			,[HPES3]
			,[HPES4]
			,[HPES5]
			,[HPES6]
			,[Normal]
			,[Overtime]
			,[InChargeOfAccident]
			,[JobPosition]
			,[DeptManComments]
			,[DateIncharge]
			,[ApprovalBy]
			,[ApprovalDate]
			,[FirstAID]
			,[NearMiss]
			,[MTC]
			,[PropertyDamage]
			,[RWC]
			,[LTA]
			,[Fatality]
			,[Environment]
			,[WorkRelatedIllness]
			,[Fire]
			,[NonEmployee]
			,[EstimatedCCST]
			,[Minor]
			,[Senious]
			,[Major]
			,[IfPropertyDamage]
			,[EstimatedCost]
			,[Head]
			,[LeftRight]
			,[Eye]
			,[Back]
			,[Leg]
			,[Arm]
			,[Finger]
			,[OtherIncident]
			,[Poor]
			,[Fair]
			,[Good]
			,[Wet]
			,[Slippery]
			,[Tripping]
			,[Uneven]
			,[Rainy]
			,[Fog]
			,[Windy]
			,[Dark]
			,[Hot]
			,[IncidentDescription]
			,[ImmediateCauses]
			,ISNULL([LackOfKnowledge],'')[LackOfKnowledge]
			,ISNULL([EmployeePlacement],'')[EmployeePlacement]
			,ISNULL([NotEnforcingST],'')[NotEnforcingST]
			,ISNULL([DesignInstallation],'')[DesignInstallation]
			,ISNULL([InadequatePPE],'')[InadequatePPE]
			,ISNULL([InadequateInspection],'')[InadequateInspection]
			,ISNULL([InadequateEquipment],'')[InadequateEquipment]
			,ISNULL([InadequateObservation],'')[InadequateObservation]
			,ISNULL([UnsafeMethod],'')[UnsafeMethod]
			--,[EstimatedCost1]
			--,[EstimatedCost2]
			,[ImproperUOE]
			,[InadequateEFT]
			,[SafeMNK]
			,[EmployeeNQPT]
			,[OtherLOK]
			,[OtherLOKText]
			,[InadequateGuarding]
			,[UnsafeDesign]
			,[NoAssistForFrequently]
			,[DiffcultPTS]
			,[ExposedPPoOH]
			,[OtherDesgn]
			,[OtheDesignText]
			,[DefectiveTools]
			,[InoperativeSafety]
			,[InadequateLabeling]
			,[HazardByNWT]
			,[EquipdeviceUNR]
			,[EquipDeviceFDU]
			,[OtherInadequateInspection]
			,[OtherInadequateInspectionText]
			,[PhysicalOver]
			,[TaskExceededMR]
			,[RecurrenceOAPI]
			,[Illness]
			,[OtherEmplyeePlacement]
			,[OtherEmplyeePlacementText]
			,[NecessarySafetyEquip]
			,[InadequateProtection]
			,[InadequateEyeProtection]
			,[InadequateRespirationProtection]
			,[OtherIPPE]
			,[OtherIPPEText]
			,[SafeBehavior]
			,[UnsafeBehavior]
			,[TaskCompletion]
			,[InadequateFeedback]
			,[SimilarUnacceptable]
			,[ProductionOverSafe]
			,[OtherIFS]
			,[OtherIFSText]
			,[RequiredSFNP]
			,[FrequentMaintenanceRequired]
			,[OtherIIE]
			,[OtherIIEText]
			,[InconsistentEOSP]
			,[SimilarUBNC]
			,[writtenPractices]
			,[OtherNESP]
			,[OtherNESPText]
			,[NoEstablishedProcedure]
			,[ExistingProcedureDNRH]
			,[OtherUnsafeMethod]
			,[OtherUnsafeMethodText]
			,[NASOI]
			,[ConfinedSpace]
			,[Clothing]
			,[FireOrSmoke]
			,[Conveyor]
			,[HandTool]
			,[ElectricalApparatus]
			,[AirContanminants]
			,[NoiseExposure]
			,[DrumContainerPallet]
			,[PackingEquipment]
			,[HandlingEquipment]
			,[OperationTools]
			,[Machinery]
			,[Vehicle]
			,[QuayVessel]
			,[TemperatureExtremes]
			,[Door]
			,[PlatformWS]
			,[CompressedAG]
			,[HotWork]
			,[HazardousMaterial]
			,[HazardousChemical]
			,[GlassItems]
			,[HoistingApparatus]
			,[GangwayLadder]
			,[WoodLCE]
			,[StairwayWalkway]
			,[FloorWarkingSurface]
			,[EmergencyAction]
			,[AnimalInsect]
			,[WiresBands]
			,[SharpMetalEdge]
			,[ExcavationTrench]
			,[HeatingEquipment]
			,[OtherSOI]
			,[OtherSOIText]
			,[Weeks01]
			,[Weeks23]
			,[Months15]
			,[Months611]
			,[Years14]
			,[Years59]
			,[Year1019]
			,[YearOver20]
			,[NAIncidentType]
			,[StruckBy]
			,[StruckAgainst]
			,[CaughtInUnderBetween]
			,[Overexertion]
			,[LiftingTwisting]
			,[Inhalation]
			,[FallFromElevation]
			,[SlipStripFSL]
			,[RubbebOrAbraded]
			,[BiteOrSting]
			,[OtherIncidentType]
			,[OtherIncidentTypeText]
			,[NAOperatingStatus]
			,[Startup]
			,[NormalOS]
			,[Upset]
			,[ShutdownOrMaintenance]
			,[OtherOperatingStatus]
			,[OtherOperatingStatusText]
			,[Quay]
			,[Vessel]
			,[Warehouse]
			,[Office]
			,[Workshop]
			,[Yard]
			,[Road]
			,[OtherIncidentArea]
			,[OtherIncidentAreaText]
			,[Sunday]
			,[Monday]
			,[Tuesday]
			,[Wednesday]
			,[Thursday]
			,[Friday]
			,[Saturday]
			,[NoUnsafeCondition]
			,[PoorHouseKeeping]
			,[GuardingPNIP]
			,[FireAEH]
			,[InadequateWarningSystem]
			,[InadequatePPEUC]
			,[DefectiveTE]
			,[HighTemperatureExtrems]
			,[RadiationNSE]
			,[InadequateLighting]
			,[InadequateVentilation]
			,[OtherUnsafeConditions]
			,[OtherUnsafeConditionsText]
			,[NoUnsafeAct]
			,[WorkingOnME]
			,[UnderTheIOAD]
			,[InadequatePersonalAttire]
			,[OperatingEWA]
			,[FailuretoSOW]
			,[Horseplay]
			,[ImproperUseOfEquipment]
			,[MakingSafetyDevices]
			,[FailureTPUPPE]
			,[WorkingAtUS]
			,[TakingUPP]
			,[UnsafeLiftingCarrying]
			,[UsingUnsafeEquipment]
			,[OtherUnsafeActs]
			,[OtherUnsafeActsText],
			Pic1,
			Pic1_Des,
			Pic2,
			Pic2_Des
		FROM [dbo].[ST_IncidentAndAccident]
		WHERE ID=@ID
		
		SELECT t1.[IncidentAndAccidentID],t1.[ID],t1.[Actions],CONVERT(VARCHAR(10),t1.[Date],103)[Date],(select Staffname from [dbo].[ST_Safety] where id= t1.Incharge) [Incharge],CONVERT(VARCHAR(10),t1.[FollowUpDate],103)[FollowUpDate],(select Staffname from [dbo].[ST_Safety] where id= t1.FollowUpInCharge) [FollowUpInCharge] 
		FROM [dbo].[ST_IncidentAndAccident_ImmediateAction]  t1 
		WHERE t1.[IncidentAndAccidentID]=@ID
		


		SELECT  t1.[IncidentAndAccidentID],t1.[ID],t1.[Actions],CONVERT(VARCHAR(10),t1.[Date],103)[Date],(select Staffname from [dbo].[ST_Safety] where id= t1.Incharge) [Incharge],CONVERT(VARCHAR(10),t1.[FollowUpDate],103)[FollowUpDate],(select Staffname from [dbo].[ST_Safety] where id= t1.FollowUpInCharge) [FollowUpInCharge] 
		FROM [dbo].[ST_IncidentAndAccident_PermanentAction]  t1 
		WHERE t1.[IncidentAndAccidentID]=@ID
	END
END

