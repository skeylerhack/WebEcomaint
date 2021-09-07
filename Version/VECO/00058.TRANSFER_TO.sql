
if not exists(select * from sys.columns 
            where Object_ID = Object_ID(N'TRANSFER_TO'))
begin   
		CREATE TABLE [dbo].[TRANSFER_TO] (
			[ID]         INT           NOT NULL,
			[TRANSFER_TO_NAME]      NVARCHAR (30) NOT NULL
		PRIMARY KEY CLUSTERED ([ID] ASC)
			
		);
END  