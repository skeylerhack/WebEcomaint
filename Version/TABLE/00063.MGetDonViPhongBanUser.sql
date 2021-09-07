


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MGetDonViPhongBanUser]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[MGetDonViPhongBanUser]
GO

--SELECT * FROM [dbo].[MGetDonViPhongBanUser]('ADMIN')

CREATE FUNCTION [dbo].[MGetDonViPhongBanUser]
(
	@USERNAME NVARCHAR(50)
)

returns @NhomToDonVi TABLE (
	[MS_TO] [int]  NULL,
	[MS_DON_VI] [nvarchar](20)  NULL,
	[TEN_TO] [nvarchar](100) NULL,
	[TEN_DON_VI] [nvarchar](255)  NULL
)
as 
begin


		
INSERT INTO @NhomToDonVi	
SELECT DISTINCT T1.MS_TO, T3.MS_DON_VI, T3.TEN_TO, dbo.DON_VI.TEN_DON_VI 
FROM         dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                      dbo.USERS AS T2 ON T1.GROUP_ID = T2.GROUP_ID INNER JOIN
                      dbo.TO_PHONG_BAN AS T3 ON T1.MS_TO = T3.MS_TO INNER JOIN
                      dbo.DON_VI ON T3.MS_DON_VI = dbo.DON_VI.MS_DON_VI
WHERE     (T2.USERNAME = @USERNAME OR @USERNAME = '-1')


return
END



