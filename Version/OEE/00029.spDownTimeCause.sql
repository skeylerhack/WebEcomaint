
ALTER	PROCEDURE [dbo].[spDownTimeCause]
	@Loai NVARCHAR(50) = 'grd',
	@ID INT = 3,
	@TEN_NGUYEN_NHAN NVARCHAR(250) = '-1',
	@TEN_NGUYEN_NHANA NVARCHAR(250) = '-1',
	@DownTimeTypeID INT = '-1',
	@HU_HONG BIT =1, 
	@BTDK BIT = 1,
	@MAC_DINH BIT =1 ,
	@Planned BIT =1
AS
BEGIN
--Get luoi
IF UPPER(@Loai) = UPPER('Grd')
BEGIN
	SELECT MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, TEN_NGUYEN_NHAN_ANH, HU_HONG, BTDK,
           MAC_DINH, Planned, DownTimeTypeID FROM dbo.NGUYEN_NHAN_DUNG_MAY
END
--Save
IF UPPER(@Loai) = UPPER('Save')
BEGIN
--THEM
	IF @ID = -1
	BEGIN
		INSERT INTO	dbo.NGUYEN_NHAN_DUNG_MAY ( TEN_NGUYEN_NHAN, HU_HONG, BTDK,
		                                    TEN_NGUYEN_NHAN_ANH, MAC_DINH, Planned,
		                                    DownTimeTypeID )
		VALUES(@TEN_NGUYEN_NHAN, @HU_HONG, @BTDK,
		                                    @TEN_NGUYEN_NHANA, @MAC_DINH, @Planned,
		                                    @DownTimeTypeID)
		SELECT SCOPE_IDENTITY();
	END
--SUA
	ELSE
	BEGIN
		UPDATE dbo.NGUYEN_NHAN_DUNG_MAY SET
		TEN_NGUYEN_NHAN =@TEN_NGUYEN_NHAN, HU_HONG=@HU_HONG, BTDK=@BTDK,
		                                    TEN_NGUYEN_NHAN_ANH = @TEN_NGUYEN_NHANA, MAC_DINH =@MAC_DINH, Planned =@Planned,
		                                    DownTimeTypeID = @DownTimeTypeID
		WHERE MS_NGUYEN_NHAN = @ID
		SELECT @ID;
	END
	END

--Delete 
IF UPPER(@Loai) = UPPER('Delete')
BEGIN
	IF EXISTS (SELECT	* FROM dbo.THOI_GIAN_NGUNG_MAY WHERE MS_NGUYEN_NHAN = @ID)
	BEGIN
		SELECT 1 AS TT		
	END
	ELSE
	BEGIN
		DELETE dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN = @ID
		DBCC CHECKIDENT (NGUYEN_NHAN_DUNG_MAY,RESEED,0)
		DBCC CHECKIDENT (NGUYEN_NHAN_DUNG_MAY,RESEED)
		SELECT 0 AS TT		
	END
END	

END


