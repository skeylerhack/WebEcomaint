
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spDieuDoKHTTAddEdit')
   exec('CREATE PROCEDURE spDieuDoKHTTAddEdit AS BEGIN SET NOCOUNT ON; END')
GO



ALTER PROC spDieuDoKHTTAddEdit
	@ID_DD BIGINT,
	@BT nvarchar(100)
AS


--Them vao dieu do PBT
DECLARE @sSql NVARCHAR(500)
DELETE FROM DIEU_DO_KHTT WHERE ID_DD = @ID_DD


DECLARE @last_value INT = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE OBJECT_NAME(OBJECT_ID) = 'DIEU_DO_KHTT'));
IF @last_value IS NULL
    BEGIN
        DBCC CHECKIDENT ('DIEU_DO_KHTT', RESEED, 1);
    END
ELSE
    BEGIN
        DECLARE @lastValUsed INT = (SELECT ISNULL(MAX(ID_DD_KHTT),0) FROM DIEU_DO_KHTT);
        DBCC CHECKIDENT ('DIEU_DO_KHTT', RESEED, @lastValUsed);
    END

SET @sSql = 'INSERT INTO [DIEU_DO_KHTT]([ID_DD],[HANG_MUC_ID],[MS_MAY],[MS_CV],[MS_BO_PHAN],[SO_GIO_KH],[SO_NGUOI_DD],[NGAY_DD]) SELECT ' +  CONVERT(NVARCHAR(20),@ID_DD) + ',[HANG_MUC_ID],[MS_MAY],[MS_CV],[MS_BO_PHAN],[THOI_GIAN_DU_KIEN],[SO_NGUOI_DD],[NGAY_DD] FROM ' + @BT 
EXEC (@sSql)


SET @sSql = 'UPDATE KE_HOACH_TONG_CONG_VIEC SET DD_NGAY = T2.NGAY_DD, DD_SN = T2.SO_NGUOI_DD, ID_DD = ' + CONVERT(NVARCHAR(20),@ID_DD)  + '
	FROM            dbo.KE_HOACH_TONG_CONG_VIEC AS T1 INNER JOIN
                         ' + @BT + ' AS T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_MAY = T2.MS_MAY AND T1.MS_CV = T2.MS_CV AND T1.MS_BO_PHAN = T2.MS_BO_PHAN'
EXEC (@sSql)

SELECT HANG_MUC_ID, MIN(DD_NGAY) NGAY_MIN,MAX(DD_NGAY) AS NGAY_MAX INTO #KHTTCV FROM KE_HOACH_TONG_CONG_VIEC  WHERE ID_DD = @ID_DD GROUP BY HANG_MUC_ID

UPDATE KE_HOACH_TONG_THE SET NGAY_GOC = NGAY,NGAY_DK_HT_GOC = NGAY_DK_HT FROM KE_HOACH_TONG_THE T1 INNER JOIN #KHTTCV T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID

UPDATE KE_HOACH_TONG_THE SET NGAY = NGAY_MIN, NGAY_DK_HT = NGAY_MAX FROM KE_HOACH_TONG_THE T1 INNER JOIN #KHTTCV T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID

