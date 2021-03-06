

--EXEC [MGetMayUserAll] 1,'ADMIN','-1',-1,-1,'-1','-1','-1','01/01/2016',0
ALTER proc [dbo].[MGetMayUserAll]
	@CoALL bit,
	@UserName NVARCHAR(50),
	@MsNX NVARCHAR(5),
	@MSHT INT,
	@MSBPCP INT,
	@MsLoaiMay NVARCHAR(20),	
	@MsNhomMay NVARCHAR(20),	
	@MSMay NVARCHAR(100),
	@DenNgay DATETIME,
	@NNgu int
AS

SELECT DISTINCT MS_MAY,TEN_MAY INTO #MAY_USER 
	FROM dbo.MGetMayUserNgay(@DenNgay,@UserName,@MsNX,@MSHT,@MSBPCP,@MsLoaiMay,@MsNhomMay,@MSMay,0) A

if @CoALL = 0
	SELECT DISTINCT    MS_MAY,TEN_MAY
	FROM    #MAY_USER
	ORDER BY TEN_MAY

else
	SELECT DISTINCT    MS_MAY,TEN_MAY	FROM    #MAY_USER
	UNION
	SELECT '-1', ' < ALL > '  
	ORDER BY TEN_MAY


