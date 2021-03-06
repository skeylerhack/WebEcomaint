IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertCongViecPhuTro')
   exec('CREATE PROCEDURE InsertCongViecPhuTro AS BEGIN SET NOCOUNT ON; END')
GO





ALTER PROC [dbo].[InsertCongViecPhuTro]
	@MsPBT NVARCHAR(250),
	@CongViec NVARCHAR(250),
	@CVPhuTung NVARCHAR(250)
AS
DECLARE @Sql NVARCHAR(4000)


IF OBJECT_ID('tempdb..#CViec') IS NOT NULL
    DROP TABLE #CViec  
CREATE TABLE  #CViec  
(
	[TEN_CONG_VIEC] [nvarchar](255) NULL,
	[SO_GIO_KH] [float] NULL,
	[MS_PHIEU_BAO_TRI] [nvarchar](20) NULL,
	[STT] [int] NULL,
	[NGAY_HOAN_THANH] [datetime] NULL,
	[NGAY_BDCV] [datetime] NULL,
	[NGAY_KTCV] [datetime] NULL,
	[STT_TMP] [int] NULL
)

SET @Sql = 'INSERT INTO #CViec SELECT * FROM ' + @CongViec
EXEC (@Sql)

SET @Sql = 'DROP TABLE ' + @CongViec
EXEC (@Sql)


IF OBJECT_ID('tempdb..#PhuTung') IS NOT NULL
	DROP TABLE #PhuTung  
CREATE TABLE #PhuTung(
	[MS_PT] [nvarchar](25) NULL,
	[TEN_PT] [nvarchar](250) NULL,
	[QUY_CACH] [nvarchar](255) NULL,
	[SL_KH] [float] NULL,
	[SL_TT] [float] NULL,
	[GHI_CHU] [nvarchar](255) NULL,
	[STT] [int] NULL,
	[MS_PT_STT] [nvarchar](2000) NULL
)

SET @Sql = 'INSERT INTO #PhuTung SELECT * FROM ' + @CVPhuTung
EXEC (@Sql)

SET @Sql = 'DROP TABLE ' + @CVPhuTung
EXEC (@Sql)


UPDATE [PHIEU_BAO_TRI_CV_PHU_TRO] SET [TEN_CONG_VIEC] = T2.[TEN_CONG_VIEC],[SO_GIO_KH] = T2.[SO_GIO_KH]
FROM [PHIEU_BAO_TRI_CV_PHU_TRO] T1 INNER JOIN #CViec T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI AND T1.STT =T2.STT_TMP
WHERE T1.MS_PHIEU_BAO_TRI = @MsPBT AND  ISNULL(STT_TMP,-1) <> -1

INSERT INTO [PHIEU_BAO_TRI_CV_PHU_TRO]([MS_PHIEU_BAO_TRI],[TEN_CONG_VIEC],[SO_GIO_KH],STT_CV)
SELECT[MS_PHIEU_BAO_TRI],[TEN_CONG_VIEC],[SO_GIO_KH],STT FROM #CViec 
WHERE ISNULL(STT_TMP,-1) = -1

	

UPDATE #PhuTung SET STT = A.STT
 FROM PHIEU_BAO_TRI_CV_PHU_TRO A INNER JOIN #PhuTung B ON A.STT_CV = B.STT
 WHERE A.MS_PHIEU_BAO_TRI = @MsPBT


DELETE FROM PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG WHERE MS_PHIEU_BAO_TRI = @MsPBT

INSERT INTO [dbo].[PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG]([MS_PHIEU_BAO_TRI],[STT],[MS_PT],[SL_KH],[SL_TT],[GHI_CHU])
SELECT @MsPBT,[STT],[MS_PT],[SL_KH],[SL_TT],[GHI_CHU] FROM #PhuTung T1








 