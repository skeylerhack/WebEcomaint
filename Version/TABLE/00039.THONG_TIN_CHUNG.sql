
if not exists(select * from sys.columns where Name = N'THEM_CV_PT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD THEM_CV_PT INT

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 Mặc định thêm CV va PT - 1 Chi Thêm công việc không thêm phụ tùng - 2 Không thêm gì cả' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'THONG_TIN_CHUNG', @level2type=N'COLUMN',@level2name=N'THEM_CV_PT'
end



