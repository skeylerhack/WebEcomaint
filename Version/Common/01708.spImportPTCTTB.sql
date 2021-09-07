
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MInsPhuTung')
   exec('CREATE PROCEDURE MInsPhuTung AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROC [dbo].MInsPhuTung
(
	@sNhom1 NVARCHAR(50) = N'Truyền động',
	@sNhom2 NVARCHAR(50) = N'Bánh vít / Trục vít',
	@sNhom3 NVARCHAR(50) = N'Trục vít',
	@sPhuTung NVARCHAR(250) = N'Trục vít',
	@sThongSo NVARCHAR(250) = N'M=25,4/6-Z=5-q=14 phi 67,7x350 ',
	@sPartNum NVARCHAR(250) = N'',
	@sThongTinKhac NVARCHAR(250) = N'Thau+C45'
)
 
as
begin
DECLARE @sTenPT nvarchar(4000)
SET @sTenPT = LTRIM(RTRIM(@sPhuTung))+'-'+ LTRIM(RTRIM(@sThongSo))

DECLARE @sMsPT NVARCHAR(50) = ''
-- tìm ms phu tung theo ten bo khoang cách
SELECT  TOP 1  @sMsPT = MS_PT FROM dbo.IC_PHU_TUNG WHERE REPLACE(REPLACE(TEN_PT,' ',''),' ','') = REPLACE(REPLACE(@sTenPT,' ',''),' ','') 
-- neu khong có
IF @sMsPT = '' 
BEGIN
		--Tìm max mã phụ tùng
		DECLARE	@sChuoiMa NVARCHAR(50)
		SELECT @sChuoiMa =  LEFT(VTPT,9) FROM dbo.PT_MA_HOA 
		WHERE REPLACE(REPLACE(NHOM1,' ',''),' ','') = REPLACE(REPLACE(@sNhom1,' ',''),' ','')  
		AND REPLACE(REPLACE(NHOM2,' ',''),' ','') = REPLACE(REPLACE(@sNhom2,' ',''),' ','')
		AND REPLACE(REPLACE(NHOM3,' ',''),' ','') = REPLACE(REPLACE(@sNhom3,' ',''),' ','')

		SELECT @sMsPT =  @sChuoiMa + 
		RIGHT('0000' + CONVERT(NVARCHAR(10), ISNULL(MAX(CONVERT(INT,RIGHT(MS_PT,4))),0) + 1 ),4) 
		FROM dbo.IC_PHU_TUNG WHERE LEFT(MS_PT,9) = @sChuoiMa 
		-- Tim dc Ma vtpt trùng voi bang mã hoá mới insert
		IF @sMsPT <> ''
		BEGIN
		--Them loai vat tu neu khong ton tai
		IF NOT EXISTS(
		SELECT * FROM dbo.LOAI_VT WHERE MS_LOAI_VT IN
		(SELECT TOP 1 MA1 FROM dbo.PT_MA_HOA 
			WHERE REPLACE(REPLACE(NHOM1,' ',''),' ','') = REPLACE(REPLACE(@sNhom1,' ',''),' ','')  
			AND REPLACE(REPLACE(NHOM2,' ',''),' ','') = REPLACE(REPLACE(@sNhom2,' ',''),' ','')
			AND REPLACE(REPLACE(NHOM3,' ',''),' ','') = REPLACE(REPLACE(@sNhom3,' ',''),' ','')
		
		))
		BEGIN
			INSERT	INTO dbo.LOAI_VT(MS_LOAI_VT, TEN_LOAI_VT_TV, TEN_LOAI_VT_TA, TEN_LOAI_VT_TH)
			SELECT TOP 1 MA1,NHOM1 AS TEN_LOAI_VT_TV,NHOM1 AS TEN_LOAI_VT_TA,NHOM1 AS TEN_LOAI_VT_TH FROM dbo.PT_MA_HOA 
			WHERE REPLACE(REPLACE(NHOM1,' ',''),' ','') = REPLACE(REPLACE(@sNhom1,' ',''),' ','')  
				AND REPLACE(REPLACE(NHOM2,' ',''),' ','') = REPLACE(REPLACE(@sNhom2,' ',''),' ','')
				AND REPLACE(REPLACE(NHOM3,' ',''),' ','') = REPLACE(REPLACE(@sNhom3,' ',''),' ','')
		END
		-- insert phu tung
		IF NOT EXISTS( SELECT * FROM dbo.IC_PHU_TUNG WHERE MS_PT = @sMsPT )
		BEGIN
			INSERT INTO IC_PHU_TUNG( MS_PT,MS_PT_NCC, TEN_PT,  MS_LOAI_VT, DVT, DUNG_CU_DO, MS_CACH_DAT_HANG, SO_NGAY_DAT_MUA_HANG, TON_TOI_THIEU, SL_DA_DAT_CHUA_MUA, TON_KHO_MAX, HANG_NGOAI, TEN_PT_VIET, ACTIVE_PT, USER_INSERT_PT, NGAY_INSERT_PT , TEN_PT_ANH, TEN_PT_HOA,QUY_CACH ) 
			 SELECT	 @sMsPT MS_PT,@sPartNum AS MS_PT_CTY, @sPhuTung+'-'+@sThongSo AS TEN_PT,(
			 SELECT TOP 1 MA1 FROM dbo.PT_MA_HOA 
				WHERE REPLACE(REPLACE(NHOM1,' ',''),' ','') = REPLACE(REPLACE(@sNhom1,' ',''),' ','')  
				AND REPLACE(REPLACE(NHOM2,' ',''),' ','') = REPLACE(REPLACE(@sNhom2,' ',''),' ','')
				AND REPLACE(REPLACE(NHOM3,' ',''),' ','') = REPLACE(REPLACE(@sNhom3,' ',''),' ','')
			 ) AS MS_LOAI_VT ,3 DVT,0	DUNG_CU_DO,10 MS_CACH_DAT_HANG,	0 SO_NGAY_DAT_MUA_HANG,	0 TON_TOI_THIEU,0 SL_DA_DAT_CHUA_MUA,	0 TON_KHO_MAX,	0 HANG_NGOAI,@sPhuTung+'-'+@sThongSo AS TEN_PT_VIET,
			 1 ACTIVE_PT,	'Admin' USER_INSERT_PT,	'01/01/2020' AS NGAY_INSERT_PT,	@sPhuTung+'-'+@sThongSo AS TEN_PT_ANH,	@sPhuTung+'-'+@sThongSo AS  TEN_PT_HOA,@sThongTinKhac AS QUY_CACH
		END

		--insert phu tung loai phu tung
		IF NOT EXISTS(SELECT * FROM dbo.IC_PHU_TUNG_LOAI_PHU_TUNG WHERE MS_PT = @sMsPT)
		BEGIN
			INSERT	INTO dbo.IC_PHU_TUNG_LOAI_PHU_TUNG(MS_PT, MS_LOAI_PT)
			SELECT @sMsPT MS_PT,12  MS_LOAI_PT
		END

		--insert phu tung loai may
		IF NOT EXISTS(SELECT * FROM dbo.IC_PHU_TUNG_LOAI_MAY WHERE MS_PT = @sMsPT)
		BEGIN
			INSERT INTO dbo.IC_PHU_TUNG_LOAI_MAY(MS_PT, MS_LOAI_MAY)
			SELECT @sMsPT MS_PT ,MS_LOAI_MAY FROM  dbo.LOAI_MAY 
	
		END

		--insert phu tung loai may
		IF NOT EXISTS(SELECT * FROM dbo.IC_PHU_TUNG_KHO WHERE MS_PT = @sMsPT)
		BEGIN

			INSERT INTO dbo.IC_PHU_TUNG_KHO(MS_PT, MS_KHO, MS_VI_TRI, TON_TOI_THIEU, TON_KHO_MAX, GHI_CHU, SO_NGAY_DAT_MUA_HANG)
			SELECT @sMsPT MS_PT,1 MS_KHO, 1 MS_VI_TRI, 0 TON_TOI_THIEU,0 TON_KHO_MAX,0 GHI_CHU,0 SO_NGAY_DAT_MUA_HANG 

		END
		END	

END	



SELECT ISNULL(@sMsPT,'') AS MS_PT
end