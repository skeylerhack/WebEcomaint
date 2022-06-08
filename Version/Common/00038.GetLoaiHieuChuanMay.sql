IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetLoaiHieuChuanMay')
   exec('CREATE PROCEDURE [dbo].[GetLoaiHieuChuanMay] AS BEGIN SET NOCOUNT ON; END')
GO

--exec GetLoaiHieuChuanMay
ALTER procedure [dbo].[GetLoaiHieuChuanMay]
AS
SELECT [MS_LOAI_HIEU_CHUAN]
      ,[TEN_LOAI_HIEU_CHUAN]      
  FROM [LOAI_HIEU_CHUAN_MAY] ORDER BY [MS_LOAI_HIEU_CHUAN]
