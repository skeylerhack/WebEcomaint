IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AddDonhangNhapTaiChe')
exec('CREATE PROCEDURE AddDonhangNhapTaiChe AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC [dbo].[AddDonhangNhapTaiChe]
    @MS_DH_XUAT_PT nvarchar(14) ='PX-2011-0009',
    @MS_DH_NHAP_PT nvarchar(14) ='PN-2011-0008',
    @SBT NVARCHAR(200) ='btTAISDadmin'
AS
    BEGIN
	CREATE TABLE #TEMPT_VTTC (
		[MS_DH_XUAT_PT] [nvarchar] (14) ,
		[MS_DH_NHAP_PT] [nvarchar] (14) ,
		[MS_PT] [nvarchar] (30) ,
		[SO_LUONG_THUC_XUAT] [float] NULL,
		[SL_TRA] [float] NULL,
		[DON_GIA] [float] NULL,
		[DG_TAICHE] [float] NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPT_VTTC SELECT MS_DH_XUAT_PT, MS_DH_NHAP_PT, MS_PT, SO_LUONG_THUC_XUAT, SL_TRA,
       DON_GIA, DG_TAICHE FROM ' + @SBT
EXEC (@sSql)

--set @sSql = 'DROP TABLE ' + @SBT
--EXEC (@sSql)
        INSERT  INTO IC_DON_HANG_NHAP ( MS_DH_NHAP_PT, SO_PHIEU_XN, GIO, NGAY,
                                        MS_KHO, MS_DANG_NHAP, NGUOI_NHAP,
                                        NGAY_CHUNG_TU, SO_CHUNG_TU, GHI_CHU,
                                        LOCK, THU_KHO, CAN_CU, THU_KHO_KY,
                                        NGUOI_LAP, MS_DHX, NGAY_TD,
                                        MS_DH_XUAT_PT)
                SELECT DISTINCT
                        @MS_DH_NHAP_PT, @MS_DH_NHAP_PT,NGAY,GIO, MS_KHO,
                        10, NGUOI_NHAN, NGAY_CHUNG_TU, SO_CHUNG_TU, GHI_CHU, 1,
                        THU_KHO, CAN_CU, THU_KHO_KY, NGUOI_LAP, MS_DH_XUAT_PT,
                        GETDATE(), MS_DH_XUAT_PT
                FROM    IC_DON_HANG_XUAT
                WHERE   MS_DH_XUAT_PT = @MS_DH_XUAT_PT
			

        DECLARE @DATATMP TABLE
            (
              MS_DH_NHAP_PT NVARCHAR(30) ,
              MS_PT NVARCHAR(30) ,
              SO_LUONG_CTU FLOAT ,
              SL_THUC_NHAP FLOAT ,
              DON_GIA FLOAT ,
              NGOAI_TE NVARCHAR(30) ,
              TY_GIA FLOAT ,
              TY_GIA_USD FLOAT ,
              MS_VT_NCC NVARCHAR(50) ,
              BAO_HANH_DEN_NGAY DATETIME ,
              XUAT_XU NVARCHAR(50) ,
              THANH_TIEN FLOAT ,
              GHI_CHU NVARCHAR(255) ,
              MS_PT_CT NVARCHAR(50) ,
              TEN_PT_CT NVARCHAR(255) ,
              Tax FLOAT ,
              ID FLOAT ,
              MS_CHI_TIET_DH NVARCHAR(50) ,
              MS_DH_NHAP_PT_GOC NVARCHAR(14) ,
              ID_GOC FLOAT ,
              DON_GIA_GOC FLOAT ,
              TONG_CP_NHAP_KHAU FLOAT,
			  MS_VI_TRI INT
            )
        INSERT  INTO @DATATMP ( MS_DH_NHAP_PT, MS_PT, SO_LUONG_CTU,
                                SL_THUC_NHAP, DON_GIA, NGOAI_TE, TY_GIA,
                                TY_GIA_USD, MS_VT_NCC, BAO_HANH_DEN_NGAY,
                                XUAT_XU, THANH_TIEN, GHI_CHU, MS_PT_CT,
                                TEN_PT_CT, Tax, ID, MS_CHI_TIET_DH,
                                MS_DH_NHAP_PT_GOC, ID_GOC, DON_GIA_GOC,
                                TONG_CP_NHAP_KHAU,MS_VI_TRI )
                SELECT DISTINCT
                        @MS_DH_NHAP_PT, XVT.MS_PT,
                        VTTC.SO_LUONG_THUC_XUAT - ISNULL(VTTC.SL_TRA,0)  AS SO_LUONG_CTU,
                        VTTC.SO_LUONG_THUC_XUAT - ISNULL(VTTC.SL_TRA,0) AS SL_THUC_NHAP,
                        ROUND(CASE ISNULL(VTTC.DON_GIA,0) WHEN 0 THEN VTTC.DG_TAICHE   ELSE VTTC.DON_GIA - VTTC.DG_TAICHE END ,2)AS DON_GIA, NVT.NGOAI_TE,
                        AVG(NVT.TY_GIA) AS TY_GIA,
                        AVG(NVT.TY_GIA_USD) AS TY_GIA_USD, NVT.MS_VT_NCC,
                        NVT.BAO_HANH_DEN_NGAY, NVT.XUAT_XU,
                        ROUND((VTTC.SO_LUONG_THUC_XUAT - ISNULL(VTTC.SL_TRA,0)) * CASE ISNULL(VTTC.DON_GIA,0) WHEN 0 THEN VTTC.DG_TAICHE   ELSE VTTC.DON_GIA - VTTC.DG_TAICHE END,2) AS THANH_TIEN,
                        XVT.GHI_CHU, XVT.MS_PT_CT, XVT.TEN_PT_CT, AVG(NVT.TAX),
                        ROW_NUMBER() OVER ( ORDER BY @MS_DH_NHAP_PT ) AS ID,
                        NVT.MS_CHI_TIET_DH, NVT.MS_DH_NHAP_PT_GOC, NVT.ID_GOC,
                        NVT.DON_GIA_GOC AS DON_GIA_GOC,
                        ISNULL(XVT.CHI_PHI, 0) AS TONG_CP_NHAP_KHAU,
						XCT.MS_VI_TRI
                FROM    dbo.IC_DON_HANG_XUAT_VAT_TU AS XVT 
                        INNER JOIN dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS XCT ON XVT.MS_DH_XUAT_PT = XCT.MS_DH_XUAT_PT
                                                              AND XVT.MS_PT = XCT.MS_PT
                        INNER JOIN dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON XCT.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT
                                                              AND XCT.MS_PT = NVT.MS_PT
                                                              AND XCT.ID_XUAT = NVT.ID
						INNER JOIN #TEMPT_VTTC VTTC ON VTTC.MS_DH_NHAP_PT = XCT.MS_DH_NHAP_PT AND VTTC.MS_PT = XCT.MS_PT 
                WHERE   ( XVT.MS_DH_XUAT_PT = @MS_DH_XUAT_PT )

                GROUP BY XVT.MS_PT, NVT.NGOAI_TE, NVT.MS_VT_NCC,
                        NVT.BAO_HANH_DEN_NGAY, NVT.XUAT_XU, XVT.GHI_CHU,
                        XVT.MS_PT_CT, XVT.TEN_PT_CT, NVT.ID,
                        NVT.MS_CHI_TIET_DH, NVT.MS_DH_NHAP_PT_GOC, NVT.ID_GOC,
                        CHI_PHI,VTTC.SO_LUONG_THUC_XUAT,VTTC.SL_TRA,VTTC.DON_GIA,VTTC.DG_TAICHE,NVT.DON_GIA_GOC,XCT.MS_VI_TRI
        INSERT  INTO IC_DON_HANG_NHAP_VAT_TU ( MS_DH_NHAP_PT, MS_PT,
                                               SO_LUONG_CTU, SL_THUC_NHAP,
                                               DON_GIA, NGOAI_TE, TY_GIA,
                                               TY_GIA_USD, MS_VT_NCC,
                                               BAO_HANH_DEN_NGAY, XUAT_XU,
                                               THANH_TIEN, GHI_CHU, MS_PT_CT,
                                               TEN_PT_CT, TAX, ID,
                                               MS_CHI_TIET_DH,
                                               MS_DH_NHAP_PT_GOC, ID_GOC,
                                               DON_GIA_GOC,
                                               TONG_CP_NHAP_KHAU_VT )
                SELECT  MS_DH_NHAP_PT, MS_PT, SO_LUONG_CTU, SL_THUC_NHAP,
                        DON_GIA, NGOAI_TE, TY_GIA, TY_GIA_USD, MS_VT_NCC,
                        BAO_HANH_DEN_NGAY, XUAT_XU,
                        THANH_TIEN,GHI_CHU, MS_PT_CT,
                        TEN_PT_CT, Tax, ID, MS_CHI_TIET_DH, MS_DH_NHAP_PT_GOC,
                        ID_GOC, DON_GIA,TONG_CP_NHAP_KHAU
                FROM    @DATATMP
        INSERT  INTO IC_DON_HANG_NHAP_VAT_TU_CHI_TIET ( MS_DH_NHAP_PT, MS_PT,
                                                        MS_VI_TRI, SL_VT, ID )
                SELECT  MS_DH_NHAP_PT, MS_PT,MS_VI_TRI,
                        SL_THUC_NHAP AS SL_VT, ID
                FROM    @DATATMP 
    END


	