
ALTER proc [dbo].[insert_rptLICH_HIEU_CHUAN_THIET_BI]	
@TIEU_DE nvarchar(150),
@MS_MAY nvarchar(150),
@LOAI_MAY nvarchar(150),
@NHOM_MAY nvarchar(150),
@H_C nvarchar(150),
@CHU_KI_HC nvarchar(50),
@NGAY nvarchar(50),
@NGAY_GAN_NHAT nvarchar(50),
@NGAY_TIEP_THEO nvarchar(50),
@HIEU_CHUAN_DHD_ nvarchar(50),
@STT nvarchar(50),
@DHD nvarchar(50),
@VI_TRI_ nvarchar(50),
@CHU_KI_NOI nvarchar(50),
@NGAY_HC_CUOI nvarchar(50),
@CHU_KI_NGOAI nvarchar(50),
@TRANG nvarcHar(50),
@GHI_CHU NVARCHAR(30),
@CHU_KI_KD nvarchar(50),
@CHU_KI_KT nvarchar(50),
@CHU_KI_HC_NGOAI nvarchar(100)
AS
INSERT INTO dbo.rptLICH_HIEU_CHUAN_THIET_BI_lbl_TMP (TIEU_DE_,MS_MAY_,LOAI_MAY_ 
,NHOM_MAY_ ,HIEU_CHUAN_TB_ ,CHU_KI_HC_ ,NGAY_ ,NGAY_GAN_NHAT_ ,NGAY_TIEP_THEO_ ,HIEU_CHUAN_DHD_ ,
STT_ ,DHD_ ,VI_TRI ,CHU_KI_NOI_ ,NGAY_HC_CUOI_ ,CHU_KI_NGOAI_ ,TRANG_,GHI_CHU,CHU_KI_KT_,CHU_KI_KD_, CHU_KI_HC_NGOAI
 )
values (
@TIEU_DE ,
@MS_MAY ,
@LOAI_MAY,
@NHOM_MAY ,
@H_C ,
@CHU_KI_HC,
@NGAY ,
@NGAY_GAN_NHAT ,
@NGAY_TIEP_THEO,
@HIEU_CHUAN_DHD_,
@STT,
@DHD ,
@VI_TRI_ ,
@CHU_KI_NOI,
@NGAY_HC_CUOI ,
@CHU_KI_NGOAI ,
@TRANG,
@GHI_CHU,
@CHU_KI_KD ,
@CHU_KI_KT,
@CHU_KI_HC_NGOAI
)
