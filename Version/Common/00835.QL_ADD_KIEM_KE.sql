
ALTER proc [dbo].[QL_ADD_KIEM_KE]
	@NGAY Nvarchar(20),
	@MS_KHO int,
	@GIO_tmp NVARCHAR(20),
	@LOCK bit
AS

DECLARE  @GIO datetime
IF @GIO_tmp ='' 
	SET @GIO=NULL
ELSE
	SET @GIO=CONVERT(DATETIME,@GIO_tmp,114)
INSERT INTO [KIEM_KE]
           ([NGAY]
           ,[MS_KHO]
           ,[GIO]
           ,[LOCK])
     VALUES
           (@NGAY,
           @MS_KHO, 
           @GIO, 
           @LOCK)
