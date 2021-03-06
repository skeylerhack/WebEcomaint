
--EXEC MGetIDYCSD 'WR' , '07/01/2013'
ALTER procedure [dbo].[MGetIDYCSD]
 @ID_H NVARCHAR (6),
 @ID_D NVARCHAR(10)
as

DECLARE @COUNT INT 
SET @COUNT = (SELECT COUNT (*) FROM TB_S_ID T WHERE T.ID_H = @ID_H AND CONVERT(NVARCHAR(10),ID_D,101) = @ID_D  )

DECLARE @ID_I INT 

SET @ID_I = (SELECT CASE WHEN MAX (T.ID_I) IS NULL THEN 0 ELSE  MAX (T.ID_I) END  + 1
FROM TB_S_ID T WHERE T.ID_H = @ID_H AND CONVERT(NVARCHAR(10),ID_D,101) = @ID_D )

--DELETE FROM TB_S_ID WHERE ID_H = @ID_H 
if @COUNT = 0 
	INSERT INTO TB_S_ID (ID_H,ID_I,ID_D) VALUES (@ID_H,@ID_I,@ID_D)   
else
	UPDATE TB_S_ID SET ID_I = @ID_I  WHERE ID_H = @ID_H AND CONVERT(NVARCHAR(10),ID_D,101) = @ID_D
	

SELECT @ID_I AS ID 
