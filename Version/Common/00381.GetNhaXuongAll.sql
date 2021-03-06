
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetNhaXuongAll')
   exec('CREATE PROCEDURE GetNhaXuongAll AS BEGIN SET NOCOUNT ON; END')
GO


--EXEC GetNhaXuongAll 'trungnv',1,1
ALTER proc GetNhaXuongAll
	@UserName nvarchar(50) = 'Admin',
	@NNgu int = 0,
	@CoAll int = 0
AS
SELECT     NX.MS_N_XUONG, 
CASE @NNgu WHEN 0 THEN NX.Ten_N_XUONG WHEN 1 THEN  NX.TEN_N_XUONG_A ELSE NX.TEN_N_XUONG_H END AS TEN_N_XUONG
INTO #NXUONG
FROM         dbo.NHA_XUONG AS NX INNER JOIN
                      dbo.NHOM_NHA_XUONG AS NNX ON NX.MS_N_XUONG = NNX.MS_N_XUONG INNER JOIN
                      dbo.USERS AS U ON NNX.GROUP_ID = U.GROUP_ID
WHERE USERNAME = @UserName                      

IF @CoAll = 0 
BEGIN
	SELECT MS_N_XUONG, TEN_N_XUONG FROM #NXUONG ORDER BY MS_N_XUONG
END 
ELSE
BEGIN
	SELECT MS_N_XUONG, TEN_N_XUONG FROM #NXUONG UNION SELECT '-1' , ' < ALL > ' ORDER BY MS_N_XUONG
END 

