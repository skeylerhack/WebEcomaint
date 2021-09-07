
if not exists(select * from sys.columns 
            where Name = N'PHUT_GIO_PBT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD PHUT_GIO_PBT INT 
END    

--go
--EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'THONG_TIN_CHUNG', @level2type=N'COLUMN',@level2name=N'PHUT_GIO_PBT'

--go
--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 Trong PBT cong viec nhan su nhap theo gio 1 Trong PBT cong viec nhan su nhap theo Phut' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'THONG_TIN_CHUNG', @level2type=N'COLUMN',@level2name=N'PHUT_GIO_PBT'
