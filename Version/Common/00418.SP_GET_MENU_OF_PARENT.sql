ALTER procedure [dbo].[SP_GET_MENU_OF_PARENT]
@MENU_ID NVARCHAR (128),
@USERNAME NVARCHAR (128)
AS
BEGIN
SELECT dbo.MENU.MENU_ID, dbo.MENU.MENU_TEXT, dbo.MENU.MENU_ENGLISH, dbo.MENU.MENU_CHINESE, dbo.MENU.MENU_PARENT, 
dbo.MENU.MENU_LINE, dbo.MENU.MENU_INDEX, dbo.MENU.SHORT_KEY, dbo.MENU.DLL_NAME, dbo.MENU.PROJECT_NAME, 
dbo.MENU.CLASS_NAME, dbo.MENU.FUNCTION_NAME, dbo.MENU.MENU_NOTE
FROM dbo.MENU 
WHERE dbo.MENU.MENU_PARENT = @MENU_ID AND (dbo.MENU.MENU_ID IN 
(SELECT dbo.MENU.MENU_ID
FROM dbo.MENU INNER JOIN
dbo.NHOM_MENU ON dbo.MENU.MENU_ID = dbo.NHOM_MENU.MENU_ID INNER JOIN
dbo.USERS ON dbo.NHOM_MENU.GROUP_ID = dbo.USERS.GROUP_ID
WHERE dbo.MENU.MENU_PARENT = @MENU_ID AND dbo.USERS.USERNAME = @USERNAME))
AND ISNULL(AN_HIEN, 0) = 1
ORDER BY dbo.MENU.MENU_INDEX
END
