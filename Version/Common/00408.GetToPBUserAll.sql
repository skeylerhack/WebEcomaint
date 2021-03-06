IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetToPBUserAll')
   exec('CREATE PROCEDURE GetToPBUserAll AS BEGIN SET NOCOUNT ON; END')
GO




--EXEC GetToPBUserAll 1, -1,-1,'TRUNGNV'
ALTER proc [dbo].GetToPBUserAll
	@CoALL bit,
	@MS_DV NVARCHAR(6),
	@MS_PB int,
	@Username NVARCHAR(50) = 'Admin'
AS


SELECT DISTINCT A.MS_TO1, A.TEN_TO INTO #TO_USER
FROM         dbo.[TO] AS A INNER JOIN
                      dbo.TO_PHONG_BAN AS B ON A.MS_TO = B.MS_TO INNER JOIN
                      dbo.NHOM_TO_PHONG_BAN AS C ON B.MS_TO = C.MS_TO INNER JOIN
                      dbo.USERS D ON C.GROUP_ID = D.GROUP_ID
WHERE     (D.USERNAME = @Username) AND
(B.MS_TO = @MS_PB OR @MS_PB = -1) AND (B.MS_DON_VI = @MS_DV OR @MS_DV = '-1')


if @CoALL = 0
	SELECT DISTINCT A.MS_TO1, A.TEN_TO FROM #TO_USER A ORDER BY A.TEN_TO
else
	SELECT DISTINCT A.MS_TO1, A.TEN_TO FROM #TO_USER A 
	UNION
	SELECT '-1', '< ALL >' 	ORDER BY TEN_TO 
