
ALTER procedure [dbo].[InsertDISTRIBUTION]
@MS	nvarchar(50),
@TEN nvarchar(255),
@LoaiChiPhi	smallint,
@DonVi nvarchar(6),
@GhiChu	nvarchar(255)
AS

INSERT INTO [dbo].[COSTCENTER]
	([MS_COSTCENTER],[TEN_COSTCENTER],[LOAI_CHI_PHI],[MSDV],[GHI_CHU])
VALUES (@MS	,@TEN ,@LoaiChiPhi	,@DonVi ,@GhiChu)

INSERT INTO [BO_PHAN_CHIU_PHI] 
	([TEN_BP_CHIU_PHI],[LOAI_CHI_PHI],[MSDV],[GHI_CHU], [MA_BP_CHIU_PHI]) 
VALUES (@TEN ,@LoaiChiPhi,@DonVi ,@GhiChu, @MS)

declare @MSChiuPhi int
SET @MSChiuPhi =(SELECT TOP 1 MS_BP_CHIU_PHI FROM BO_PHAN_CHIU_PHI
		WHERE TEN_BP_CHIU_PHI = @TEN)
IF @MSChiuPhi is not null
begin
INSERT INTO [dbo].[BO_PHAN_CHIU_PHI_RULE]
	([MS_BP_CHIU_PHI],[MS_COSTCENTER],[TY_LE])
VALUES
	(@MSChiuPhi,@MS,100)
end
