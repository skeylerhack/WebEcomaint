--PilmicoIntegration
USE [PilmicoIntegration]
GO
ALTER trigger [dbo].[UnitOfMeasurement_trigger]
on [dbo].[UnitOfMeasurement]
after UPDATE, INSERT, DELETE
as
BEGIN

	
	BEGIN TRY
		INSERT INTO CMMS_PILMICO.DBO.DON_VI_TINH(DVT,TEN_1,TEN_2,TEN_3)
		SELECT ROW_NUMBER() OVER (ORDER BY UOMName)  + ISNULL((SELECT MAX(CONVERT(INT,DVT)) FROM CMMS_PILMICO.DBO.DON_VI_TINH),0) AS DVT,  
		UOMName AS TEN_1,UOMName AS TEN_2,UOMName AS TEN_3 FROM UnitOfMeasurement T1 WHERE NOT EXISTS (
		SELECT * FROM CMMS_PILMICO.DBO.DON_VI_TINH T2 WHERE T1.UOMName = T2.TEN_1)  AND ISNULL(Completed,0) = 0
		ORDER BY UOMName

		UPDATE UnitOfMeasurement SET Completed = 1,CompletionTime = GETDATE() FROM UnitOfMeasurement T1 INNER JOIN inserted T2 ON T1.ID = T2.ID WHERE  ISNULL(T1.Completed,0) = 0

	END TRY

	BEGIN CATCH     
		select ERROR_MESSAGE()
	END CATCH

END



