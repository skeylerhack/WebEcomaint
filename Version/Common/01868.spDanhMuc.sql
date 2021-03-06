


ALTER PROCEDURE [dbo].[spDanhMuc]
	@iID NVARCHAR(1000) = 'N@@frmChung@@ , N@@frmLoaiMay@@ , N@@frmDanhMucHeThong@@ , N@@frmToPhongBan@@ ',
	@sDMuc NVARCHAR(50) = 'mnuEditLanguages',
	@NNgu INT = 0,
	@iLoai INT = 1,
	@COT1 NVARCHAR(1000) = N'Loi 1',
	@COT2 NVARCHAR(1000) = N'',
	@COT3 NVARCHAR(1000) = N'',
	@COT4 NVARCHAR(1000) = N'',
	@COT5 NVARCHAR(1000) = N'',
	@COT6 BIT = NULL,
	@COT7 BIT = NULL,
	@COT8 INT = null,
	@COT9 INT = null,
	@COT10 FLOAT = null,
	@COT11 FLOAT = null,
	@COT12 NVARCHAR(1000) = N''
AS
BEGIN
	--@iLoai = 1 -- VIEW
	--@iLoai = 2 -- DELETE
	--@iLoai = 3 -- INSERT
	--@iLoai = 4 -- kiem trung

	DECLARE @sKiem NVARCHAR(1000)
	DECLARE @sSql NVARCHAR(MAX)

	IF UPPER(@sDMuc) = UPPER('mnuEditLanguages') 
		BEGIN
			IF @iLoai = 1
			BEGIN
				--SELECT STT,FORM,KEYWORD, VIETNAM, ENGLISH, CHINESE, VIETNAM_OR, ENGLISH_OR, CHINESE_OR FROM dbo.LANGUAGES WHERE FORM = @iID OR FORM = 'frmChung' ORDER BY FORM,KEYWORD
				SET @sSql = 'SELECT STT,FORM,KEYWORD, VIETNAM, ENGLISH, CHINESE, VIETNAM_OR, ENGLISH_OR, CHINESE_OR FROM dbo.LANGUAGES WHERE FORM IN (' + REPLACE(@iID,'@@','''') + ') ORDER BY FORM,KEYWORD'
				EXEC (@sSql)
			END

			IF @iLoai = 2
			BEGIN

				CREATE TABLE #BTNN
				(
					[STT] [int] NULL,
					[FORM] [nvarchar] (max)  NULL,
					[KEYWORD] [nvarchar] (max)  NULL,
					[VIETNAM] [nvarchar] (max)  NULL,
					[ENGLISH] [nvarchar] (max)  NULL,
					[CHINESE] [nvarchar] (max)  NULL,
					[VIETNAM_OR] [nvarchar] (max)  NULL,
					[ENGLISH_OR] [nvarchar] (max)  NULL,
					[CHINESE_OR] [nvarchar] (max)  NULL,
					[MS_MODULE] [nvarchar] (max)  NULL,
					[HANG_MUC] [nvarchar] (max)  NULL,
					[FORM_HAY_REPORT] [bit] NULL
				) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

				
				SET @sSql = 'INSERT INTO #BTNN(STT, FORM, KEYWORD, VIETNAM, ENGLISH, CHINESE, VIETNAM_OR, ENGLISH_OR, CHINESE_OR)
				SELECT STT, FORM, KEYWORD, VIETNAM, ENGLISH, CHINESE, VIETNAM_OR, ENGLISH_OR, CHINESE_OR FROM ' + @COT1
				EXEC (@sSql) 

				SET @sSql = 'DROP TABLE ' + @COT1
				EXEC (@sSql) 

				UPDATE dbo.LANGUAGES SET	VIETNAM = T2.VIETNAM,VIETNAM_OR = T2.VIETNAM_OR, ENGLISH = T2.ENGLISH,ENGLISH_OR = T2.ENGLISH_OR, CHINESE = T2.CHINESE, CHINESE_OR = T2.CHINESE_OR  FROM dbo.LANGUAGES T1 INNER JOIN #BTNN T2 ON T1.STT = T2.STT	

			END

		END



	IF UPPER(@sDMuc) = UPPER('mnuLoaiMay') 
		BEGIN
			IF @iLoai = 1
			BEGIN
				SELECT MS_LOAI_MAY, TEN_LOAI_MAY, TEN_LOAI_MAY_ANH, TEN_LOAI_MAY_HOA, STT_MAY, ISNULL(ATTACHMENT,0) AS ATTACHMENT, GHI_CHU FROM dbo.LOAI_MAY ORDER BY STT_MAY
			END

			IF @iLoai = 2
			BEGIN
			IF EXISTS (SELECT TOP 1 MS_NHOM_MAY FROM dbo.NHOM_MAY WHERE MS_LOAI_MAY = @iID)
					BEGIN
						SELECT 1 AS TT		
					END
					ELSE
					BEGIN
						DELETE dbo.LOAI_MAY WHERE(MS_LOAI_MAY = @iID)
						SELECT 0 AS TT		
					END	
			END

			IF @iLoai = 3
			BEGIN
				IF EXISTS (SELECT TOP 1 * FROM dbo.LOAI_MAY WHERE MS_LOAI_MAY = @iID)
				BEGIN
					UPDATE dbo.LOAI_MAY SET MS_LOAI_MAY = @COT1, TEN_LOAI_MAY = @COT2, TEN_LOAI_MAY_ANH = @COT3, TEN_LOAI_MAY_HOA = @COT4, GHI_CHU = @COT5, STT_MAY = @COT8, ATTACHMENT = @COT6 WHERE MS_LOAI_MAY = @iID
					SELECT @COT1
				END
				ELSE
				BEGIN
					INSERT INTO dbo.LOAI_MAY(MS_LOAI_MAY,TEN_LOAI_MAY,TEN_LOAI_MAY_ANH,TEN_LOAI_MAY_HOA,GHI_CHU,STT_MAY,ATTACHMENT)
					VALUES (@COT1,@COT2,@COT3,@COT4,@COT5,@COT8,@COT6)		
					SELECT @COT1
				END
			END

			IF @iLoai = 4
			BEGIN
				IF @COT1 <> ''
					BEGIN
					IF EXISTS (SELECT TOP 1 * FROM dbo.LOAI_MAY WHERE MS_LOAI_MAY = @COT1 AND MS_LOAI_MAY <> @iID)
						SELECT 1 AS TT		
					ELSE
						SELECT 0 AS TT	
					END
				IF @COT2 <> ''
					BEGIN
					IF EXISTS (SELECT TOP 1 * FROM dbo.LOAI_MAY WHERE TEN_LOAI_MAY = @COT2 AND	MS_LOAI_MAY <> @iID)
						SELECT 1 AS TT		
					ELSE
						SELECT 0 AS TT	
					END
				IF @COT3 <> '' 
					BEGIN
					IF EXISTS (SELECT TOP 1 * FROM dbo.LOAI_MAY WHERE TEN_LOAI_MAY_ANH = @COT3 AND	MS_LOAI_MAY <> @iID)
						SELECT 1 AS TT		
					ELSE
						SELECT 0 AS TT	
					END
				IF @COT4 <> '' 
					BEGIN
					IF EXISTS (SELECT TOP 1 * FROM dbo.LOAI_MAY WHERE TEN_LOAI_MAY_HOA = @COT4 AND	MS_LOAI_MAY <> @iID)
						SELECT 1 AS TT		
					ELSE
						SELECT 0 AS TT	
					END
			END
		END

	IF UPPER(@sDMuc) = UPPER('mnuNhomMay') 
	BEGIN
		IF @iLoai = 1
		BEGIN
			SELECT MS_NHOM_MAY, TEN_NHOM_MAY, TEN_NHOM_MAY_ANH, TEN_NHOM_MAY_HOA, MS_LOAI_MAY, GHI_CHU FROM dbo.NHOM_MAY ORDER BY MS_LOAI_MAY, MS_NHOM_MAY
		END

		IF @iLoai = 2
		BEGIN
			DELETE dbo.NHOM_MAY WHERE(MS_NHOM_MAY = @iID)
			SELECT 0 AS TT		
		END

		IF @iLoai = 3
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.NHOM_MAY WHERE MS_NHOM_MAY = @iID)
			BEGIN
				UPDATE dbo.NHOM_MAY SET MS_NHOM_MAY = @COT1, TEN_NHOM_MAY = @COT2, TEN_NHOM_MAY_ANH = @COT3, TEN_NHOM_MAY_HOA = @COT4, GHI_CHU = @COT5, MS_LOAI_MAY = @COT12 WHERE MS_NHOM_MAY = @iID
				SELECT @COT1
			END
			ELSE
			BEGIN
				INSERT INTO dbo.NHOM_MAY(MS_NHOM_MAY,TEN_NHOM_MAY,TEN_NHOM_MAY_ANH,TEN_NHOM_MAY_HOA,GHI_CHU,MS_LOAI_MAY)
				VALUES (@COT1,@COT2,@COT3,@COT4,@COT5,@COT12)		
				SELECT @COT1
			END
		END

		IF @iLoai = 4
		BEGIN
			IF @COT1 <> ''
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.NHOM_MAY WHERE MS_NHOM_MAY = @COT1 AND MS_NHOM_MAY <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT2 <> ''
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.NHOM_MAY WHERE TEN_NHOM_MAY = @COT2 AND	MS_NHOM_MAY <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT3 <> '' 
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.NHOM_MAY WHERE TEN_NHOM_MAY_ANH = @COT3 AND	MS_NHOM_MAY <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT4 <> '' 
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.NHOM_MAY WHERE TEN_NHOM_MAY_HOA = @COT4 AND	MS_NHOM_MAY <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
		END

		IF @iLoai = 5
		BEGIN
			SELECT MS_LOAI_MAY, CASE @NNgu WHEN 0 THEN TEN_LOAI_MAY WHEN 1 THEN ISNULL(NULLIF(TEN_LOAI_MAY_ANH, ''), TEN_LOAI_MAY) ELSE ISNULL(NULLIF(TEN_LOAI_MAY_HOA, ''), TEN_LOAI_MAY) END AS TEN_LOAI_MAY  FROM dbo.LOAI_MAY ORDER BY STT_MAY
		END
	END

	IF UPPER(@sDMuc) = UPPER('mnuNhomLoi') 
	BEGIN
		IF @iLoai = 1
		BEGIN
			SELECT ID, DefectGroupName, DefectGroupName_E, DefectGroupName_C, THU_TU, Note FROM dbo.DefectGroup
			ORDER BY THU_TU
		END

		IF @iLoai = 2
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.Defect WHERE ID_DG = CONVERT(BIGINT,@iID))
				BEGIN
					SELECT 1 AS TT		
				END
				ELSE
				BEGIN
					DELETE dbo.DefectGroup WHERE(ID = @iID)
					SELECT 0 AS TT			
				END	
		END

		IF @iLoai = 3
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.DefectGroup WHERE ID = CONVERT(BIGINT,@iID))
			BEGIN
				UPDATE dbo.DefectGroup SET DefectGroupName = @COT1, DefectGroupName_E = @COT2, DefectGroupName_C = @COT3, Note = @COT4, THU_TU = @COT8 WHERE ID = @iID
				SELECT @iID
			END
			ELSE
			BEGIN
				INSERT INTO dbo.DefectGroup(DefectGroupName,DefectGroupName_E,DefectGroupName_C,Note,THU_TU)
				VALUES (@COT1,@COT2,@COT3,@COT4,@COT8)		
				SELECT SCOPE_IDENTITY()
			END
		END

		IF @iLoai = 4
		BEGIN
			IF @COT1 <> ''
				BEGIN
				IF EXISTS (SELECT TOP 1 * FROM dbo.DefectGroup WHERE DefectGroupName = @COT1 AND ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT2 <> ''
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.DefectGroup WHERE DefectGroupName_E = @COT2 AND	ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT3 <> '' 
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.DefectGroup WHERE DefectGroupName_C = @COT3 AND ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
		END

		
		IF @iLoai = 5
		BEGIN
			SELECT ID, CASE @NNgu WHEN 0 THEN DefectGroupName WHEN 1 THEN ISNULL(NULLIF(DefectGroupName_E, ''), DefectGroupName) ELSE ISNULL(NULLIF(DefectGroupName_C, ''), DefectGroupName) END AS DefectGroupName FROM dbo.DefectGroup ORDER BY THU_TU
		END
	END

	IF UPPER(@sDMuc) = UPPER('mnuLoaiLoi') 
	BEGIN
		IF @iLoai = 1
		BEGIN
			SELECT D.ID, D.DefectName, D.DefectName_E, D.DefectName_C, CASE 0 WHEN 0 THEN DG.DefectGroupName WHEN 1 THEN ISNULL(NULLIF(DG.DefectGroupName_E, ''), DG.DefectGroupName) ELSE ISNULL(NULLIF(DG.DefectGroupName_C, ''), DG.DefectGroupName) END AS DefectGroupName, D.THU_TU, D.Note 
			FROM dbo.Defect D
				INNER JOIN dbo.DefectGroup DG ON D.ID_DG = DG.ID
			ORDER BY D.THU_TU
		END

		IF @iLoai = 2
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.QCDataDetails WHERE ID_Defect = @iID)
				BEGIN
					SELECT 1 AS TT		
				END
				ELSE
				BEGIN
					DELETE dbo.Defect WHERE(ID = @iID)
					SELECT 0 AS TT			
				END	
		END

		IF @iLoai = 3
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.Defect WHERE ID = @iID)
			BEGIN
				UPDATE dbo.Defect SET DefectName = @COT1, DefectName_E = @COT2, DefectName_C = @COT3, Note = @COT4, THU_TU = @COT8, ID_DG = @COT9 WHERE ID = @iID
				SELECT @iID
			END
			ELSE
			BEGIN
				INSERT INTO dbo.Defect(DefectName,DefectName_E,DefectName_C,Note,THU_TU,ID_DG)
				VALUES (@COT1,@COT2,@COT3,@COT4,@COT8,@COT9)		
				SELECT SCOPE_IDENTITY()
			END
		END

		IF @iLoai = 4
		BEGIN
			IF @COT1 <> ''
				BEGIN
				IF EXISTS (SELECT TOP 1 * FROM dbo.Defect WHERE DefectName = @COT1 AND ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT2 <> ''
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.Defect WHERE DefectName_E = @COT2 AND	ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
			IF @COT3 <> '' 
				BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.Defect WHERE DefectName_C = @COT3 AND ID <> @iID)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
				END
		END

		
		IF @iLoai = 5
		BEGIN
			SELECT ID, CASE @NNgu WHEN 0 THEN DefectGroupName WHEN 1 THEN ISNULL(NULLIF(DefectGroupName_E, ''), DefectGroupName) ELSE ISNULL(NULLIF(DefectGroupName_C, ''), DefectGroupName) END AS DefectGroupName FROM dbo.DefectGroup ORDER BY THU_TU
		END
	END
END

