IF NOT EXISTS (SELECT * FROM SYS.COLUMNS
            WHERE NAME = N'DINH_MUC_SL' AND Object_ID = Object_ID(N'MAY'))
BEGIN
    ALTER TABLE MAY ADD DINH_MUC_SL float DEFAULT (0) 
END    
--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'định mức sản lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MAY', @level2type=N'COLUMN',@level2name=N'DINH_MUC_SL'

GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS
            WHERE NAME = N'DVT_SL' AND Object_ID = Object_ID(N'MAY'))
BEGIN
    ALTER TABLE MAY ADD DVT_SL nvarchar(50) DEFAULT (0)
END  
--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn vị tính sản lượng' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'MAY', @level2type=N'COLUMN',@level2name=N'DVT_SL'
