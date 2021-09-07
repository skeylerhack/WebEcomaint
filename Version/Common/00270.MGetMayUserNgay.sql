
--SELECT * FROM MAY where ms_may not in (SELECT distinct ms_may FROM [dbo].[MGetMayUserNgay]( '01/01/2016','admin','-1',-1,-1,'-1','-1','-1'))
--SELECT * FROM [dbo].[MGetMayUserNgay]( '01/01/2006','ADMIN','GF-01-01',13,100,'BAF','BAF-01','-1')
----SELECT * FROM [dbo].[MGetMayUserNgay]( '01/01/2006','anhdn','GF-01-01',13,100,'BAF','BAF-01','BAF-0001')
----SELECT * FROM [dbo].[MGetMayUserNgay]( '01/01/2016','admin','-1',-1,-1,'-1','-1','-1',0)

ALTER FUNCTION [dbo].[MGetMayUserNgay]
(
	@NgayHT DATETIME,
	@UserName NVARCHAR(50),
	@MsNXuong nvarchar(50),
	@MsHeThong int,
	@MsBPCPhi int,
	@MsLoaiMay NVARCHAR (20),
	@NhomMay NVARCHAR (20),
	@MSMay NVARCHAR (100),
	@NNgu int
)

returns @NLMTMP TABLE (
	[MS_MAY] [nvarchar](30) NOT NULL,
	[MS_NHOM_MAY] [nvarchar](20) NULL,
	[MS_LOAI_MAY] [nvarchar](20) NULL,
	[MS_HSX] [int] NULL,
	[MS_HIEN_TRANG] [int] NULL,
	[MS_KH] [varchar](20) NULL,
	[SO_NAM_KHAU_HAO] [int] NULL,
	[MO_TA] [nvarchar](255) NULL,
	[NHIEM_VU_THIET_BI] [nvarchar](150) NULL,
	[MODEL] [nvarchar](50) NULL,
	[SERIAL_NUMBER] [nvarchar](50) NULL,
	[NGAY_SX] [datetime] NULL,
	[NUOC_SX] [nvarchar](30) NULL,
	[NGAY_MUA] [datetime] NULL,
	[NGAY_BD_BAO_HANH] [datetime] NULL,
	[NGAY_DUA_VAO_SD] [datetime] NULL,
	[SO_THE] [nvarchar](50) NULL,
	[SO_NGAY_LV_TRONG_TUAN] [float] NULL,
	[SO_GIO_LV_TRONG_NGAY] [float] NULL,
	[MS_DVT_RT] [int] NULL,
	[TY_LE_CON_LAI] [int] NULL,
	[MUC_UU_TIEN] [smallint] NULL,
	[SO_THANG_BH] [int] NULL,
	[GIA_MUA] [float] NULL,
	[NGOAI_TE] [nvarchar](6) NULL,
	[LUU_Y_SU_DUNG] [nvarchar](1000) NULL,
	[Anh_TB] [nvarchar](255) NULL,
	[CHU_KY_HC_TB] [int] NULL,
	[TEN_MAY] [nvarchar](255) NULL,
	[AN_TOAN] [bit] NULL,
	[MS_HO_SO] [nvarchar](50) NULL,
	[TEN_HO_SO] [nvarchar](150) NULL,
	[NGAY_HIEU_LUC_HO_SO] [datetime] NULL,
	[SO_CT] [nvarchar](30) NULL,
	[TI_GIA_VND] [float] NULL,
	[TI_GIA_USD] [float] NULL,
	[CHU_KY_HIEU_CHUAN_TB_NGOAI] [int] NULL,
	[CHU_KY_KD_TB] [int] NULL,
	[DON_VI_THOI_GIAN] [int] NULL,
	[MS_N_XUONG] [nvarchar](50) NOT NULL,
	[MS_HE_THONG] INT NOT NULL,
	[MS_BP_CHIU_PHI] INT NOT NULL,
	[USER_INSERT]	nvarchar(50),
	[NGAY_INSERT]	datetime,
	[USER_UPDATE]	nvarchar(50),
	[NGAY_UPDATE]	datetime,
	[Ten_N_XUONG] [nvarchar](250)  NULL,
	[TEN_HE_THONG] [nvarchar](250)  NULL,
	[TEN_NHOM_MAY] [nvarchar](250)  NULL,
	[TEN_LOAI_MAY] [nvarchar](250)  NULL,
	[TEN_BP_CHIU_PHI] [nvarchar](250)  NULL
)
as 
begin
DECLARE @MAY_TMP TABLE ([MS_MAY] [nvarchar](30) NOT NULL,[MS_N_XUONG] [nvarchar](50) NOT NULL, 
		[MS_HE_THONG] INT NOT NULL,[MS_NHOM_MAY] [nvarchar](20) NOT NULL,
		[MS_LOAI_MAY] [nvarchar](20) NOT NULL,[MS_BP_CHIU_PHI] INT NOT NULL,
		[Ten_N_XUONG] [nvarchar](250)  NULL,
		[TEN_HE_THONG] [nvarchar](250)  NULL,
		[TEN_NHOM_MAY] [nvarchar](250)  NULL,
		[TEN_LOAI_MAY] [nvarchar](250)  NULL,
		[TEN_BP_CHIU_PHI] [nvarchar](250)  NULL)
	
INSERT INTO @MAY_TMP	
SELECT dbo.MAY.MS_MAY, MAY_NHA_XUONG_TMP.MS_N_XUONG, NHOM_HE_THONG.MS_HE_THONG, dbo.NHOM_MAY.MS_NHOM_MAY, 
		dbo.NHOM_MAY.MS_LOAI_MAY, A.MS_BP_CHIU_PHI, 
		TEN_N_XUONG, TEN_HE_THONG, TEN_NHOM_MAY, TEN_LOAI_MAY, TEN_BP_CHIU_PHI
	FROM 
	(SELECT DISTINCT MHT.MS_MAY, MHT.MS_HE_THONG, TEN_HE_THONG FROM dbo.MAY_HE_THONG AS MHT 
		INNER JOIN (SELECT     MS_MAY, MAX(NGAY_NHAP) AS NGAY_MAX FROM dbo.MAY_HE_THONG 
					WHERE (NGAY_NHAP <= @NgayHT) 
					GROUP BY MS_MAY) AS MAY_MAX ON MHT.MS_MAY = MAY_MAX.MS_MAY AND MHT.NGAY_NHAP = MAY_MAX.NGAY_MAX 
		INNER JOIN dbo.HE_THONG ON MHT.MS_HE_THONG = dbo.HE_THONG.MS_HE_THONG
		WHERE (MHT.MS_HE_THONG = @MsHeThong OR @MsHeThong = -1)
	) AS MAY_HE_THONG_TMP INNER JOIN
	(SELECT MS_HE_THONG	FROM dbo.MashjGetNhomHeThong(@UserName) AS MashjGetNhomHeThong_1) AS NHOM_HE_THONG ON 
		MAY_HE_THONG_TMP.MS_HE_THONG = NHOM_HE_THONG.MS_HE_THONG INNER JOIN
	(SELECT DISTINCT  A.MS_MAY, A.MS_N_XUONG,
		CASE @NNgu WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TEN_N_XUONG
	 FROM (
		SELECT MS_MAY,MS_N_XUONG FROM [dbo].[MGetUserMayNXCha](@MsNXuong,@UserName,@NgayHT)) A
			INNER JOIN dbo.NHA_XUONG ON A.MS_N_XUONG = dbo.NHA_XUONG.MS_N_XUONG
	) AS MAY_NHA_XUONG_TMP INNER JOIN dbo.NHOM_MAY INNER JOIN dbo.MAY ON dbo.NHOM_MAY.MS_NHOM_MAY = dbo.MAY.MS_NHOM_MAY 
		ON MAY_NHA_XUONG_TMP.MS_MAY = dbo.MAY.MS_MAY ON  MAY_HE_THONG_TMP.MS_MAY = dbo.MAY.MS_MAY INNER JOIN	
	(SELECT MS_LOAI_MAY FROM dbo.MashjGetNhomLoaiMay(@UserName) AS MashjGetNhomLoaiMay_1) AS NHOM_LOAI_MAY ON 
		dbo.NHOM_MAY.MS_LOAI_MAY = NHOM_LOAI_MAY.MS_LOAI_MAY INNER JOIN LOAI_MAY ON NHOM_LOAI_MAY.MS_LOAI_MAY = LOAI_MAY.MS_LOAI_MAY
		INNER JOIN
	( SELECT DISTINCT MBPCP.MS_MAY, MBPCP.MS_BP_CHIU_PHI, TEN_BP_CHIU_PHI FROM dbo.MAY_BO_PHAN_CHIU_PHI AS MBPCP 
		INNER JOIN (SELECT     MS_MAY, MAX(NGAY_NHAP) AS NGAY_MAX FROM dbo.MAY_BO_PHAN_CHIU_PHI 
						WHERE (NGAY_NHAP <= @NgayHT) 
						GROUP BY MS_MAY) AS MAY_MAX ON MBPCP.MS_MAY = MAY_MAX.MS_MAY AND MBPCP.NGAY_NHAP = MAY_MAX.NGAY_MAX 
		INNER JOIN dbo.BO_PHAN_CHIU_PHI ON MBPCP.MS_BP_CHIU_PHI = dbo.BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI		
		WHERE (MBPCP.MS_BP_CHIU_PHI = @MsBPCPhi OR @MsBPCPhi = -1)
	) AS A ON A.MS_MAY = dbo.MAY.MS_MAY INNER JOIN
	(SELECT MS_BP_CHIU_PHI FROM dbo.MashjGetNhomBPCP(@UserName) AS MashjGetNhomBPCP) AS BPCP ON A.MS_BP_CHIU_PHI = BPCP.MS_BP_CHIU_PHI
	
	WHERE (MAY_HE_THONG_TMP.MS_HE_THONG = @MsHeThong OR @MsHeThong = -1)
	AND (A.MS_BP_CHIU_PHI = @MsBPCPhi OR @MsBPCPhi = -1) 
	AND (dbo.NHOM_MAY.MS_LOAI_MAY = @MsLoaiMay OR @MsLoaiMay = '-1')
	AND (dbo.NHOM_MAY.MS_NHOM_MAY = @NhomMay OR @NhomMay = '-1')
	AND (dbo.MAY.MS_MAY = @MSMay OR @MSMay= '-1')
	AND (dbo.MAY.MS_HIEN_TRANG = 2 or dbo.MAY.MS_HIEN_TRANG = 3)

	INSERT INTO @NLMTMP([MS_MAY],[MS_NHOM_MAY],MS_LOAI_MAY,[MS_HSX],[MS_HIEN_TRANG],[MS_KH],[SO_NAM_KHAU_HAO],[MO_TA],[NHIEM_VU_THIET_BI]
           ,[MODEL],[SERIAL_NUMBER],[NGAY_SX],[NUOC_SX],[NGAY_MUA],[NGAY_BD_BAO_HANH],[NGAY_DUA_VAO_SD]
           ,[SO_THE],[SO_NGAY_LV_TRONG_TUAN],[SO_GIO_LV_TRONG_NGAY],[MS_DVT_RT],[TY_LE_CON_LAI],[MUC_UU_TIEN]
           ,[SO_THANG_BH],[GIA_MUA],[NGOAI_TE],[LUU_Y_SU_DUNG],[Anh_TB],[CHU_KY_HC_TB],[TEN_MAY]
           ,[AN_TOAN],[MS_HO_SO],[TEN_HO_SO],[NGAY_HIEU_LUC_HO_SO],[SO_CT],[TI_GIA_VND]
           ,[TI_GIA_USD],[CHU_KY_HIEU_CHUAN_TB_NGOAI],[CHU_KY_KD_TB],[DON_VI_THOI_GIAN],MS_N_XUONG,MS_HE_THONG,[MS_BP_CHIU_PHI]
           ,[USER_INSERT], [NGAY_INSERT], [USER_UPDATE], [NGAY_UPDATE],
           TEN_N_XUONG, TEN_HE_THONG, TEN_NHOM_MAY, TEN_LOAI_MAY, TEN_BP_CHIU_PHI)
		SELECT DISTINCT dbo.MAY.[MS_MAY],dbo.MAY.[MS_NHOM_MAY],MS_LOAI_MAY,[MS_HSX],[MS_HIEN_TRANG],[MS_KH],[SO_NAM_KHAU_HAO],[MO_TA],[NHIEM_VU_THIET_BI]
           ,[MODEL],[SERIAL_NUMBER],[NGAY_SX],[NUOC_SX],[NGAY_MUA],[NGAY_BD_BAO_HANH],[NGAY_DUA_VAO_SD]
           ,[SO_THE],[SO_NGAY_LV_TRONG_TUAN],[SO_GIO_LV_TRONG_NGAY],[MS_DVT_RT],[TY_LE_CON_LAI],[MUC_UU_TIEN]
           ,[SO_THANG_BH],[GIA_MUA],[NGOAI_TE],[LUU_Y_SU_DUNG],[Anh_TB],[CHU_KY_HC_TB],[TEN_MAY]
           ,[AN_TOAN],[MS_HO_SO],[TEN_HO_SO],[NGAY_HIEU_LUC_HO_SO],[SO_CT],[TI_GIA_VND]
           ,[TI_GIA_USD],[CHU_KY_HIEU_CHUAN_TB_NGOAI],[CHU_KY_KD_TB],[DON_VI_THOI_GIAN]
           ,MS_N_XUONG,MS_HE_THONG,[MS_BP_CHIU_PHI],[USER_INSERT], [NGAY_INSERT], [USER_UPDATE], [NGAY_UPDATE]
           ,TEN_N_XUONG, TEN_HE_THONG, TEN_NHOM_MAY, TEN_LOAI_MAY, TEN_BP_CHIU_PHI
		FROM dbo.MAY INNER JOIN @MAY_TMP B ON dbo.MAY.MS_MAY = B.MS_MAY 
return
END
