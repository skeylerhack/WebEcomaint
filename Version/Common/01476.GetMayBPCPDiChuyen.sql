IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'H_MAY_BPCPs')
   exec('DROP PROCEDURE H_MAY_BPCPs')
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetMayBPCPDiChuyen')
   exec('CREATE PROCEDURE GetMayBPCPDiChuyen AS BEGIN SET NOCOUNT ON; END')
GO



ALTER procedure [dbo].[GetMayBPCPDiChuyen] 
	@MS_BP_CHIU_PHI INT = -1,
	@UserName NVARCHAR(50) = 'admin',
	@NNgu INT = 0
AS

SELECT DISTINCT MS_MAY,TEN_MAY INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(), @UserName, '-1', - 1, @MS_BP_CHIU_PHI, '-1', '-1', '-1', @NNgu) 

SELECT        TMP.MS_MAY, T1.TEN_MAY, TMP.MS_BP_CHIU_PHI, TMP.NGAY_NHAP
FROM            (SELECT        dbo.MAY_BO_PHAN_CHIU_PHI.MS_MAY, dbo.MAY_BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI, MAX(dbo.MAY_BO_PHAN_CHIU_PHI.NGAY_NHAP) AS NGAY_NHAP
                          FROM            dbo.MAY_BO_PHAN_CHIU_PHI INNER JOIN
                                                    dbo.MAY_BPCP_NGAY_MAX ON dbo.MAY_BO_PHAN_CHIU_PHI.MS_MAY = dbo.MAY_BPCP_NGAY_MAX.MS_MAY AND 
                                                    dbo.MAY_BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI = dbo.MAY_BPCP_NGAY_MAX.MS_BP_CHIU_PHI
                          GROUP BY dbo.MAY_BO_PHAN_CHIU_PHI.MS_MAY, dbo.MAY_BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI) AS TMP INNER JOIN
                         #MAY AS T1 ON TMP.MS_MAY = T1.MS_MAY
