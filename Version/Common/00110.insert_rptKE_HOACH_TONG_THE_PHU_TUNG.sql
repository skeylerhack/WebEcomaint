
ALTER procedure [dbo].[insert_rptKE_HOACH_TONG_THE_PHU_TUNG] 

@TIEU_DE nvarchar(550),
@STT nvarchar(50),
@MS_PT_CTY nvarchar(50),
@MS_PT nvarchar(50),
@TEN_PT nvarchar(50),
@QUY_CACH nvarchar(250),
@DVT nvarchar(50),
@SL_TON nvarchar(50),
@TRANG nvarchar(50)

AS

INSERT INTO dbo.insert_rptKE_HOACH_TONG_THE_PHU_TUNG_TMP
 (
TIEU_DE_, 
STT_,
MS_PT_CTY_, 
MS_PT_, 
TEN_PT_, 
QUY_CACH_,
DVT_, 
SL_TON_, 
TRANG_
 )
values (
@TIEU_DE, 
@STT,
@MS_PT_CTY, 
@MS_PT, 
@TEN_PT, 
@QUY_CACH,
@DVT, 
@SL_TON, 
@TRANG
)
