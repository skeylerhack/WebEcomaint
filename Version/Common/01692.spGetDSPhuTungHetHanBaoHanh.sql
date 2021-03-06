IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDSPhuTungHetHanBaoHanh')
exec('CREATE PROCEDURE spGetDSPhuTungHetHanBaoHanh AS BEGIN SET NOCOUNT ON; END')
GO
--SELECT MS_MAY,TEN_MAY, 1 AS CHON INTO BTChonMayadmin FROM dbo.MAY
ALTER PROCEDURE spGetDSPhuTungHetHanBaoHanh
	@SBT NVARCHAR(50) ='BTChonMayadmin',
	@TNgay DATETIME = '01/01/1900',
	@DNgay DATETIME = '01/30/2020',
	@MS_LOAI_VT nvarchar (10) ='-1',
	@UserName NVARCHAR(50) ='admin',
	@NNgu INT =0
AS
BEGIN
CREATE TABLE #TEMMAY_PT (
	[MS_MAY] [nvarchar] (30),
	[TEN_MAY] [nvarchar] (255)
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)

set @sSql = 'INSERT INTO #TEMMAY_PT SELECT MS_MAY,TEN_MAY FROM '+@SBT+' WHERE CHON = 1'
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @SBT
EXEC (@sSql)

SELECT   T3.MS_MAY,TEN_MAY,T3.MS_BO_PHAN,T1.MS_PT, CASE @NNgu WHEN 0 THEN TEN_PT WHEN 1 THEN ISNULL(NULLIF(TEN_PT_ANH,''),TEN_PT) ELSE ISNULL(NULLIF(TEN_PT_HOA,''),TEN_PT) END  AS TEN_PT, MS_VI_TRI_PT,
CASE @NNgu WHEN 0 THEN T3.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(TEN_BO_PHAN_ANH,''),TEN_BO_PHAN) ELSE ISNULL(NULLIF(TEN_BO_PHAN_HOA,''),TEN_BO_PHAN) END  AS TEN_BO_PHAN

INTO #CTTBPT FROM dbo.CAU_TRUC_THIET_BI_PHU_TUNG T1 
INNER JOIN dbo.IC_PHU_TUNG T2 ON T2.MS_PT = T1.MS_PT INNER JOIN dbo.CAU_TRUC_THIET_BI T3 ON T3.MS_MAY = T1.MS_MAY AND T3.MS_BO_PHAN = T1.MS_BO_PHAN
 INNER JOIN #TEMMAY_PT ON #TEMMAY_PT.MS_MAY = T1.MS_MAY
WHERE (T2.MS_LOAI_VT =@MS_LOAI_VT OR @MS_LOAI_VT ='-1')

SELECT  T1.MS_MAY,T1.TEN_MAY,T1.MS_BO_PHAN, T1.MS_PT, T1.MS_VI_TRI_PT, MAX(T1.NGAY_HOAN_THANH) AS NGAY_THAY_CUOI, T1.MS_DH_NHAP_PT, T1.XUAT_XU, T1.BAO_HANH_DEN_NGAY,T1.TEN_PT,T1.TEN_BO_PHAN INTO #DATA  
FROM (
SELECT        T1.MS_MAY,TEN_MAY,T2.MS_BO_PHAN, T3.MS_PT, T4.MS_VI_TRI_PT, T2.NGAY_HOAN_THANH, T5.MS_DH_NHAP_PT, T6.XUAT_XU, T6.BAO_HANH_DEN_NGAY,
T7.TEN_PT,T7.TEN_BO_PHAN
FROM            dbo.IC_DON_HANG_NHAP_VAT_TU AS T6 INNER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS T5 ON T6.MS_PT = T5.MS_PT AND T6.ID = T5.ID AND T6.MS_DH_NHAP_PT = T5.MS_DH_NHAP_PT RIGHT OUTER JOIN
                         dbo.PHIEU_BAO_TRI AS T1 INNER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC AS T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS T3 ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI AND T2.MS_CV = T3.MS_CV AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET AS T4 ON T3.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI AND T3.MS_CV = T4.MS_CV AND T3.MS_PT = T4.MS_PT AND T3.MS_BO_PHAN = T4.MS_BO_PHAN ON 
                         T5.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI AND T5.MS_CV = T4.MS_CV AND T5.MS_BO_PHAN = T4.MS_BO_PHAN AND T5.MS_PT = T4.MS_PT AND T5.STT = T4.STT INNER JOIN #CTTBPT T7 ON T7.MS_MAY = T1.MS_MAY AND T7.MS_BO_PHAN = T3.MS_BO_PHAN AND T7.MS_PT = T3.MS_PT 
						
WHERE        (T1.TINH_TRANG_PBT > 3) AND (T2.NGAY_HOAN_THANH <=@DNgay) 
) T1 GROUP BY  T1.MS_MAY,T1.TEN_MAY,T1.MS_BO_PHAN, T1.MS_PT, T1.MS_VI_TRI_PT, T1.MS_DH_NHAP_PT, T1.XUAT_XU, T1.BAO_HANH_DEN_NGAY ,T1.TEN_PT,T1.TEN_BO_PHAN

SELECT ROW_NUMBER()OVER(ORDER BY T1.MS_MAY,T1.MS_BO_PHAN,T1.MS_PT,T1.MS_VI_TRI_PT)AS STT,T1.MS_MAY,T1.TEN_MAY,T1.MS_BO_PHAN,T1.TEN_BO_PHAN,T1.MS_PT,T1.TEN_PT,T1.MS_VI_TRI_PT, 
T1.MS_DH_NHAP_PT,T1.XUAT_XU,T1.BAO_HANH_DEN_NGAY
FROM #DATA T1
INNER JOIN (SELECT T1.MS_MAY,T1.MS_BO_PHAN,T1.MS_PT,T1.MS_VI_TRI_PT,MAX(T1.NGAY_THAY_CUOI) AS NGAY_THAY_CUOI_MAX FROM #DATA T1 GROUP BY T1.MS_MAY,T1.MS_BO_PHAN,T1.MS_PT,T1.MS_VI_TRI_PT) T2 ON T2.MS_MAY = T1.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_PT = T1.MS_PT AND T2.MS_VI_TRI_PT = T1.MS_VI_TRI_PT AND T1.NGAY_THAY_CUOI = T2.NGAY_THAY_CUOI_MAX
--WHERE	T1.BAO_HANH_DEN_NGAY BETWEEN @TNgay AND @DNgay
ORDER BY T1.MS_MAY,T1.MS_BO_PHAN,T1.MS_PT,T1.MS_VI_TRI_PT
END	


