

ALTER PROCEDURE [dbo].[spHH]
	@sDMuc NVARCHAR(50) = NULL,
	@iLoai INT = 1,
	@ID_HH BIGINT = 22,
	@MS_HH NVARCHAR(25) = NULL,	
	@MS_HIEN_THI NVARCHAR(25) = NULL,
	@TEN_HH NVARCHAR(50) = NULL,
	@TEN_HH_A NVARCHAR(50) = null,
	@MOTA NVARCHAR(200) = null,
	@ID_LHH INT =NULL,
	@ID_DVT_TON_KHO INT = NULL,
	@INACTIVE BIT = NULL,
	@ID_DT_BH BIGINT = NULL,
	@MS_THEO_KH NVARCHAR(50) = NULL,
	@ID_DHB BIGINT = null,
	@ID_MH BIGINT = null,
	@CAT_No NVARCHAR(10) = NULL,
	@CAT_No2 NVARCHAR(10) = NULL,
	@NGUOI_THIET_KE NVARCHAR(30) = NULL,
	@NAM_TK INT = NULL,
	@MUA_TK NVARCHAR(20) = NULL,
	@GIOI_TINH INT = NULL,
	@DO_TUOI NVARCHAR(20) = null,
	@TONG_TGDM FLOAT = 2.2,
	@ID_DVT_BH BIGINT = NULL,
	@ID_DT_MH BIGINT = NULL,
	@MS_THEO_NCC NVARCHAR(50) = NULL,
	@ID_DVT_MH INT = NULL,
	@HINH_ANH IMAGE		 = NULL,
	@UserID int = NULL,
	@NNgu INT =0,
	@sBTKH NVARCHAR(200) = NULL,
	@sBTTL NVARCHAR(200) = NULL
	
	--SELECT* FROM HANG_HOA WHERE MS_HH='005'

AS
BEGIN       
	--@iLoai = 1 -- VIEW
	--@iLoai = 2 -- DELETE
	--@iLoai = 3 -- INSERT
	--@iLoai = 4 -- Kiem Trung
	--@iLoai = 5 Xoa luon trong nguoi dai dien
	IF UPPER(@sDMuc) = UPPER('mnuHangHoaView')
	BEGIN
	--*********VIEW HÀNG HÓA******
		SELECT ID_HH,MS_HH,MS_HIEN_THI,TEN_HH,TEN_HH_A,MOTA,
		(select t2.TEN_LHH from LOAI_HANG_HOA t2 where t2.ID_LHH=t1.ID_LHH)AS TEN_LHH,
		(SELECT T2.TEN_NHH FROM NHOM_HANG_HOA T2,LOAI_HANG_HOA T3 WHERE T3.ID_LHH=T1.ID_LHH AND T2.ID_NHH=T3.ID_NHH )AS TEN_NHH,INACTIVE
		FROM dbo.HANG_HOA T1 ORDER BY TEN_HH
	END
	ELSE
    BEGIN
	--***********LẤY HÀNG HÓA VÀ CÁC DỮ LIỆU CẦN VIEW THEO @ID_HH*******
	IF @iLoai = 1
	BEGIN
				--======LẤY HÀNG HÓA====

		SELECT ID_HH,MS_HH,MS_HIEN_THI,TEN_HH,TEN_HH_A,MOTA,ID_LHH,
				(select ID_NHH from LOAI_HANG_HOA t2 where t1.ID_LHH=t2.ID_LHH )as ID_NHH,
				ID_DVT_TON_KHO,INACTIVE,ID_DT_BH,MS_THEO_KH,ID_DHB,ID_MH,CAT_No,
				CAT_No2,NGUOI_THIET_KE,NAM_TK,MUA_TK,GIOI_TINH,DO_TUOI,TONG_TGDM,ID_DVT_BH,ID_DT_MH,
				MS_THEO_NCC,ID_DVT_MH,T1.HINH_ANH,CREATE_USERID,CREATED_TIME,LAST_CHANGE_USERID,LAST_CHANGE_TIME  
				FROM dbo.HANG_HOA T1 WHERE (T1.ID_HH = @ID_HH ) ORDER BY TEN_HH

		----LẤY MÀU SIZE HÀNG HÓA
		--SELECT ID_HHMS,MAU_HH,SIZE_HH,INACTIVE,GHI_CHU FROM HANG_HOA_MAU_SIZE WHERE ID_HH=@ID_HH
		----LẤY HÀNG TỒN KHO
		--SELECT ID_HHTK,ID_DVT,MAU,SIZE,SO_LUONG,ID_DHBOR,ID_DVT FROM HANG_HOA_TON_KHO WHERE ID_HH=@ID_HH
					--=====LẤY HÀNG HÓA KHO======
		SELECT A.ID_HH,
			   A.ID_KHO AS ID_KHO_MS,
			   A.ID_KHO AS ID_KHO_TEN,
               A.TON_TOI_THIEU,
               A.TON_TOI_DA,
               A.LEADTIME,
               A.NOTE FROM dbo.HANG_HOA_KHO A
			   WHERE ID_HH = @ID_HH
				--======LẤY HÀNG HÓA TƯ LIỆU======
		SELECT ID_HHTL,DUONG_DAN,TEN_TL,NOTE FROM HANG_HOA_TL WHERE ID_HH=@ID_HH
	END
	----@iLoai = 2 -- DELETE

	

	IF @iLoai = 2 OR @iLoai = 5
	BEGIN
		IF EXISTS (SELECT TOP 1 * FROM dbo.HANG_HOA_MAU_SIZE WHERE ID_HH = @ID_HH)
		BEGIN
			SELECT 1 AS TT	-- TON TAI TRONG HANG_HOA_MAU_SIZE
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.BANG_MAU WHERE ID_HH = @ID_HH )
			BEGIN
				SELECT 2 AS TT		-- TON TAI TRONG BANG_MAU
			END
			ELSE
            BEGIN
			IF EXISTS (SELECT TOP 1 * FROM dbo.BAO_GIA_BAN_CT WHERE ID_HH = @ID_HH )
			BEGIN
				SELECT 3 AS TT		-- TON TAI BAO_GIA_BAN_CT
			END
			ELSE
			BEGIN
				BEGIN TRY
					DELETE dbo.HANG_HOA_TL WHERE ID_HH = @ID_HH	
					DBCC CHECKIDENT (HANG_HOA_TL,RESEED,0)
					DBCC CHECKIDENT (HANG_HOA_TL,RESEED)

					DELETE dbo.HANG_HOA_KHO WHERE ID_HH = @ID_HH	

					DELETE FROM dbo.HANG_HOA WHERE ID_HH = @ID_HH	
					DBCC CHECKIDENT (HANG_HOA,RESEED,0)
					DBCC CHECKIDENT (HANG_HOA,RESEED)

					SELECT 0 AS TT
				END TRY
				BEGIN CATCH
						SELECT ERROR_MESSAGE() as ErrorMessage;    
						SELECT 4 AS TT
				END CATCH	
			END
		END
	END
	END


	--@iLoai = 3 -- INSERT
	IF @iLoai = 3
	BEGIN
		
		CREATE TABLE #BTKH
		(
			[ID_HH] [bigint] NULL,
			[ID_KHO_MS] [int] NULL,
			[TON_TOI_THIEU] [float] NULL,
			[TON_TOI_DA] [float] NULL,
			[LEADTIME] [int] NULL,
			[NOTE] [nvarchar] (max) NULL
		) 
-----------------------------------------------------------------------------------------------------------------

		DECLARE @sSql  NVARCHAR(1000)
		SET @sSql = 'INSERT INTO #BTKH(ID_HH,ID_KHO_MS,TON_TOI_THIEU,TON_TOI_DA,LEADTIME,NOTE)SELECT ID_HH,ID_KHO_MS,TON_TOI_THIEU,TON_TOI_DA,LEADTIME,NOTE FROM '+@sBTKH
		EXEC(@sSql)
		SET @sSql = 'DROP TABLE ' + @sBTKH 
		EXEC(@sSql)


		CREATE TABLE #BTTL
		(
			[ID_HHTL] [bigint] NULL,
			[DUONG_DAN] [nvarchar] (150)  NULL,
			[TEN_TL] [nvarchar] (150)  NULL,
			[NOTE] [nvarchar] (150)  NULL
		) 
-----------------------------------------------------------------------------------------------------------------

		SET @sSql = 'INSERT INTO #BTTL(ID_HHTL,DUONG_DAN,TEN_TL,NOTE)SELECT ID_HHTL,DUONG_DAN,TEN_TL,NOTE FROM '+ @sBTTL
		EXEC(@sSql)
		SET @sSql = 'DROP TABLE ' + @sBTTL 
		EXEC(@sSql)
		          

		IF @ID_HH = -1
		BEGIN
		-------------tHÊM
			INSERT INTO dbo.HANG_HOA(MS_HH, MS_HIEN_THI, TEN_HH, TEN_HH_A,MOTA,ID_LHH,ID_DVT_TON_KHO,INACTIVE,ID_DT_BH,MS_THEO_KH,ID_DHB,ID_MH,CAT_No,CAT_No2,NGUOI_THIET_KE,NAM_TK,MUA_TK,GIOI_TINH,DO_TUOI,TONG_TGDM,ID_DVT_BH,ID_DT_MH,MS_THEO_NCC,ID_DVT_MH,HINH_ANH,CREATE_USERID,CREATED_TIME)
			VALUES(@MS_HH,@MS_HIEN_THI,@TEN_HH,@TEN_HH_A,@MOTA,@ID_LHH,@ID_DVT_TON_KHO,@INACTIVE,@ID_DT_BH,@MS_THEO_KH,@ID_DHB,@ID_MH,@CAT_No,@CAT_No2,@NGUOI_THIET_KE,@NAM_TK,@MUA_TK,@GIOI_TINH,@DO_TUOI,@TONG_TGDM,@ID_DVT_BH,@ID_DT_MH,@MS_THEO_NCC,@ID_DVT_MH,@HINH_ANH,@UserID,GETDATE())

			SET @ID_HH = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
		-------------SUA
			UPDATE dbo.HANG_HOA SET
					MS_HH=@MS_HH,
					MS_HIEN_THI=@MS_HIEN_THI,
					TEN_HH=@TEN_HH,
					TEN_HH_A=@TEN_HH_A,
					MOTA=@MOTA,
					ID_LHH=@ID_LHH,
					ID_DVT_TON_KHO=@ID_DVT_TON_KHO,
					INACTIVE=@INACTIVE,
					ID_DT_BH=@ID_DT_BH,
					ID_DT_MH = @ID_DT_MH,
					MS_THEO_KH=@MS_THEO_KH,
					ID_DHB=@ID_DHB,
					ID_MH=@ID_MH,
					CAT_No=@CAT_No,
					CAT_No2=@CAT_No2,
					NGUOI_THIET_KE=@NGUOI_THIET_KE,
					NAM_TK=@NAM_TK,
					MUA_TK=@MUA_TK,
					GIOI_TINH=@GIOI_TINH,
					DO_TUOI=@DO_TUOI,
					TONG_TGDM=@TONG_TGDM,
					ID_DVT_BH=@ID_DVT_BH,
					MS_THEO_NCC=MS_THEO_NCC,
					ID_DVT_MH=@ID_DVT_MH,
					HINH_ANH=@HINH_ANH,
					LAST_CHANGE_USERID  = @UserID,
					LAST_CHANGE_TIME= GETDATE()
					WHERE ID_HH = @ID_HH
		END

-----------------------------------------------------------------------------------------------------------------
		DELETE dbo.HANG_HOA_KHO WHERE ID_HH = @ID_HH
-----------------------------------------------------------------------------------------------------------------
		INSERT INTO dbo.HANG_HOA_KHO(ID_KHO,ID_HH,TON_TOI_THIEU,TON_TOI_DA,LEADTIME,NOTE)
		SELECT ID_KHO_MS,@ID_HH,TON_TOI_THIEU,TON_TOI_DA,LEADTIME,NOTE FROM #BTKH
-----------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
		DELETE dbo.HANG_HOA_TL WHERE ID_HH = @ID_HH
		DBCC CHECKIDENT (HANG_HOA_TL,RESEED,0)
		DBCC CHECKIDENT (HANG_HOA_TL,RESEED)
-----------------------------------------------------------------------------------------------------------------
		INSERT INTO dbo.HANG_HOA_TL(ID_HH,DUONG_DAN,TEN_TL,NOTE)SELECT @ID_HH,DUONG_DAN,TEN_TL,NOTE FROM #BTTL
-----------------------------------------------------------------------------------------------------------------

		SELECT @ID_HH
	END
	----@loai=4--kiem trung
	IF @iLoai = 4
		BEGIN
			IF ISNULL(@MS_HH,'') <> ''
			BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.HANG_HOA WHERE MS_HH = @MS_HH AND	ID_HH   <> @ID_HH)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
			END
			IF ISNULL(@TEN_HH,'') <> ''
			BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.HANG_HOA WHERE TEN_HH = @TEN_HH AND	ID_HH <> @ID_HH)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
			END
			IF ISNULL(@MS_HIEN_THI,'') <> ''
			BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.HANG_HOA WHERE MS_HIEN_THI = @MS_HIEN_THI AND	ID_HH <> @ID_HH)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
			END
			IF ISNULL(@TEN_HH_A,'') <> ''
			BEGIN
			    IF EXISTS (SELECT TOP 1 * FROM dbo.HANG_HOA WHERE TEN_HH_A = @TEN_HH_A AND	ID_HH <> @ID_HH)
					SELECT 1 AS TT		
				ELSE
					SELECT 0 AS TT	
			END
		END
	END
END