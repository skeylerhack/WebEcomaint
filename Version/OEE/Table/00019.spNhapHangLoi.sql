
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spNhapHangLoi')
   
exec('CREATE PROCEDURE spNhapHangLoi AS BEGIN SET NOCOUNT ON; END')

GO



ALTER proc [dbo].[spNhapHangLoi]
	@iLoai INT = 1,
	@USERNAME NVARCHAR(100) = NULL,
	@NNgu INT = 0,
	@sBT NVARCHAR(200) = NULL,
	@iID BIGINT = -1,
	@ID BIGINT = NULL,
	@DocNum NVARCHAR(9) = NULL,
	@QCName NVARCHAR(50) = NULL,
	@QCDate DATETIME = NULL
AS
BEGIN	
	IF @iLoai = 0
	BEGIN
		SELECT ID, DocNum, QCName, QCDate FROM dbo.QCData ORDER BY QCDate
	END

	IF @iLoai = 1
	BEGIN
		SELECT ID, DocNum, QCName, QCDate FROM dbo.QCData WHERE ID = @iID

		SELECT QCDD.ID, QCDD.ID_QC, QCDD.ID_PO, QCDD.ItemID, I.ItemName, QCDD.MS_MAY, QCDD.ProductionDate, QCDD.ID_Defect, QCDD.Quantity, QCDD.Note 
		FROM dbo.QCDataDetails QCDD
			LEFT JOIN dbo.ProductionOrder PO ON QCDD.ID_PO = PO.ID
			LEFT JOIN dbo.Item I ON QCDD.ItemID = I.ID
			LEFT JOIN dbo.Defect D ON QCDD.ID_Defect = D.ID
			LEFT JOIN dbo.MAY M ON QCDD.MS_MAY = M.MS_MAY
		WHERE ID_QC = @iID
	END

	IF @iLoai = 2
	BEGIN
		DELETE dbo.QCDataDetails WHERE(ID_QC = @iID)
		DELETE dbo.QCData WHERE(ID = @iID)
		SELECT 0 AS TT	
	END

	IF @iLoai = 3
	BEGIN
		CREATE TABLE #QCDataDetails(
		ID BIGINT,
		ID_QC BIGINT,
		ID_PO BIGINT,
		ItemID BIGINT,
		MS_MAY NVARCHAR(30),
		ProductionDate DATETIME,
		ID_Defect INT,
		Quantity INT,
		Note NVARCHAR(250))

	DECLARE @SQL_#QCDataDetails NVARCHAR(MAX)
	SET @SQL_#QCDataDetails = 'INSERT INTO #QCDataDetails (ID, ID_QC, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note) SELECT ID, ID_QC, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note FROM ' + @sBT
	EXEC(@SQL_#QCDataDetails)
	SET @SQL_#QCDataDetails = 'DROP TABLE ' + @sBT
	EXEC(@SQL_#QCDataDetails)

		IF EXISTS(SELECT TOP 1 * FROM dbo.QCData WHERE ID = @iID)
		BEGIN
			UPDATE dbo.QCData 
			SET DocNum = @DocNum,
				QCName = @QCName,
				QCDate = @QCDate
			WHERE ID = @iID

			UPDATE QCDD
			SET	QCDD.ID_QC = #QCDD.ID_QC, 
				QCDD.ID_PO = #QCDD.ID_PO, 
				QCDD.ItemID = #QCDD.ItemID, 
				QCDD.MS_MAY = #QCDD.MS_MAY, 
				QCDD.ProductionDate = #QCDD.ProductionDate, 
				QCDD.ID_Defect = #QCDD.ID_Defect, 
				QCDD.Quantity = #QCDD.Quantity, 
				QCDD.Note = #QCDD.Note
			FROM dbo.QCDataDetails QCDD 
				INNER JOIN #QCDataDetails #QCDD ON QCDD.ID = #QCDD.ID
			WHERE ISNULL(#QCDD.ID_QC, -1) <> -1 AND QCDD.ID_PO = @ID

			DELETE dbo.QCDataDetails WHERE ID_QC = @iID AND ID NOT IN (SELECT ID FROM #QCDataDetails)
			
			INSERT dbo.QCDataDetails (ID_QC, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note)
			SELECT ID_QC, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note
			FROM #QCDataDetails #QCDD
			WHERE ISNULL(#QCDD.ID, -1) = -1 

			SELECT @iID
		END
		ELSE
		BEGIN
			INSERT dbo.QCData (DocNum, QCName, QCDate)
			VALUES (@DocNum, @QCName, @QCDate)
			SELECT  @ID =  SCOPE_IDENTITY()

			INSERT dbo.QCDataDetails (ID_QC, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note)
			SELECT @ID, ID_PO, ItemID, MS_MAY, ProductionDate, ID_Defect, Quantity, Note
			FROM #QCDataDetails #QCDD
			WHERE ISNULL(#QCDD.ID, -1) = -1 

			SELECT @ID
		END
	END

	IF @iLoai = 4
	BEGIN
		DECLARE @KIEMTRUNG INT = 0
		IF EXISTS(SELECT TOP 1 * FROM dbo.QCData WHERE DocNum = @DocNum AND ID <> @iID)
			SELECT @KIEMTRUNG = 1

		IF EXISTS(SELECT TOP 1 * FROM dbo.QCData WHERE QCName = @QCName AND ID <> @iID)
			SELECT @KIEMTRUNG = 2
	END

	IF @iLoai = 5
	BEGIN
		SELECT ID AS ID_PO, PrOrNumber FROM dbo.ProductionOrder ORDER BY StartDate

		SELECT ID AS ItemID, ItemCode, ItemName FROM dbo.Item ORDER BY ItemCode

		SELECT MS_MAY FROM dbo.MAY ORDER BY MS_MAY 

		SELECT ID AS ID_Defect, CASE @NNgu WHEN 0 THEN DefectName WHEN 1 THEN ISNULL(NULLIF(DefectName_E, ''), DefectName) ELSE ISNULL(NULLIF(DefectName_C, ''), DefectName) END AS DefectName FROM dbo.Defect ORDER BY THU_TU
	END
END
