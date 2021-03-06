IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetSituationWOColumn')
   exec('CREATE PROCEDURE spGetSituationWOColumn AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetSituationWOColumn]	
	@NNgu int = 0
AS
BEGIN
DECLARE @DangSoan NVARCHAR (MAX) = N'Đang soạn'
DECLARE @DangThucHien NVARCHAR (MAX) = N'Đang thực hiện'
DECLARE @HoanThanh NVARCHAR (MAX) = N'Hoàn thành'
DECLARE @NghiemThu NVARCHAR (MAX) = N'Nghiệm thu'

SELECT TOP 1 @DangSoan = CASE @NNgu WHEN 0 THEN TEN_TINH_TRANG WHEN 1 THEN TEN_TINH_TRANG_ANH  END FROM TINH_TRANG_PBT WHERE STT = 1
SELECT TOP 1 @DangThucHien = CASE @NNgu WHEN 0 THEN TEN_TINH_TRANG WHEN 1 THEN TEN_TINH_TRANG_ANH  END FROM TINH_TRANG_PBT WHERE STT = 2
SELECT TOP 1 @HoanThanh = CASE @NNgu WHEN 0 THEN TEN_TINH_TRANG WHEN 1 THEN TEN_TINH_TRANG_ANH END FROM TINH_TRANG_PBT WHERE STT = 3
SELECT TOP 1 @NghiemThu = CASE @NNgu WHEN 0 THEN TEN_TINH_TRANG WHEN 1 THEN TEN_TINH_TRANG_ANH END FROM TINH_TRANG_PBT WHERE STT = 4


DECLARE @TDangSoan nvarchar(100)= ''
DECLARE @TDangThucHien nvarchar(100)= ''
DECLARE @THoanThanh nvarchar(100)= ''
DECLARE @TNghiemThu nvarchar(100)= ''


DECLARE @Thang INT = 5

DECLARE @TNGAY DATETIME 
SET @TNGAY = CONVERT(NVARCHAR(5), YEAR(DATEADD(MONTH, -@Thang, GETDATE()))) + '/' + CONVERT(NVARCHAR(3), MONTH(DATEADD(MONTH, -@Thang, GETDATE()))) + '/01'

SELECT MS_PHIEU_BAO_TRI, TINH_TRANG_PBT, NGAY_BD_KH  INTO #TT FROM PHIEU_BAO_TRI WHERE NGAY_BD_KH BETWEEN @TNGAY AND GETDATE()




DECLARE @Tmp nvarchar(100) = ''

WHILE @Thang >= 0  
BEGIN  

	DECLARE @NGAYWHERE DATETIME
	SET @NGAYWHERE = DATEADD(MONTH,- @Thang,GETDATE())

    SELECT  @Tmp = CONVERT(NVARCHAR(100), ISNULL(COUNT(*), 0)) FROM #TT WHERE TINH_TRANG_PBT = 1 AND MONTH(NGAY_BD_KH) = (MONTH(@NGAYWHERE)) AND YEAR(NGAY_BD_KH) = YEAR(@NGAYWHERE)
	SET @TDangSoan = @Tmp + ', ' + @TDangSoan
	
	SELECT @Tmp = CONVERT(NVARCHAR(100), ISNULL(COUNT(*), 0)) FROM #TT WHERE TINH_TRANG_PBT = 2 AND MONTH(NGAY_BD_KH) = (MONTH(@NGAYWHERE)) AND YEAR(NGAY_BD_KH) = YEAR(@NGAYWHERE)
	SET @TDangThucHien = @Tmp + ', ' + @TDangThucHien
	
	SELECT @Tmp = CONVERT(NVARCHAR(100), ISNULL(COUNT(*), 0)) FROM #TT WHERE TINH_TRANG_PBT = 3 AND MONTH(NGAY_BD_KH) = (MONTH(@NGAYWHERE)) AND YEAR(NGAY_BD_KH) = YEAR(@NGAYWHERE)
	SET @THoanThanh = @Tmp + ', ' + @THoanThanh

	SELECT @Tmp = CONVERT(NVARCHAR(100), ISNULL(COUNT(*), 0)) FROM #TT WHERE TINH_TRANG_PBT = 4 AND MONTH(NGAY_BD_KH) = (MONTH(@NGAYWHERE)) AND YEAR(NGAY_BD_KH) = YEAR(@NGAYWHERE)
	SET @TNghiemThu = @Tmp + ', ' + @TNghiemThu

    SET @Thang = @Thang - 1
END  
SET @TDangSoan = LEFT(@TDangSoan, LEN(@TDangSoan) - 1)
SET @TDangThucHien = LEFT(@TDangThucHien, LEN(@TDangThucHien) - 1)
SET @THoanThanh = LEFT(@THoanThanh, LEN(@THoanThanh) - 1)
SET @TNghiemThu = LEFT(@TNghiemThu, LEN(@TNghiemThu) - 1)



 SET FMTONLY OFF
 DECLARE @tblResults TABLE(
 name NVARCHAR(100),
 data NVARCHAR(100),
 color NVARCHAR(100)
 )

INSERT INTO @tblResults (name, data, color)
VALUES ( rtrim(@DangSoan) ,  N'[' + @TDangSoan + N']', N'#90ED7D'),
( rtrim(@DangThucHien) ,  N'[' + @TDangThucHien + N']', N'#ff6666'),
( rtrim(@HoanThanh) ,  N'[' + @THoanThanh + N']', N'#7CB5EC'),
( rtrim(@NghiemThu) ,  N'[' + @TNghiemThu + N']', N'#434348')


SELECT  * FROM @tblResults
END



