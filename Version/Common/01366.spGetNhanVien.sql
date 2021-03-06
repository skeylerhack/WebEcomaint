IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetNhanVien')
   exec('CREATE PROCEDURE spGetNhanVien AS BEGIN SET NOCOUNT ON; END')
GO




ALTER procedure spGetNhanVien
	@UserName NVARCHAR(50) = 'admin',
	@MsDVi NVARCHAR(100) = '-1',
	@MsPhongBan int = -1,
	@MsTo int = -1,
	@NNgu int = 0
AS

SELECT MS_CONG_NHAN,HOTEN,TEN_DON_VI,[TEN_PHONG_BAN],TEN_TO, MS_TO,MS_PHONG_BAN,MS_DON_VI,HO,TEN  FROM dbo.MGetCongNhanToPhongBan(@UserName ,'-1',@MsDVi,@MsPhongBan,@MsTo,@NNgu)



