IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCONG_VIEC_BO_PHAN')
   exec('CREATE PROCEDURE GetCONG_VIEC_BO_PHAN AS BEGIN SET NOCOUNT ON; END')
GO
-- EXEC GetCONG_VIEC_BO_PHAN 'AIC-0001','01.01.03', 0
alter proc [dbo].[GetCONG_VIEC_BO_PHAN]
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(20),
	@NNgu int
AS

SELECT dbo.CAU_TRUC_THIET_BI_CONG_VIEC.MS_MAY, dbo.CAU_TRUC_THIET_BI_CONG_VIEC.MS_BO_PHAN, 
                      dbo.CAU_TRUC_THIET_BI_CONG_VIEC.MS_CV,  MO_TA_CV, dbo.CAU_TRUC_THIET_BI_CONG_VIEC.GHI_CHU, 
                      dbo.CAU_TRUC_THIET_BI_CONG_VIEC.ACTIVE, TG_KH FROM CAU_TRUC_THIET_BI_CONG_VIEC INNER JOIN CONG_VIEC ON 
                      CAU_TRUC_THIET_BI_CONG_VIEC.MS_CV=CONG_VIEC.MS_CV WHERE MS_MAY = @MS_MAY
                      AND MS_BO_PHAN= @MS_BO_PHAN