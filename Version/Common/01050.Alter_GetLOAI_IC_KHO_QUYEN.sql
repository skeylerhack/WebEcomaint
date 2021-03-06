--EXEC DBO.GetLOAI_IC_KHO_QUYEN 1
ALTER procedure [dbo].[GetLOAI_IC_KHO_QUYEN]
	@GROUP_ID INT
 AS

	SELECT     dbo.IC_KHO.MS_KHO, dbo.IC_KHO.TEN_KHO,
	CASE dbo.NHOM_KHO.GROUP_ID
			WHEN ISNULL( dbo.NHOM_KHO.GROUP_ID,0) THEN CONVERT(BIT,1)
			ELSE CONVERT(BIT,0) END AS CHON, CONVERT(BIT,'False') IS_UPDATE, @GROUP_ID GROUP_ID
	FROM         dbo.IC_KHO LEFT OUTER JOIN
                      dbo.NHOM_KHO ON dbo.IC_KHO.MS_KHO = dbo.NHOM_KHO.MS_KHO AND dbo.NHOM_KHO.GROUP_ID=@GROUP_ID
