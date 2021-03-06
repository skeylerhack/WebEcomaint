--EXEC GetCHUC_NANG_QUYEN 'truong_le'
ALTER procedure [dbo].[GetCHUC_NANG_QUYEN]
	@USERNAME NVARCHAR(50)
 AS

	SELECT     dbo.CHUC_NANG.STT, dbo.CHUC_NANG.TEN_CHUC_NANG, MT_CN	,
			CASE dbo.USER_CHUC_NANG.USERNAME
			WHEN ISNULL( dbo.USER_CHUC_NANG.USERNAME,'') THEN CONVERT(BIT,1)
			ELSE CONVERT(BIT,0) END AS CHON, CONVERT(BIT,'False') IS_UPDATE,  @USERNAME USERNAME
	FROM         dbo.CHUC_NANG LEFT OUTER JOIN
                      dbo.USER_CHUC_NANG ON dbo.CHUC_NANG.STT = dbo.USER_CHUC_NANG.STT and  dbo.USER_CHUC_NANG.USERNAME =@USERNAME
	ORDER BY dbo.CHUC_NANG.STT
