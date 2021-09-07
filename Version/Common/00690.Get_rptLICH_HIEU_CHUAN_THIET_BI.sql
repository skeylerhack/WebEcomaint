IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get_rptLICH_HIEU_CHUAN_THIET_BI')
   exec('CREATE PROCEDURE Get_rptLICH_HIEU_CHUAN_THIET_BI AS BEGIN SET NOCOUNT ON; END')
GO
alter proc [dbo].[Get_rptLICH_HIEU_CHUAN_THIET_BI]
	@MS_MAY nvarchar(30),
	@NNgu nvarchar(30)
	
AS
SELECT ROW_NUMBER() OVER(ORDER BY CHU_KY_HIEU_CHUAN.MS_PT DESC) AS STT, MS_PT ,MS_VI_TRI,CHU_KY_HC_NOI,
		cast(CHU_KY_HC_NGOAI as nvarchar)  + ' ' + case  @NNgu when 0 then TEN_DV_TG when 1 then TEN_DV_TG_ANH when 2 then TEN_DV_TG_HOA end as CHU_KY_HC_NGOAI,
		cast(CHU_KY_KT as nvarchar)  + ' ' + case  @NNgu when 0 then TEN_DV_TG when 1 then TEN_DV_TG_ANH when 2 then TEN_DV_TG_HOA end as CHU_KY_KT,
		cast(CHU_KY_KD as nvarchar) + ' ' + case  @NNgu when 0 then TEN_DV_TG when 1 then TEN_DV_TG_ANH when 2 then TEN_DV_TG_HOA end as CHU_KY_KD,
		GHI_CHU FROM CHU_KY_HIEU_CHUAN join DON_VI_THOI_GIAN on CHU_KY_HIEU_CHUAN.MS_DV_TG = DON_VI_THOI_GIAN.MS_DV_TG
WHERE MS_MAY= @MS_MAY 


