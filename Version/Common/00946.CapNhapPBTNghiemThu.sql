IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CapNhapPBTPTroNghiemThu')
   exec('CREATE PROCEDURE CapNhapPBTPTroNghiemThu AS BEGIN SET NOCOUNT ON; END')
GO



--SET @BTAM = 'PPTT_TMPadmin'
--SET @PBT = 'WO-201702000773'
--select * from PPTT_TMPadmin
-- exec CapNhapPBTPTroNghiemThu 'WO-201702000773','PPTT_TMPadmin'
ALTER procedure CapNhapPBTPTroNghiemThu
	@PBT NVARCHAR(50),
	@BTAM NVARCHAR(250)
AS

DECLARE @sSql NVARCHAR(4000)
CREATE TABLE #TMP_PBTPT(
	[MS_PT] [nvarchar](25) NULL,
	[STT] [int] NULL,
	[LOAI] [int] NULL,
	GHI_CHU [nvarchar](500) 
) ON [PRIMARY]


SET @sSql = 'INSERT INTO #TMP_PBTPT SELECT MS_PT,[STT],LOAI,GHI_CHU FROM ' + @BTAM
exec (@sSql)

SET @sSql = 'DROP TABLE ' + @BTAM
exec (@sSql)


UPDATE PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG SET GHI_CHU = B.GHI_CHU
FROM PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG A INNER JOIN #TMP_PBTPT B
ON A.MS_PT = B.MS_PT AND A.STT = B.STT
WHERE LOAI = 1 AND MS_PHIEU_BAO_TRI = @PBT



DELETE FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO WHERE MS_PHIEU_BAO_TRI = @PBT AND ISNULL(SL_TT,0) = 0

UPDATE PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG SET SL_TT = B.SL_TT
FROM PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG A INNER JOIN
(SELECT MS_PHIEU_BAO_TRI, STT,MS_PT, SUM(SL_TT) AS SL_TT
FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO WHERE MS_PHIEU_BAO_TRI = @PBT  AND MS_CV = STT
GROUP BY MS_PHIEU_BAO_TRI, STT,MS_PT) B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI AND A.MS_PT = B.MS_PT AND A.STT = B.STT
WHERE A.MS_PHIEU_BAO_TRI = @PBT 