

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spDDNhom')
   
exec('CREATE PROCEDURE spDDNhom AS BEGIN SET NOCOUNT ON; END')

GO

ALTER PROCEDURE spDDNhom
    @Action INT = 1,
	@ID_NHOM_DD BIGINT = -1, 
	@TEN_NHOM NVARCHAR(250) = '-1', 
	@TEN_NHOM_ANH NVARCHAR(250) = '-1', 
	@TEN_NHOM_HOA NVARCHAR(250) = '-1', 
	@GHI_CHU NVARCHAR(500) = '-1' 
AS
BEGIN
    
--View
IF @Action = 1 
BEGIN
   SELECT ID_NHOM_DD, TEN_NHOM, TEN_NHOM_ANH, TEN_NHOM_HOA, GHI_CHU FROM dbo.DIEU_DO_NHOM ORDER BY TEN_NHOM                
END

--Add + Edit
IF @Action = 2
BEGIN
--Add
IF @ID_NHOM_DD = -1 
	BEGIN
		IF @TEN_NHOM_HOA='' SET @TEN_NHOM_HOA = @TEN_NHOM
		IF @TEN_NHOM_ANH='' SET @TEN_NHOM_ANH = @TEN_NHOM

		INSERT INTO	dbo.DIEU_DO_NHOM(TEN_NHOM, TEN_NHOM_ANH, TEN_NHOM_HOA, GHI_CHU)
		VALUES(@TEN_NHOM ,@TEN_NHOM_ANH, @TEN_NHOM_HOA, @GHI_CHU)                
		SELECT SCOPE_IDENTITY()
	END
ELSE
--Edit
BEGIN
   UPDATE dbo.DIEU_DO_NHOM SET	TEN_NHOM = @TEN_NHOM,
	   TEN_NHOM_ANH = @TEN_NHOM_ANH,
	   TEN_NHOM_HOA = @TEN_NHOM_HOA,
	   GHI_CHU = @GHI_CHU 
	   WHERE ID_NHOM_DD = @ID_NHOM_DD
   SELECT @ID_NHOM_DD
END


END

--Xoa
IF @Action = 3 
BEGIN
	
	IF EXISTS (SELECT TOP 1 * FROM dbo.DIEU_DO_NHOM_CN WHERE ID_NHOM_DD = @ID_NHOM_DD) 
	BEGIN  -- Co trong nhom dieu do cong nhan
		SELECT 1    
	END 
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 * FROM dbo.DIEU_DO_NHOM_MAY WHERE ID_NHOM_DD = @ID_NHOM_DD) 
		BEGIN  -- Co trong nhom dieu do may	
			SELECT 2    
		END 
		ELSE	
		BEGIN
		    DELETE dbo.DIEU_DO_NHOM WHERE ID_NHOM_DD = @ID_NHOM_DD
			SELECT 3
		END
	END
   
END

END
