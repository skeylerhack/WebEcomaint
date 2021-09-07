
ALTER procedure [dbo].[ins_rptACTION_PLAN] 

@NGAY_IN nvarchar(50),
@TIEU_DE nvarchar(50), 
@MS_MAY nvarchar(50),
@TEN_LOAI_TB nvarchar(50),
@STT nvarchar(50),
@HANG_MUC nvarchar(50),
@CONG_VIEC nvarchar(50),
@WHO nvarchar(50),
@THOI_GIAN nvarchar(50),
@REMARK nvarchar(50),
@TRANG nvarchar(50),
@MS_BO_PHAN nvarchar(50),
@TEN_BO_PHAN nvarchar(50)
AS

INSERT INTO dbo.insert_rptACTION_PLAN_TMP
 (
NGAY_IN_, TIEU_DE_, MS_MAY_, TEN_LOAI_TB_, STT_, HANG_MUC_, CONG_VIEC_, WHO_, THOI_GIAN_, REMARK_, TRANG_,MS_BO_PHAN_,
TEN_BO_PHAN_
 )
values (
@NGAY_IN, 
@TIEU_DE, 
@MS_MAY, 
@TEN_LOAI_TB, 
@STT, 
@HANG_MUC, 
@CONG_VIEC, 
@WHO, 
@THOI_GIAN, 
@REMARK, 
@TRANG,
@MS_BO_PHAN ,
@TEN_BO_PHAN 
)
