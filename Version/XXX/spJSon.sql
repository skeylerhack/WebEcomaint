
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spJSon')
   
exec('CREATE PROCEDURE spJSon AS BEGIN SET NOCOUNT ON; END')

GO

ALTER PROCEDURE spJSon
	@sJon NVARCHAR(MAX)    
AS
BEGIN
SELECT LEN(@sJon)
--SELECT *
--			FROM OPENJSON(@sJon)
--WITH (chon bit,STT INT,MS_TS_GSTT INT,MS_TT INT,NGAY_GIO_KT_MAX DATETIME,MS_MAY nvarchar(max),TEN_MAY nvarchar(max),TEN_BO_PHAN nvarchar(max),TEN_TS_GSTT nvarchar(max),GT_DL nvarchar(max),GT_DT nvarchar(max),TEN_CACH_TH nvarchar(max),MS_CACH_TH nvarchar(max),MS_PBT nvarchar(max),MS_CONG_NHAN nvarchar(max),TG_XU_LY nvarchar(max),STT_GT nvarchar(max),MS_BO_PHAN nvarchar(max))
END
