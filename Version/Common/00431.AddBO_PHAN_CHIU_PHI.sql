
ALTER proc [dbo].[AddBO_PHAN_CHIU_PHI]
	@TEN_BP_CHIU_PHI nvarchar(100),
	@LOAI_CHI_PHI smallint,
	@MSDV nvarchar(6),
	@GHI_CHU nvarchar(255),
	@ACCOUNT nvarchar(10),
	@SUB nvarchar(20),
	@MA_BP_CHIU_PHI nvarchar(50)
AS
INSERT INTO BO_PHAN_CHIU_PHI (TEN_BP_CHIU_PHI,LOAI_CHI_PHI,MSDV,GHI_CHU, ACCOUNT,SUB,MA_BP_CHIU_PHI)
values (@TEN_BP_CHIU_PHI,@LOAI_CHI_PHI,@MSDV,@GHI_CHU,@ACCOUNT,@SUB,@MA_BP_CHIU_PHI)

DECLARE @MS_BPCP INT
SET @MS_BPCP = SCOPE_IDENTITY()
DECLARE @GROUPID INT
SELECT @GROUPID = GROUP_ID FROM USERS WHERE USERNAME = 'ADMIN'

IF NOT EXISTS(SELECT * FROM NHOM_BO_PHAN_CHIU_PHI WHERE MS_BP_CHIU_PHI = @MS_BPCP and GROUP_ID = @GROUPID)
	INSERT INTO NHOM_BO_PHAN_CHIU_PHI(GROUP_ID,MS_BP_CHIU_PHI) VALUES(@GROUPID,@MS_BPCP)

select @MS_BPCP
