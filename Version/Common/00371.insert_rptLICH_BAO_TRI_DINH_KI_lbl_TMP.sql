
ALTER proc [dbo].[insert_rptLICH_BAO_TRI_DINH_KI_lbl_TMP]	
	

@TIEU_DE nvarchar(250),
@MS_MAY nvarchar(250),
@LOAI_MAY nvarchar(250),
@NHOM_MAY nvarchar(250),
@LOAI_BT nvarchar (250),
@NGAY_CUOI nvarchar(250),
@CHU_KI nvarchar(250),
@STT nvarchar(250),
@CONG_VIEC nvarchar(250),
@MS_PHU_TUNG nvarchar(250),
@PART_No nvarchar(250),
@SO_LUONG nvarchar(250),
@DVT nvarchar(250),
@TRANG nvarchar(250),
@TEN_BO_PHAN NVARCHAR(250),
@TM1 NVARCHAR(250),
@TM2 NVARCHAR(250),
@TM3 NVARCHAR(250),
@TM4 NVARCHAR(250),
@TM5 NVARCHAR(250)
AS
INSERT INTO dbo.rptLICH_BAO_TRI_DINH_KI_lbl_TMP (TIEU_DE_ ,
MS_MAY_ 
,LOAI_MAY_,
NHOM_MAY_ ,
LOAI_BT_ ,
NGAY_CUOI_ ,
CHU_KI_,
STT_ ,
CONG_VIEC_ 
,MS_PHU_TUNG_ ,
PART_No_ ,
SO_LUONG_ ,
DVT_ ,
TRANG_,
TEN_BO_PHAN_, TM1, TM2, TM3, TM4, TM5 )
values (
@TIEU_DE,	
@MS_MAY,
@LOAI_MAY ,
@NHOM_MAY ,
@LOAI_BT,
@NGAY_CUOI,
@CHU_KI ,
@STT ,
@CONG_VIEC,
@MS_PHU_TUNG ,
@PART_No ,
@SO_LUONG ,
@DVT ,
@TRANG ,
@TEN_BO_PHAN, @TM1, @TM2, @TM3, @TM4, @TM5

)
