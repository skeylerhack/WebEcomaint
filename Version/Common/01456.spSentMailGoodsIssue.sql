IF NOT EXISTS (SELECT * FROM sys.objects WHERE type='P' AND name='spSentMailGoodsIssue')
    EXEC('CREATE PROCEDURE spSentMailGoodsIssue AS BEGIN SET NOCOUNT ON; END');
GO

ALTER PROCEDURE spSentMailGoodsIssue 
	@MsPBT NVARCHAR(50) = 'WO-201812000050'
AS
DECLARE @recipients NVARCHAR(MAX) = 'lam.huynh@pilmico.vn;hieu.huynh@pilmico.vn;khanh.pham@pilmico.vn;cynthia.racaza@aboitiz.com;mashinhat@gmail.com;pergebriel.guinita@aboitiz.com'



IF ISNULL(@MsPBT ,'') <> ''
BEGIN
DECLARE @sBody NVARCHAR(MAX);
SELECT @sBody=COALESCE(@sBody+'</p>'+'<p>', '') + ' Item ID : ' + T1.MS_PT + N' - Item Code : ' + T2.MS_PT_NCC + N' - Item Name : ' + T2.TEN_PT + N' - Quantity :  ' + CONVERT(NVARCHAR(30), SL_KH) + N' ' + T3.TEN_1
FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG T1
     INNER JOIN dbo.IC_PHU_TUNG T2 ON T1.MS_PT=T2.MS_PT
     INNER JOIN dbo.DON_VI_TINH T3 ON T2.DVT=T3.DVT
WHERE T1.MS_PHIEU_BAO_TRI=@MsPBT;
SET @sBody=N'<p>Items In Goods Issue for Work Order ' + @MsPBT + '</p>'+N'<p>'+@sBody+N'</p>';

--SELECT @sBody
EXEC msdb.dbo.sp_send_dbmail 
	@profile_name='CMMS_MAIL', 
	@recipients=@recipients, 
	@body=@sBody, 
	@subject='Goods Issue form CMMS - TEST ERP', 
	@body_format='HTML', 
	@exclude_query_output=1;

	SELECT 1 AS TC
END	
ELSE
BEGIN
    SELECT 0 AS TC
END	
	