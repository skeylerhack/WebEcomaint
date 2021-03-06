IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MGetListAllCNhanPBT')
   exec('CREATE FUNCTION  dbo.MGetListAllCNhanPBT () RETURNS  nvarchar(4000) as Begin return null end')
GO


alter function [dbo].[MGetListAllCNhanPBT]
(
	@MsPBT nvarchar(20)
	
)
returns nvarchar(max)
as
begin

declare @sName nvarchar(max) = ''
declare @sName1 nvarchar(max) = ''

SELECT  @sName =  COALESCE(ISNULL(@sName,'') + 
		CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + ISNULL(HO + ' ' + TEN,'')
		FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO AS X INNER JOIN
							  dbo.CONG_NHAN AS Y ON X.MS_CONG_NHAN = Y.MS_CONG_NHAN
		WHERE X.MS_PHIEU_BAO_TRI = @MsPBT 
		GROUP BY HO, TEN 

		
SELECT  @sName1 =  COALESCE(ISNULL(@sName1,'') + CASE LEN(ISNULL(@sName1,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + ISNULL(HO + ' ' + TEN,'')		FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU AS X INNER JOIN dbo.CONG_NHAN AS Y ON X.MS_CONG_NHAN = Y.MS_CONG_NHAN LEFT JOIN 
				(SELECT MS_PHIEU_BAO_TRI, T1.MS_CV,T1.MS_BO_PHAN,T1.MS_CONG_NHAN, SUM(ISNULL(SO_GIO,0)) * 60 AS SPHUT FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET T1
					WHERE T1.MS_PHIEU_BAO_TRI = @MsPBT
					GROUP BY MS_PHIEU_BAO_TRI, T1.MS_CV,T1.MS_BO_PHAN,T1.MS_CONG_NHAN
				) Z ON X.MS_PHIEU_BAO_TRI = Z.MS_PHIEU_BAO_TRI AND X.MS_CV = Z.MS_CV AND X.MS_BO_PHAN = Z.MS_BO_PHAN AND X.MS_CONG_NHAN = Z.MS_CONG_NHAN
		WHERE X.MS_PHIEU_BAO_TRI = @MsPBT
		GROUP BY HO, TEN 
	
	

	


return  LEFT(@sName + ';' +  @sName1, NULLIF(LEN(@sName + ';' +  @sName1)-1,-1))
end

