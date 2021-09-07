﻿DECLARE @ReportName NVARCHAR(100) = N'ucPhuTungHetTuoiTho'
DECLARE @RNameMH NVARCHAR(100) = N'ήΊͤΔήͬήΠΒ͔Ύάͬή΢ΖͬΔ΢'

--SELECT * FROM dbo.DS_REPORT WHERE LOAI_REPORT = 3 ORDER BY STT
IF NOT EXISTS(SELECT * FROM dbo.DS_REPORT WHERE REPORT_NAME = @ReportName)
BEGIN
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL],NOTE)
     VALUES
(@ReportName,N'Danh sách phụ tùng hết tuổi thọ sử dụng',N'List of sparepart out of service life',3,10,@ReportName,1,1,N'List of sparepart out of service life')
END

IF NOT EXISTS(SELECT * FROM [LIC_REPORT] WHERE REPORT_NAME = @RNameMH)
BEGIN
	INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
		VALUES           (N'̦' ,@RNameMH)
END
	
IF NOT EXISTS(SELECT * FROM dbo.[NHOM_REPORT] WHERE REPORT_NAME = @ReportName AND GROUP_ID = 1)
BEGIN
	INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
		 VALUES(1,@ReportName,N'Access')
END



