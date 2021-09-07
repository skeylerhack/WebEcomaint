IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get_BCLSTB_Antoan')
   exec('CREATE PROCEDURE Get_BCLSTB_Antoan AS BEGIN SET NOCOUNT ON; END')
GO
-- Get_BCLSTB_Antoan '01/01/2015','01/11/2016','-1',-1,'-1','admin',0
ALTER proc [dbo].[Get_BCLSTB_Antoan]
	@NgayBD DATETIME,
	@NgayKT DATETIME ,
	@MsNXuong nvarchar(50) ,
	@NHeThong int ,
	@MsLoaiMay nvarchar(20),
	@UserName NVARCHAR(255) ,
	@NNGU INT 
as

SELECT * INTO #MAY FROM dbo.MGetMayUserNgay(@NgayKT,@UserName,'-1',-1,-1,'-1','-1', '-1',@NNGU)


SELECT  dbo.#MAY.MS_MAY + ' - '+ dbo.#MAY.TEN_MAY as THIET_BI, dbo.PHIEU_BAO_TRI.NGAY_BD_KH, dbo.PHIEU_BAO_TRI_CONG_VIEC.MS_PHIEU_BAO_TRI, dbo.CONG_VIEC.MO_TA_CV, dbo.PHIEU_BAO_TRI.TT_SAU_BT, dbo.LOAI_BAO_TRI.TEN_LOAI_BT, case dbo.PHIEU_BAO_TRI_CONG_VIEC.STT_SERVICE when NULL then '' when 1 then 'x' end as STT_SERVICE
FROM  #MAY INNER JOIN
         dbo.PHIEU_BAO_TRI ON dbo.#MAY.MS_MAY = dbo.PHIEU_BAO_TRI.MS_MAY INNER JOIN
         dbo.PHIEU_BAO_TRI_CONG_VIEC ON dbo.PHIEU_BAO_TRI.MS_PHIEU_BAO_TRI = dbo.PHIEU_BAO_TRI_CONG_VIEC.MS_PHIEU_BAO_TRI INNER JOIN
         dbo.LOAI_BAO_TRI ON dbo.PHIEU_BAO_TRI.MS_LOAI_BT = dbo.LOAI_BAO_TRI.MS_LOAI_BT INNER JOIN
         dbo.CONG_VIEC ON dbo.PHIEU_BAO_TRI_CONG_VIEC.MS_CV = dbo.CONG_VIEC.MS_CV
WHERE (dbo.CONG_VIEC.AN_TOAN = 1) and (MS_N_XUONG = @MsNXuong or @MsNXuong = '-1') and (#MAY.MS_LOAI_MAY = @MsLoaiMay or @MsLoaiMay = '-1') and PHIEU_BAO_TRI.TINH_TRANG_PBT > 2
ORDER BY dbo.CONG_VIEC.MO_TA_CV DESC