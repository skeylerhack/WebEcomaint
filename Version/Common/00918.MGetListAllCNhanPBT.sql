
--SELECT DBO.MGetListAllCNhanPBT (MS_PHIEU_BAO_TRI) FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WO-2014041000004'


ALTER function [dbo].[MGetListAllCNhanPBT]
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
	
	

	


return  CASE LEN(RTRIM(@sName) + ';' +  RTRIM(@sName1)) WHEN 1 THEN '' ELSE CASE LEN(RTRIM(@sName)) WHEN 0 THEN RTRIM(@sName1) ELSE CASE  LEN(RTRIM(@sName1)) WHEN 0 THEN  RTRIM(@sName) END END END 
end

