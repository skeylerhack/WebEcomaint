--EXEC [GetMayUserALL] 'ADMIN','-1',-1,-1,'-1','-1','VAL-MT-902','08/08/2019',0
ALTER proc [dbo].[GetMayUserAll]	
	@UserName NVARCHAR(50),
	@MsNX NVARCHAR(50),
	@MSHT INT,
	@MSBPCP INT,
	@MsLoaiMay NVARCHAR(20),	
	@MsNhomMay NVARCHAR(20),	
	@MSMay NVARCHAR(100),
	@DenNgay DATETIME,
	@NNgu int
AS
begin
SELECT DISTINCT *
	FROM dbo.MGetMayUserNgay(@DenNgay,@UserName,@MsNX,@MSHT,@MSBPCP,@MsLoaiMay,@MsNhomMay,@MSMay,@NNgu) A
ORDER BY MS_MAY,TEN_MAY,MODEL,TEN_BP_CHIU_PHI,Ten_N_XUONG,TEN_HE_THONG	

end