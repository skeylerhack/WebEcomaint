

if not exists(select * from sys.columns 
            where Name = N'BAT_BUOC ' and Object_ID = Object_ID(N'QT_DUYET_TL'))
begin
    ALTER TABLE QT_DUYET_TL ADD BAT_BUOC  BIT
    
    ALTER TABLE [dbo].[QT_DUYET_TL] ADD  CONSTRAINT [DF_QT_DUYET_TL_BAT_BUOC ]  DEFAULT ((0)) FOR [BAT_BUOC ]

END 

GO
	UPDATE QT_DUYET_TL SET BAT_BUOC = 0 WHERE BAT_BUOC IS NULL



