

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDieuDoNhom')
   exec('CREATE PROCEDURE spGetDieuDoNhom AS BEGIN SET NOCOUNT ON; END')
GO



ALTER PROC [dbo].[spGetDieuDoNhom]

AS
SELECT        ID_NHOM_DD, TEN_NHOM, TEN_NHOM_ANH, TEN_NHOM_HOA, GHI_CHU
FROM            dbo.DIEU_DO_NHOM
ORDER BY TEN_NHOM