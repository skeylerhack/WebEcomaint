IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetNhanSuPBT')
   exec('CREATE FUNCTION  dbo.GetNhanSuPBT () RETURNS  nvarchar(50) as Begin return null end')
GO
--SELECT dbo.GetNhanSuPBT(MS_PHIEU_BAO_TRI,MS_BO_PHAN,MS_CV ), * FROM PHIEU_BAO_TRI_CONG_VIEC WHERE MS_PHIEU_BAO_TRI = 'WO-201504000014'

	 
ALTER function [dbo].[GetNhanSuPBT]
(
	@MsPBT nvarchar(50),
	@MsBP nvarchar(50),
	@MSCV int, 
	@PhuTro Bit
)
returns nvarchar(1000)
as 
begin
declare @NSBT nvarchar(1000)
IF @PhuTro = 0
BEGIN
	SELECT @NSBT =COALESCE(@NSBT + ', ', '') +
	CAST(HO_TEN AS Nvarchar(1000))
	FROM 
		(SELECT  DISTINCT   T2.HO + ' ' + T2.TEN AS HO_TEN
							FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU AS T1 INNER JOIN
												  dbo.CONG_NHAN AS T2 ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN
							WHERE     (T1.MS_PHIEU_BAO_TRI = @MsPBT) AND (T1.MS_CV = @MSCV) AND (T1.MS_BO_PHAN = @MsBP)) T1
END						
ELSE						
BEGIN
	SELECT @NSBT =COALESCE(@NSBT + ', ', '') +
	CAST(HO_TEN AS Nvarchar(1000))
	FROM 
		(SELECT  DISTINCT   T2.HO + ' ' + T2.TEN AS HO_TEN
							FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO AS T1 INNER JOIN
												  dbo.CONG_NHAN AS T2 ON T1.MS_CONG_NHAN = T2.MS_CONG_NHAN
							WHERE     (T1.MS_PHIEU_BAO_TRI = @MsPBT) AND (T1.STT = @MSCV )) T1
END						



return @NSBT
end




