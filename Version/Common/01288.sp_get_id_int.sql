
--select * from TB_S_ID where ID_H = 'GS'
ALTER procedure [dbo].[sp_get_id_int]
 @ID_H NVARCHAR (6)
as
 begin
 
   DECLARE @COUNT INT 
   SET @COUNT = (SELECT COUNT (*)   FROM TB_S_ID T   WHERE T.ID_H = @ID_H )
   
	DECLARE @ID_I INT 
	SET @ID_I = (SELECT CASE WHEN MAX (T.ID_I) IS NULL THEN 0 ELSE  MAX (T.ID_I) END  + 1
	FROM TB_S_ID T
	WHERE T.ID_H = @ID_H )
   
	IF (@COUNT > 0 )
	BEGIN 
		UPDATE TB_S_ID SET ID_I = @ID_I WHERE ID_H = @ID_H 
	END 
	ELSE 
	BEGIN 
		INSERT INTO TB_S_ID (ID_H,ID_I,ID_D)
		VALUES (@ID_H,@ID_I,GETDATE())   
	END 



	IF UPPER(@ID_H) = 'CV' 
	BEGIN
			SELECT @ID_I = MAX(CONG_VIEC.MS_CV) + 1 FROM CONG_VIEC
	END

	
	IF UPPER(@ID_H) = 'GS' 
	BEGIN
		SELECT @ID_I = MAX( CONVERT(INT,THONG_SO_GSTT.MS_TS_GSTT)) + 1 FROM THONG_SO_GSTT
	END
	
   SELECT @ID_I AS ID 
 end


