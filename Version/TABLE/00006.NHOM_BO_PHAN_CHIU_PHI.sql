
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NHOM_BO_PHAN_CHIU_PHI_BO_PHAN_CHIU_PHI]') AND parent_object_id = OBJECT_ID(N'[dbo].[NHOM_BO_PHAN_CHIU_PHI]'))
ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI] DROP CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_BO_PHAN_CHIU_PHI]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NHOM_BO_PHAN_CHIU_PHI_NHOM]') AND parent_object_id = OBJECT_ID(N'[dbo].[NHOM_BO_PHAN_CHIU_PHI]'))
ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI] DROP CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_NHOM]
GO

ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI]  WITH CHECK ADD  CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_BO_PHAN_CHIU_PHI] FOREIGN KEY([MS_BP_CHIU_PHI])
REFERENCES [dbo].[BO_PHAN_CHIU_PHI] ([MS_BP_CHIU_PHI])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI] CHECK CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_BO_PHAN_CHIU_PHI]
GO

ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI]  WITH CHECK ADD  CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_NHOM] FOREIGN KEY([GROUP_ID])
REFERENCES [dbo].[NHOM] ([GROUP_ID])
ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[NHOM_BO_PHAN_CHIU_PHI] CHECK CONSTRAINT [FK_NHOM_BO_PHAN_CHIU_PHI_NHOM]
GO


