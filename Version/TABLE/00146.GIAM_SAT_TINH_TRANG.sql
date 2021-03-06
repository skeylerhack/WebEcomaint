--commons 1870
--talbe 467
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SO_PHIEU') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG 
		ADD SO_PHIEU NVARCHAR(50)
END
GO
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'NGAY_KH') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG 
		ADD NGAY_KH DATETIME
END
GO
 
UPDATE GIAM_SAT_TINH_TRANG SET SO_PHIEU = 'CM-201801' +
CASE LEN(STT) 
WHEN 1 THEN '00000' + CONVERT(NVARCHAR(10),STT) 
WHEN 2 THEN '0000' + CONVERT(NVARCHAR(10),STT) 
WHEN 3 THEN '000' + CONVERT(NVARCHAR(10),STT) 
WHEN 4 THEN '00' + CONVERT(NVARCHAR(10),STT) 
WHEN 5 THEN '0' + CONVERT(NVARCHAR(10),STT) 
WHEN 6 THEN CONVERT(NVARCHAR(10),STT) 
END
WHERE SO_PHIEU IS NULL
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'HOAN_THANH') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG 
		ADD HOAN_THANH INT DEFAULT (0)
END
GO

UPDATE GIAM_SAT_TINH_TRANG SET HOAN_THANH = 1 WHERE HOAN_THANH IS NULL
