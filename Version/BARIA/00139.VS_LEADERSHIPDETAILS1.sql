
ALTER PROCEDURE [dbo].[VS_LEADERSHIPDETAILS1]
	@USER_NAME NVARCHAR(30) = 'Quang_le',
	@DateCreate DATETIME = '09/09/2021',
	@ID_TYPE BIGINT = NULL
	AS	
BEGIN
	SELECT ROW_NUMBER() OVER(ORDER BY IDLeadership) AS STT, 
	ISNULL(LSD.IDLeadership, LS.ID) AS IDLeadership,
	 LS.Content, LSD.UserName, LSD.DateCreate,ISNULL(LSD.Yes,0) AS Yes,ISNULL(LSD.No,0) AS 'No', ISNULL(LSD.NA,0) AS 'NA'
	  FROM dbo.Leadership LS 
	  LEFT JOIN dbo.LeadershipDetails LSD ON LSD.IDLeadership = LS.ID AND LSD.UserName  = @USER_NAME AND CONVERT(DATE,LSD.DateCreate) =CONVERT(DATE,@DateCreate) AND LS.Active = 1
	  WHERE LS.ID_TYPE =@ID_TYPE
END

