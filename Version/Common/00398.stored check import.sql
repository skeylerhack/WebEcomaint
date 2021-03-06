IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CHECK_KHACH_HANG')
   exec('CREATE PROCEDURE CHECK_KHACH_HANG AS BEGIN SET NOCOUNT ON; END')
GO
alter Procedure [dbo].[CHECK_KHACH_HANG]
@MS_KH varchar(20),
@TEN_CONG_TY nvarchar(200),
@TEN_RUT_GON nvarchar(200),
@QUOCGIA varchar(50),
@IsExistMS_KH bit output,
@IsExistTEN_CONG_TY bit output,
@IsExistTEN_RUT_GON bit output,
@IsExistQUOCGIA bit output
AS
	BEGIN TRAN
		BEGIN
			-- Check MS_KH 1: exist, 0: not exist
			IF EXISTS (SELECT MS_KH FROM KHACH_HANG
						WHERE MS_KH = @MS_KH)
					SET @IsExistMS_KH = 1
			ELSE
					SET @IsExistMS_KH = 0
			-- CHECK TEN_CONG_TY 1: exist, 0: not exist
			IF EXISTS (SELECT TEN_CONG_TY FROM KHACH_HANG
						WHERE TEN_CONG_TY = @TEN_CONG_TY)
					SET @IsExistTEN_CONG_TY = 1
			ELSE
					SET @IsExistTEN_CONG_TY = 0
			-- CHECK TEN_RUT_GON 1: exist, 0: not exist
			IF EXISTS (SELECT TEN_RUT_GON FROM KHACH_HANG
						WHERE TEN_RUT_GON = @TEN_RUT_GON)
					SET @IsExistTEN_RUT_GON = 1	
			ELSE
					SET @IsExistTEN_RUT_GON = 0
			--CHECK QUOCGIA Có hay chưa 1: exist (OK), 0: not exist
			IF EXISTS (SELECT MA_QG FROM IC_QUOC_GIA
						WHERE MA_QG = @QUOCGIA)
					SET @IsExistQUOCGIA = 1
			ELSE
					SET @IsExistQUOCGIA = 0	
		END
	COMMIT TRAN
Error:
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CHECK_IC_QUOCGIA')
   exec('CREATE PROCEDURE CHECK_IC_QUOCGIA AS BEGIN SET NOCOUNT ON; END')
GO

alter Procedure [dbo].[CHECK_IC_QUOCGIA]
@MA_QG varchar(20),
@TEN_QG nvarchar(50),
@TEN_QG_A nvarchar(50),
@IsExistMA_QG bit output,
@IsExistTEN_QG bit output,
@IsExistTEN_QG_A bit output
AS
	BEGIN TRAN
		BEGIN
			IF EXISTS (SELECT MA_QG FROM IC_QUOC_GIA
						WHERE LEN(MA_QG) = 2 AND (MA_QG = @MA_QG))
					SET @IsExistMA_QG = 1
			ELSE
					SET @IsExistMA_QG = 0
			IF EXISTS (SELECT TEN_QG FROM IC_QUOC_GIA
						WHERE LEN(MA_QG) = 2 AND (TEN_QG = @TEN_QG))
					SET @IsExistTEN_QG = 1
			ELSE
					SET @IsExistTEN_QG = 0
			IF EXISTS (SELECT TEN_QG_A FROM IC_QUOC_GIA
						WHERE LEN(MA_QG) = 2 AND (TEN_QG_A = @TEN_QG_A))
					SET @IsExistTEN_QG_A = 1	
			ELSE
					SET @IsExistTEN_QG_A = 0	
		END
	COMMIT TRAN
Error:

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CHECK_DVT')
   exec('CREATE PROCEDURE CHECK_DVT AS BEGIN SET NOCOUNT ON; END')
GO

alter Procedure [dbo].[CHECK_DVT]
@DVT varchar(20),
@TEN_1 nvarchar(50),
@TEN_2 nvarchar(50),
@isExistMSDVT bit output,
@isExistTen1 bit output,
@isExistTen2 bit output
AS

		BEGIN
			IF EXISTS (SELECT DVT FROM DON_VI_TINH 
						WHERE DVT = @DVT)
					SET @isExistMSDVT = 1
			ELSE
					SET @isExistMSDVT = 0
			IF EXISTS (SELECT TEN_1 FROM DON_VI_TINH
						WHERE TEN_1 = @TEN_1)
					SET @isExistTen1 = 1
			ELSE
					SET @isExistTen1 = 0
			IF EXISTS (SELECT TEN_2 FROM DON_VI_TINH
						WHERE TEN_2 = @TEN_2)
					SET @isExistTen2 = 1	
			ELSE
					SET @isExistTen2 = 0	
		END
GO
