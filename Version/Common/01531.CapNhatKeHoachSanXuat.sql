
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CapNhatKeHoachSanXuat')
exec('CREATE PROCEDURE CapNhatKeHoachSanXuat AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE CapNhatKeHoachSanXuat
	@Loai INT =1,
	@TuNgay DATE = '01/01/2018',
	@DenNgay DATE  ='12/31/2018',
	@MsHeThong INT =4,
	@GiaTri FLOAT = 0.1,
	@GhiChu NVARCHAR(MAX) ='test'
AS
BEGIN

DECLARE @TNGay DATE;
SET @TNGay = @TuNgay;
	IF(@Loai = 0)
	BEGIN
		WHILE(@TNGay <= @DenNgay)
		BEGIN
		IF((SELECT COUNT(*) FROM dbo.KHSX_NGAY WHERE MS_HE_THONG =@MsHeThong AND NGAY = @TNGay AND ISNULL(LOAI,0) = @Loai) = 0)
		INSERT INTO dbo.KHSX_NGAY	
		        ( MS_HE_THONG ,
		          MS_N_XUONG ,
		          NGAY ,
		          GIO_KH ,
		          GHI_CHU ,
		          LOAI
		        )
		VALUES  ( @MsHeThong , -- MS_HE_THONG - int
		          NULL , -- MS_N_XUONG - nvarchar(50)
		          @TNGay, -- NGAY - date
		          @GiaTri , -- GIO_KH - float
		          @GhiChu , -- GHI_CHU - nvarchar(100)
		          @Loai  -- LOAI - int
		        )
		ELSE
		UPDATE dbo.KHSX_NGAY
		SET	GIO_KH =@GiaTri,
		GHI_CHU = @GhiChu
		WHERE ISNULL(LOAI,0) =0 AND NGAY =@TNGay AND MS_HE_THONG =@MsHeThong
		SET @TNGay = DATEADD(DAY,1,@TNGay);
		END		
	END
        
	ELSE

	SET @TNGay = CONVERT(DATE,'01/01/'+CONVERT(NVARCHAR(4),YEAR(@TuNgay)));
	IF(@Loai = 1)
	BEGIN
		WHILE(YEAR(@TNGay) <= YEAR(@DenNgay))
		BEGIN
		IF((SELECT COUNT(*) FROM dbo.KHSX_NGAY WHERE MS_N_XUONG =@MsHeThong AND YEAR(NGAY) = YEAR(@TNGay) AND ISNULL(LOAI,0) = @Loai) =0)
		INSERT INTO dbo.KHSX_NGAY	
		        ( MS_HE_THONG ,
		          MS_N_XUONG ,
		          NGAY ,
		          GIO_KH ,
		          GHI_CHU ,
		          LOAI
		        )
		VALUES  ( (SELECT TOP 1 MS_HE_THONG FROM dbo.HE_THONG WHERE NHOM_IN = @MsHeThong), -- MS_HE_THONG - int
		          @MsHeThong , -- MS_N_XUONG - nvarchar(50)
		          @TNGay, -- NGAY - date
		          @GiaTri , -- GIO_KH - float
		          @GhiChu , -- GHI_CHU - nvarchar(100)
		          @Loai  -- LOAI - int
		        )
		ELSE
		UPDATE dbo.KHSX_NGAY
		SET	GIO_KH =@GiaTri,
		GHI_CHU =@GhiChu
		WHERE MS_N_XUONG =@MsHeThong AND YEAR(NGAY) = YEAR(@TNGay) AND ISNULL(LOAI,0) = @Loai
		SET @TNGay = DATEADD(YEAR,1,@TNGay);
		END		
	END 
	SET @TNGay = @TuNgay;
	IF(@Loai = 2)
	BEGIN
		WHILE(@TNGay <= @DenNgay)
		BEGIN
		IF((SELECT COUNT(*) FROM dbo.KHSX_NGAY WHERE MS_HE_THONG =@MsHeThong AND NGAY = @TNGay  AND ISNULL(LOAI,0) = @Loai)	 = 0) 
		INSERT INTO dbo.KHSX_NGAY	
		        ( MS_HE_THONG ,
		          MS_N_XUONG ,
		          NGAY ,
		          GIO_KH ,
		          GHI_CHU ,
		          LOAI
		        )
		VALUES  ( @MsHeThong, -- MS_HE_THONG - int
		         (SELECT NHOM_IN FROM dbo.HE_THONG WHERE MS_HE_THONG = @MsHeThong), -- MS_N_XUONG - nvarchar(50)
		          @TNGay, -- NGAY - date
		          @GiaTri , -- GIO_KH - float
		          @GhiChu , -- GHI_CHU - nvarchar(100)
		          @Loai  -- LOAI - int
		        )
		ELSE
		UPDATE dbo.KHSX_NGAY
		SET	GIO_KH =@GiaTri,
		GHI_CHU =@GhiChu
		WHERE MS_N_XUONG =@MsHeThong AND MONTH(NGAY) = MONTH(@TNGay) AND ISNULL(LOAI,0) = @Loai
		SET @TNGay = DATEADD(MONTH,1,@TNGay);
		END		
	END	
	SELECT ISNULL(SCOPE_IDENTITY(),-1)
END

