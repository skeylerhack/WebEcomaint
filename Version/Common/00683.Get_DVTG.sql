IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get_DVTG')
   exec('CREATE PROCEDURE Get_DVTG AS BEGIN SET NOCOUNT ON; END')
GO
alter proc [dbo].[Get_DVTG]
	@NNgu nvarchar(30)
	
AS

select case  @NNgu when 0 then TEN_DV_TG when 1 then TEN_DV_TG_ANH when 2 then TEN_DV_TG_HOA end from may join DON_VI_THOI_GIAN on may.DON_VI_THOI_GIAN = DON_VI_THOI_GIAN.MS_DV_TG


