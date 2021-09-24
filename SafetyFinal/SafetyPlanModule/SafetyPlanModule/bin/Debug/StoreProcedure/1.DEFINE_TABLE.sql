DROP PROC  VS_ST_HazardReport
GO
DROP  TYPE [ST_HazardReport1]
GO
CREATE TYPE [dbo].[ST_HazardReport1] AS TABLE(
	[ID] int,
	[HazardReportID] int,
	[PreventiveAction] nvarchar(250),
	[PersonIncharge] nvarchar(250),
	[Deadline] datetime,
	[CompletedDate] datetime,
	[Status] nvarchar(100) ,
	[PersonReport] nvarchar(100),
	[Description] nvarchar(300)
)
GO
CREATE TYPE [dbo].[ST_Department] AS TABLE
(
	[ID] int,
	[Department] nvarchar(200),
	[Description] nvarchar(max)
)
GO
CREATE TYPE [dbo].[ST_Safety] AS TABLE
(
	[ID] int,
	[Staffname] nvarchar(200),
	[Department] int,
	[Position] nvarchar(200),
	[Userlogin] nvarchar(200),
	[Description] nvarchar(max)
)
GO
CREATE TYPE [ST_IncidentAndAccident_ImmediateAction] AS TABLE
(
	[ID] int ,
	[IncidentAndAccidentID] int,
	[Actions] nvarchar(250),
	[Date] datetime ,
	[Incharge] nvarchar(250),
	[FollowUpDate] datetime,
	[FollowUpInCharge] nvarchar(250)
)
GO
CREATE TYPE [dbo].[ST_IncidentAndAccident_PermanentAction] AS TABLE
(
	[ID] int ,
	[IncidentAndAccidentID] int ,
	[Actions] nvarchar(250) ,
	[Date] datetime,
	[Incharge] nvarchar(250) ,
	[FollowUpDate] datetime ,
	[FollowUpInCharge] nvarchar(250) 
)
GO

CREATE TYPE [ST_RiskRegister] AS TABLE
(
	[ID] int,
	[LocationID] int,
	[HazardID] int,
	[TaskID] int,
	[ContackObjectID] int,
	[Picture] nvarchar(250),
	[IncidentOrAcident] nvarchar(250),
	[LocationDetail] nvarchar(250)
	,[HazardDetail] nvarchar(250)
 )
GO
CREATE TYPE [ST_Inspection1] AS TABLE(
	[ID] int,
	[InspectionID] int,
	[PicName] nvarchar(250),
	[PicPath] nvarchar(250),
	[Before] bit
 )
GO
CREATE TYPE [ST_Inspection] AS TABLE(
	[ID] int,
	[DocNum] int,
	[LocationID] int,
	[Situation] nvarchar(250),
	[Action] nvarchar(250),
	[InCharge] nvarchar(250),
	[Deadline] datetime,
	[Status] int,
	[PicBeforeDefault] int,
	[PicAfterDefault] int,
	[PathPicBeforeDefault] nvarchar(500),
	[PathPicAfterDefault] nvarchar(500),
	[NamePicBeforeDefault] nvarchar(500),
	[NamePicAfterDefault] nvarchar(500),
	[InspectionID] int
 )
GO
CREATE TYPE [ST_BSSMSAudit] AS TABLE
(
	[ID] int,
	[AuditContent] nvarchar(250),
	[InCharge] nvarchar(250) ,
	[DeadLine] datetime,
	[Status] int ,
	[Description] nvarchar(250)
)
GO
CREATE TYPE [ST_Hazards] AS TABLE
(
	[ID] [int],
	[Hazard] [nvarchar](250),
	[Description] [nvarchar](250)
)
GO
CREATE TYPE [ST_Locations] AS TABLE(
	[ID] [int] ,
	[LocationName] [nvarchar](250),
	[Description] [nvarchar](250)
)
GO
CREATE TYPE [ST_ContactObjects] AS TABLE(
	[ID] [int],
	[ContactObject] [nvarchar](250),
	[Description] [nvarchar](250)
) 
GO
CREATE TYPE [ST_Tasks] AS TABLE(
	[ID] [int] ,
	[Task] [nvarchar](250) ,
	[Description] [nvarchar](250)
)
GO
ALTER TABLE [dbo].[ST_Inspection] ADD [VT] int
GO
ALTER TABLE [dbo].[ST_StopCard] ADD [CreatedBy] NVARCHAR(250)




