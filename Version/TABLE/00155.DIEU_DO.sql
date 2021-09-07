if  exists (select 1 from sys.columns where name = 'MS_DON_VI' and object_name(object_id) = 'DIEU_DO') 
	ALTER TABLE DIEU_DO DROP COLUMN MS_DON_VI;
if  exists (select 1 from sys.columns where name = 'MS_TO' and object_name(object_id) = 'DIEU_DO') 
	ALTER TABLE DIEU_DO DROP COLUMN MS_TO;
GO
if NOT exists (select 1 from sys.columns where name = 'ID_NHOM_DD' and object_name(object_id) = 'DIEU_DO') 
BEGIN
	ALTER TABLE DIEU_DO  ADD ID_NHOM_DD BIGINT;
END

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_DIEU_DO_NHOM]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO]'))
ALTER TABLE [dbo].[DIEU_DO]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_DIEU_DO_NHOM] FOREIGN KEY([ID_NHOM_DD])
REFERENCES [dbo].[DIEU_DO_NHOM] ([ID_NHOM_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_DIEU_DO_NHOM]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO]'))
ALTER TABLE [dbo].[DIEU_DO] CHECK CONSTRAINT [FK_DIEU_DO_DIEU_DO_NHOM]
GO