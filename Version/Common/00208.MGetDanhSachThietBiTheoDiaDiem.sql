
--	exec MGetDanhSachThietBiTheoDiaDiem '-1','-1','-1','-1','-1','-1','administrator','-1',1
ALTER PROCEDURE [dbo].[MGetDanhSachThietBiTheoDiaDiem]
	@MS_TINH NVARCHAR(50),
	@MS_QUAN NVARCHAR(50),
	@MS_DUONG NVARCHAR(50),
	@MSNX NVARCHAR(150),
	@MSHT INT,
	@MSLMAY NVARCHAR(50),
	@USERNAME NVARCHAR(100),
	@MSBPCP int,
	@LoaiBC int
as
DECLARE @DENNGAY DATETIME
SET @DENNGAY  = GETDATE()


	
SELECT * INTO #MAY FROM dbo.MGetMayUserNgay(@DENNGAY, @USERNAME, @MSNX, @MSHT, @MSBPCP, @MSLMAY, '-1','-1', 0)

SELECT dbo.Get_Street(MS_DUONG) AS TEN_DUONG, dbo.Get_Distrct(MS_QG)  AS TEN_TP, 
		ISNULL(dbo.Get_City([dbo].[Get_CityCode](MS_QG)),'') AS TEN_QG ,
		[dbo].[Get_CityCode](A.MS_QG) AS MS_TINH,A.MS_QG AS MS_QUAN, A.* 
INTO #NXUONG		
FROM NHA_XUONG A 


SELECT DISTINCT MS_MAY INTO #MAY_TMP FROM #MAY A INNER JOIN #NXUONG B ON A.MS_N_XUONG = B.MS_N_XUONG
WHERE (@MS_TINH = '-1' OR B.MS_TINH = @MS_TINH )
AND (@MS_QUAN = '-1' OR B.MS_QUAN = @MS_QUAN )
AND (@MS_DUONG = '-1' OR B.MS_DUONG = @MS_DUONG ) 
	
SELECT CONVERT(int,null) AS STT,    A.MS_MAY, A.TEN_MAY, A.MO_TA, 
			dbo.NHA_XUONG.Ten_N_XUONG ,dbo.HE_THONG.TEN_HE_THONG, dbo.BO_PHAN_CHIU_PHI.TEN_BP_CHIU_PHI , 			
			A.NGAY_MUA, 
CASE @LoaiBC WHEN 1 THEN dbo.MAY_NHA_XUONG_NGAY_MAX.NGAY_MAX 
			WHEN 2 THEN dbo.MAY_HE_THONG_NGAY_MAX.NGAY_MAX
			ELSE dbo.MAY_BPCP_NGAY_MAX.NGAY_MAX END AS NGAY_LAP,                      
                      dbo.KHACH_HANG.TEN_CONG_TY, A.NHIEM_VU_THIET_BI, A.MODEL, dbo.HIEN_TRANG_SU_DUNG_MAY.TEN_HIEN_TRANG

                      
FROM         dbo.MAY AS A LEFT OUTER JOIN
                      dbo.KHACH_HANG ON A.MS_KH = dbo.KHACH_HANG.MS_KH LEFT OUTER JOIN
                      dbo.MAY_BPCP_NGAY_MAX ON A.MS_MAY = dbo.MAY_BPCP_NGAY_MAX.MS_MAY LEFT OUTER JOIN
                      dbo.MAY_HE_THONG_NGAY_MAX ON A.MS_MAY = dbo.MAY_HE_THONG_NGAY_MAX.MS_MAY LEFT OUTER JOIN
                      dbo.MAY_NHA_XUONG_NGAY_MAX ON A.MS_MAY = dbo.MAY_NHA_XUONG_NGAY_MAX.MS_MAY INNER JOIN
                      dbo.[#MAY_TMP] AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.NHA_XUONG ON dbo.MAY_NHA_XUONG_NGAY_MAX.MS_N_XUONG = dbo.NHA_XUONG.MS_N_XUONG INNER JOIN
                      dbo.HE_THONG ON dbo.MAY_HE_THONG_NGAY_MAX.MS_HE_THONG = dbo.HE_THONG.MS_HE_THONG INNER JOIN
                      dbo.BO_PHAN_CHIU_PHI ON dbo.MAY_BPCP_NGAY_MAX.MS_BP_CHIU_PHI = dbo.BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI INNER JOIN
                      dbo.HIEN_TRANG_SU_DUNG_MAY ON A.MS_HIEN_TRANG = dbo.HIEN_TRANG_SU_DUNG_MAY.MS_HIEN_TRANG
ORDER BY
CASE @LoaiBC WHEN 1 THEN dbo.NHA_XUONG.Ten_N_XUONG
			WHEN 2 THEN dbo.HE_THONG.TEN_HE_THONG
			ELSE TEN_BP_CHIU_PHI END , MS_MAY
