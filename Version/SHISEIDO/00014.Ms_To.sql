IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_CHUOI') and Object_ID = Object_ID(N'TO'))
BEGIN
		ALTER TABLE [TO] ADD MS_CHUOI NVARCHAR(250) NULL
END


