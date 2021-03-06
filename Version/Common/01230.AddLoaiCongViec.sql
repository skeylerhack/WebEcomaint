
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AddLoaiCongViec')
   exec('CREATE PROCEDURE AddLoaiCongViec AS BEGIN SET NOCOUNT ON; END')
GO

ALTER proc AddLoaiCongViec
	@TEN_LOAI_CV nvarchar(50),
	@TEN_LOAI_CV_ANH nvarchar(50),
	@TEN_LOAI_CV_HOA nvarchar(50)
AS

INSERT INTO LOAI_CONG_VIEC (TEN_LOAI_CV,TEN_LOAI_CV_ANH,TEN_LOAI_CV_HOA)
values (@TEN_LOAI_CV,@TEN_LOAI_CV_ANH,@TEN_LOAI_CV_HOA)

select Convert(int, SCOPE_IDENTITY()) as ID
