


alter procedure [dbo].[SP_GET_MENU_OF_USER]
@USERNAME NVARCHAR (128) = 'ADMIN'
AS
BEGIN
--T1.LOAI_MENU = 3 LA OEE
	SELECT MENU_ID, MENU_TEXT, MENU_ENGLISH, MENU_CHINESE, MENU_PARENT, MENU_LINE, MENU_INDEX, SHORT_KEY, DLL_NAME, PROJECT_NAME, CLASS_NAME, FUNCTION_NAME, MENU_NOTE
	FROM     dbo.MENU AS T1
	WHERE  (MENU_POSITION IS NULL) AND (MENU_ID IN
						  (SELECT T2.MENU_ID
						   FROM      dbo.MENU AS T2 INNER JOIN
											 dbo.NHOM_MENU T3 ON T2.MENU_ID = T3.MENU_ID INNER JOIN
											 dbo.USERS T4 ON T3.GROUP_ID = T4.GROUP_ID
						   WHERE   (T4.USERNAME = @USERNAME))) AND (ISNULL(AN_HIEN, 0) = 1) AND (ISNULL(T1.LOAI_MENU,0) <> 3)
	ORDER BY MENU_INDEX
END



