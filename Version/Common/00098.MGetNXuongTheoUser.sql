

--EXEC MGetNXuongTheoUser 'ADMINISTRATOR',1
ALTER proc [dbo].[MGetNXuongTheoUser]
	@UserName nvarchar(50),
	@NNgu int
AS
SELECT     NX.MS_N_XUONG, 
CASE @NNgu WHEN 0 THEN NX.Ten_N_XUONG WHEN 1 THEN  NX.TEN_N_XUONG_A ELSE NX.TEN_N_XUONG_H END AS TEN_NX
FROM         dbo.NHA_XUONG AS NX INNER JOIN
                      dbo.NHOM_NHA_XUONG AS NNX ON NX.MS_N_XUONG = NNX.MS_N_XUONG INNER JOIN
                      dbo.USERS AS U ON NNX.GROUP_ID = U.GROUP_ID
WHERE USERNAME = @UserName                      
ORDER BY MS_N_XUONG