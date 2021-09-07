IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get_CA')
   exec('CREATE PROCEDURE Get_CA AS BEGIN SET NOCOUNT ON; END')
GO



ALTER proc [dbo].[Get_CA]
	@NNGU nvarchar(5)
AS

select STT, case @NNGU when 0 then CA when 1 then isnull(ca_anh,CA) end as CA, TU_GIO,DEN_GIO from CA