 
if not exists(select * from sys.columns 
            where Name = N'OEE' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
    ALTER TABLE dbo.THONG_TIN_CHUNG ADD OEE INT DEFAULT (0)

END   
go


IF NOT EXISTS (SELECT NULL FROM SYS.EXTENDED_PROPERTIES WHERE [major_id] = OBJECT_ID('THONG_TIN_CHUNG') AND [name] = N'MS_Description' AND [minor_id] = (SELECT [column_id] FROM SYS.COLUMNS WHERE [name] = 'OEE' AND [object_id] = OBJECT_ID('THONG_TIN_CHUNG')))
BEGIN
	UPDATE dbo.THONG_TIN_CHUNG SET OEE = 0 WHERE ISNULL(OEE,0) = 0
	
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 Không dùng OEE,1 Có dùng OEE không dùng CMMS, 2 Co dung OEE và CMMS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'THONG_TIN_CHUNG', @level2type=N'COLUMN',@level2name=N'OEE'

END    
