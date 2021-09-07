
IF NOT EXISTS ( SELECT * FROM [DS_REPORT] WHERE REPORT_NAME = N'ucBaoCaoBaoTriDinhKyTheoNam')
BEGIN
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucBaoCaoBaoTriDinhKyTheoNam',N'Lịch bảo trì định kỳ theo năm',N'Periodic maintenance schedule by year',3,1,'ucBaoCaoBaoTriDinhKyTheoNam',2,1)
END
IF NOT EXISTS ( SELECT * FROM LIC_REPORT WHERE REPORT_NAME = N'ήΊ͈Ά΢͊Ά΢͈Ά΢ͬΨΖ͌ΖΠΔ͚ζͬΔΎ΢͠ΆΞ')
BEGIN
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' , N'ήΊ͈Ά΢͊Ά΢͈Ά΢ͬΨΖ͌ΖΠΔ͚ζͬΔΎ΢͠ΆΞ')
END

IF NOT EXISTS ( SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = N'ucBaoCaoBaoTriDinhKyTheoNam')
BEGIN
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucBaoCaoBaoTriDinhKyTheoNam',N'Access')
END

