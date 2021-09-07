if not exists(select * from sys.columns 
            where Name = N'MS_TO' and Object_ID = Object_ID(N'DS_TL'))
begin
    ALTER TABLE DS_TL ADD MS_TO INT

	ALTER TABLE [dbo].[DS_TL]  WITH CHECK ADD  CONSTRAINT [FK_DS_TL_TO_PHONG_BAN] FOREIGN KEY([MS_TO])
	REFERENCES [dbo].[TO_PHONG_BAN] ([MS_TO])
	ON UPDATE CASCADE
END 

if not exists(select * from sys.columns 
            where Name = N'MS_QT' and Object_ID = Object_ID(N'DS_TL'))
begin
    ALTER TABLE DS_TL ADD MS_QT INT
    
	ALTER TABLE [dbo].[DS_TL]  WITH CHECK ADD  CONSTRAINT [FK_DS_TL_DS_QUY_TRINH] FOREIGN KEY([MS_QT])
	REFERENCES [dbo].[DS_QUY_TRINH] ([MS_QT])
	ON UPDATE CASCADE
END    
if not exists(select * from sys.columns 
            where Name = N'MAC_DINH' and Object_ID = Object_ID(N'DS_TL'))
begin
    ALTER TABLE DS_TL ADD MAC_DINH BIT
    ALTER TABLE [dbo].[DS_TL] ADD  CONSTRAINT [DF_DS_TL_MAC_DINH]  DEFAULT ((0)) FOR [MAC_DINH]

	
END 

GO
UPDATE DS_TL SET MAC_DINH = 0 WHERE MAC_DINH IS NULL
