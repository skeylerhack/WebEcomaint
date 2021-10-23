
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES Where Table_Schema = 'dbo'  AND Table_Name ='LeadershipType')
BEGIN
CREATE TABLE [dbo].[LeadershipType](
	[ID_TYPE] [bigint] IDENTITY(1,1) NOT NULL,
	[MA_SO] [nvarchar](30) NULL,
	[NAME_VN] [nvarchar](250) NULL,
	[NAME_EL] [nvarchar](250) NULL,
	[NOTE] [nvarchar](500) NULL,
	[ACTIVE] [bit] NULL,
 CONSTRAINT [PK_LeadershipType_1] PRIMARY KEY CLUSTERED 
(
	[ID_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

 if not exists(select * from sys.columns 
           where Name = N'ID_TYPE' and Object_ID = Object_ID(N'Leadership'))
begin
ALTER TABLE dbo.Leadership ADD ID_TYPE BIGINT END  


 if not exists(select * from sys.columns 
           where Name = N'NOTE' and Object_ID = Object_ID(N'LeadershipDetails'))
begin
ALTER TABLE dbo.LeadershipDetails ADD NOTE NVARCHAR(500) END  

