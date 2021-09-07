IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetWorkSiteByID')
   exec('CREATE PROCEDURE GetWorkSiteByID AS BEGIN SET NOCOUNT ON; END')
GO
ALTER proc [dbo].[GetWorkSiteByID]
	@username nvarchar(50),
	@lang int
AS
SELECT     NX.MS_N_XUONG ID, 
CASE @lang WHEN 0 THEN NX.Ten_N_XUONG WHEN 1 THEN  NX.TEN_N_XUONG_A ELSE NX.TEN_N_XUONG_H END AS  [Name]
FROM         dbo.NHA_XUONG AS NX INNER JOIN
                      dbo.NHOM_NHA_XUONG AS NNX ON NX.MS_N_XUONG = NNX.MS_N_XUONG INNER JOIN
                      dbo.USERS AS U ON NNX.GROUP_ID = U.GROUP_ID
WHERE USERNAME = @username                      
ORDER BY ID