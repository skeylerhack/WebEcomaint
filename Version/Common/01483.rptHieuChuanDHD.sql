IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'rptHieuChuanDHD') 
exec('CREATE PROCEDURE rptHieuChuanDHD AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE rptHieuChuanDHD
	@MS_MAY nvarchar(50) ='10-05-OEQ-004-00',
	@YEAR int = 2016,
	@LANGUAGE INT =0
AS	--	statements
SELECT
CASE @LANGUAGE WHEN 0 THEN MAY.TEN_MAY WHEN 1 THEN ISNULL(NULLIF(MAY.TEN_MAY_ANH,''),MAY.TEN_MAY) ELSE ISNULL(NULLIF(MAY.TEN_MAY_HOA,''),MAY.TEN_MAY) END AS MS_MAY,
HIEU_CHUAN_DHD.MS_PT,TEN_PT,HIEU_CHUAN_DHD.MS_VI_TRI,NGAY,NGAY_KH,LOAI_HIEU_CHUAN.TEN_LOAI_HIEU_CHUAN,GIAY_CHUNG_NHAN,CO_QUAN_HIEU_CHUAN,DANH_GIA,NOI 
FROM HIEU_CHUAN_DHD 
INNER JOIN dbo.MAY MAY ON MAY.MS_MAY = HIEU_CHUAN_DHD.MS_MAY
INNER JOIN IC_PHU_TUNG ON HIEU_CHUAN_DHD.MS_PT=IC_PHU_TUNG.MS_PT 
INNER JOIN LOAI_HIEU_CHUAN ON HIEU_CHUAN_DHD.MS_LOAI_HIEU_CHUAN=LOAI_HIEU_CHUAN.MS_LOAI_HIEU_CHUAN
WHERE HIEU_CHUAN_DHD.MS_MAY	= @MS_MAY AND YEAR(NGAY)=  @YEAR
ORDER BY NGAY DESC
GO