
IF NOT EXISTS ( SELECT * FROM [DS_REPORT] WHERE REPORT_NAME = N'ucBaoCaoTongHopPBT')
BEGIN
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucBaoCaoTongHopPBT',N'Báo cáo tổng hợp công việc bảo trì theo tuần',N'Maintenance Works Weekly',3,15,'ucBaoCaoTongHopPBT',1,1)
END
IF NOT EXISTS ( SELECT * FROM LIC_REPORT WHERE REPORT_NAME = N'ήΊ͈Ά΢͊Ά΢ͬ΢ΠΒ͔΢Τ͈ͤͬ')
BEGIN
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊ͈Ά΢͊Ά΢ͬ΢ΠΒ͔΢Τ͈ͤͬ')
END

IF NOT EXISTS ( SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = N'ucBaoCaoTongHopPBT')
BEGIN
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucBaoCaoTongHopPBT',N'Access')
END

