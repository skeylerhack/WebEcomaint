

ALTER proc [dbo].[QL_ADD_KIEM_KE]
	@NGAY datetime,
	@MS_KHO int,
	@GIO_tmp datetime,
	@LOCK bit
AS

--DECLARE  @GIO datetime
--IF @GIO_tmp ='' 
--	SET @GIO=NULL
--ELSE
--	SET @GIO=CONVERT(DATETIME,@GIO_tmp,114)
INSERT INTO [KIEM_KE]
           ([NGAY]
           ,[MS_KHO]
           ,[GIO]
           ,[LOCK])
     VALUES
           (@NGAY,
           @MS_KHO, 
           @GIO_tmp, 
           @LOCK)
