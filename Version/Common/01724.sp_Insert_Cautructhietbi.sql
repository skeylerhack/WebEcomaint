
ALTER PROCEDURE [dbo].[sp_Insert_Cautructhietbi]	
	@MS_MAY nvarchar(30),
	@MS_BOPHAN nvarchar(50),
	@TEN_BP nvarchar(250),
	@SL int,
	@STT INT,
	@BP_CHA nvarchar(30),
	@GHI_CHU nvarchar(250),
	@HIEU_LUC bit,
	@RUN_TIME float,
	@MS_DVT int,
	@HINH nvarchar(255),
	@MS_PT NVARCHAR(30),
	@CLASS_ID NVARCHAR(50)
AS
if @MS_DVT =0 
SET @MS_DVT=NULL
BEGIN	
	SET NOCOUNT ON;
	
	INSERT INTO CAU_TRUC_THIET_BI(
		MS_MAY,
		MS_BO_PHAN,
		TEN_BO_PHAN,
		SO_LUONG,
		STT,
		MS_BO_PHAN_CHA,
		GHI_CHU,
		HIEU_LUC,
		RUN_TIME,
		MS_DVT_RT,
		HINH,
		MS_PT,
		CLASS_ID
	)    
	VALUES (
		@MS_MAY,
		@MS_BOPHAN ,
		@TEN_BP,
		@SL,
		@STT,
		@BP_CHA,
		@GHI_CHU,
		@HIEU_LUC,
		@RUN_TIME,
		@MS_DVT,
		@HINH,
		CASE @MS_PT WHEN '' THEN NULL ELSE @MS_PT END,
		@CLASS_ID
	)
END

SELECT STT FROM dbo.CAU_TRUC_THIET_BI