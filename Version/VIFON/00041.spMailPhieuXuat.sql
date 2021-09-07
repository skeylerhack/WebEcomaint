
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spMailPhieuXuat')
exec('CREATE PROCEDURE spMailPhieuXuat AS BEGIN SET NOCOUNT ON; END')
GO
--SELECT CAN_CU FROM dbo.IC_DON_HANG_XUAT WHERE MS_DH_XUAT_PT = 'PX-1905-0001'
 
ALTER PROCEDURE spMailPhieuXuat
	@MsPX NVARCHAR(50) = 'PX-1905-0002',
	@NNgu INT = 0
AS	

DECLARE @sMail NVARCHAR(MAX) = ''
declare @sName nvarchar(4000) = ''
declare @sTD nvarchar(4000)  

		IF @NNgu = 0  
			SET @sTD = N'Phiếu Xuất : ' + @MsPX 
		ELSE	
			SET @sTD = 'Doc. No' + @MsPX 

		SELECT @sMail = CAN_CU FROM dbo.IC_DON_HANG_XUAT WHERE MS_DH_XUAT_PT = @MsPX
		IF LEN(@sMail) > 0
		BEGIN	
		SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE  '</br>'   END  ,'' )  
		+ '<br>' + B.MS_PT + '-' 
		+ 
		CASE @NNgu WHEN 0 THEN B.TEN_PT WHEN 1 THEN ISNULL(NULLIF(B.TEN_PT_ANH,''),B.TEN_PT) ELSE ISNULL(NULLIF(B.TEN_PT_HOA,''),B.TEN_PT) END
		+' (' + CONVERT(NVARCHAR,A.SO_LUONG_THUC_XUAT) + ' ' + CASE 0  WHEN 0 THEN TEN_1 WHEN 1 THEN TEN_2 ELSE TEN_3 END + ')'
		FROM 
		(
			SELECT * FROM dbo.IC_DON_HANG_XUAT_VAT_TU T1  WHERE	T1.MS_DH_XUAT_PT = @MsPX
		) A INNER JOIN IC_PHU_TUNG B ON A.MS_PT = B.MS_PT  LEFT JOIN DON_VI_TINH C ON B.DVT = C.DVT

		SET	@sName = @sName + '</br>'

		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'CMMSProfile',
		@recipients = @sMail,
		@body = @sName,
		@body_format='HTML',
		@subject = @sTD
END		
