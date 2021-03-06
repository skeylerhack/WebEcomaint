IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'insert_rptTHONG_TIN_CHUNG_VA_THONG_SO_TB_lbl')
   exec('CREATE PROCEDURE insert_rptTHONG_TIN_CHUNG_VA_THONG_SO_TB_lbl AS BEGIN SET NOCOUNT ON; END')
GO
ALTER proc [dbo].[insert_rptTHONG_TIN_CHUNG_VA_THONG_SO_TB_lbl]	
	
@danhsachthietbiconkhauhao NVARCHAR(150),
@TEN_MAY NVARCHAR (150),
@ngaysudung NVARCHAR(150),
@sonamkhauhao NVARCHAR(150),
@tennhaxuong NVARCHAR(150),
@tenloaimay NVARCHAR(150),
@stt NVARCHAR(50),
@maso NVARCHAR(50),
@sothe NVARCHAR(50),
@tennhommay NVARCHAR(150),
@gtconlai NVARCHAR(150),
@ngayhetkh NVARCHAR(50),
@tiente NVARCHAR(50),
@trang NVARCHAR(50),


@danhsachthietbiconkhauhao_ NVARCHAR(50),
@ngaysudung_ NVARCHAR(150),
@sonamkhauhao_ NVARCHAR(150),
@tennhaxuong_ NVARCHAR(50),
@tenloaimay_ NVARCHAR(50),
@stt_ NVARCHAR(50),
@maso_ NVARCHAR(50),
@sothe_ NVARCHAR(150),
@tennhommay_ NVARCHAR(50),
@gtconlai_ NVARCHAR(50),
@ngayhetkh_ NVARCHAR(50),
@tiente_ NVARCHAR(50),
@trang_ NVARCHAR(150),

@hh NVARCHAR(50),



@tieude NVARCHAR(50),
@coban NVARCHAR(150),
@sudung_ NVARCHAR(150),
@ketoan NVARCHAR(250),
@tthongsochinh_ NVARCHAR(50),
@sott NVARCHAR(50),
@tentt NVARCHAR(50),
@giatri NVARCHAR(50),
@tdonvitinh NVARCHAR(50),
@ghichu NVARCHAR(50),
@t NVARCHAR(50),
@TM1 NVARCHAR(250),
@TM2 NVARCHAR(250),
@TM3 NVARCHAR(250), 
@TM4 NVARCHAR(250), 
@TM5 NVARCHAR(250)
AS
INSERT INTO dbo.rptTHONG_TIN_CHUNG_VA_THONG_SO_TB_lbl (MS_MAY_ ,TEN_MAY , LOAI_MAY_ ,
NHOM_MAY_ ,NHA_CUNG_CAP_ ,MO_TA_ ,KIEU_ ,HANG_SAN_XUAT_ ,NGAY_SX_ ,NUOC_SX_ ,NHIEM_VU_,
NGAY_DUA_VAO_SD_ ,HIEN_TRANG_SU_DUNG_ ,SO_NAM_DA_SD_ ,
MUC_UU_TIEN_ ,NOI_LAP_DAT_ ,BO_PHAN_TRA_PHI_	,
NGAY_BD_BAO_HANH_ ,NGAY_HET_BAO_HANH_ ,SO_NGAY_LAM_TB_	,
SO_GIO_LAM_TB_	,SO_THE_	,PHAN_TRAM_ ,NGAY_MUA_ ,
GIA_MUA_,TIEN_TE_,SO_NAM_KH_ ,NGAY_HET_KH_ ,
TIEU_DE_ ,TT_CO_BAN_,TT_SU_DUNG_,
TT_KE_TOAN_,THONG_SO_CHINH_,STT_,
TEN_THONG_SO_,GIA_TRI_,DVT_ ,GHI_CHU_ ,
TRANG_, TM1,TM2,TM3,TM4,TM5


	
)
values (
		
@danhsachthietbiconkhauhao ,
@TEN_MAY , 
@ngaysudung ,
@sonamkhauhao ,
@tennhaxuong ,
@tenloaimay ,
@stt,
@maso,
@sothe,
@tennhommay ,
@gtconlai,
@ngayhetkh,
@tiente,
@trang ,

@danhsachthietbiconkhauhao_ ,
@ngaysudung_ ,
@sonamkhauhao_ ,
@tennhaxuong_ ,
@tenloaimay_ ,
@stt_,
@maso_,
@sothe_,
@tennhommay_ ,
@gtconlai_,
@ngayhetkh_,
@tiente_,
@trang_ ,
@hh,

@tieude,
@coban ,
@sudung_,
@ketoan ,
@tthongsochinh_,
@sott ,
@tentt,
@giatri,
@tdonvitinh ,
@ghichu ,
@t,
@TM1,
@TM2,
@TM3,
@TM4,
@TM5
)
