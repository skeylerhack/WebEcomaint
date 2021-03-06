

--spGetEquipmentInfo   -- 5 tháng gần nhất
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDeviceInfo')
   exec('CREATE PROCEDURE spGetDeviceInfo AS BEGIN SET NOCOUNT ON; END')
GO

alter PROCEDURE [dbo].[spGetDeviceInfo]	
	@NNgu int = 0
AS
BEGIN

DECLARE @DangSuDung NVARCHAR (MAX) = N'Đang sử dụng'
DECLARE @ThanhLy NVARCHAR (MAX) = N'Không sử dụng/thanh lý'


SELECT TOP 1 @DangSuDung = CASE @NNgu WHEN 0 THEN TEN_HIEN_TRANG WHEN 1 THEN TEN_HIEN_TRANG_ANH  END FROM HIEN_TRANG_SU_DUNG_MAY WHERE MS_HIEN_TRANG = 2
SELECT TOP 1 @ThanhLy = CASE @NNgu WHEN 0 THEN TEN_HIEN_TRANG WHEN 1 THEN TEN_HIEN_TRANG_ANH  END FROM HIEN_TRANG_SU_DUNG_MAY WHERE MS_HIEN_TRANG = 3

DECLARE @TDangSuDung INT
DECLARE @TThanhLy INT
DECLARE @TongMay INT

SELECT @TThanhLy = ISNULL(COUNT(*), 0) FROM MAY WHERE MS_HIEN_TRANG <> 2
SELECT @TongMay = ISNULL(COUNT(*), 0) FROM MAY

SET @TDangSuDung = case @TongMay when 0 then 0 else ( 100 - (@TThanhLy * 100 / @TongMay) ) end


 SET FMTONLY OFF
 DECLARE @tblResults TABLE(
 name NVARCHAR(100),
 y FLOAT,
 color NVARCHAR(100)
 )

INSERT INTO @tblResults (name, y, color)
VALUES ( rtrim(@DangSuDung) ,   @TDangSuDung, N'#b2c831'),
( rtrim(@ThanhLy) , case @TDangSuDung when 0 then 0 else ( 100 -  @TDangSuDung ) end, N'#3d3d3d')


SELECT  * FROM @tblResults
END



