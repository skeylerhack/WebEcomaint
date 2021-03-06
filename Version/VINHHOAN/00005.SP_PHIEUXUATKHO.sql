IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_PHIEUXUATKHO')
   exec('CREATE PROCEDURE [dbo].[SP_PHIEUXUATKHO] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC [dbo].[SP_PHIEUXUATKHO]
	@MS_DH_XUAT_PT NVARCHAR(50),
	@NNgu int
AS
SELECT   a.MS_DH_XUAT_PT,  dbo.IC_KHO.TEN_KHO, A.NGAY, A.GIO, E.DON_VI,A.SO_CHUNG_TU, 										
                      CASE A.MS_DANG_XUAT WHEN 1 THEN 
					  
					  A.MS_PHIEU_BAO_TRI + ' + ' + 
					  C.MS_MAY + ' + ' + TEN_MAY 
					  ELSE CONVERT(NVARCHAR(500), 										
                      B.DANG_XUAT_VIET) END AS MUC_DICH_XUAT,
					  CASE A.MS_DANG_XUAT WHEN 1 THEN A.MS_PHIEU_BAO_TRI ELSE '' END MS_PHIEU_BAO_TRI,
					  CASE A.MS_DANG_XUAT WHEN 1 THEN C.MS_MAY ELSE '' END MS_MAY,
					   CASE A.MS_DANG_XUAT WHEN 1 THEN TEN_MAY ELSE '' END TEN_MAY,
					  CONVERT(NVARCHAR(500),
					  CASE @NNgu WHEN 0 THEN B.DANG_XUAT_VIET WHEN 1 THEN B.DANG_XUAT_ANH ELSE B.DANG_XUAT_HOA END 
					  ) AS DANG_XUAT_VIET,A.MS_DANG_XUAT
				  									
FROM         dbo.IC_DON_HANG_XUAT AS A INNER JOIN										
                      dbo.DANG_XUAT AS B ON A.MS_DANG_XUAT = B.MS_DANG_XUAT LEFT OUTER JOIN										
                      dbo.IC_KHO ON A.MS_KHO = dbo.IC_KHO.MS_KHO LEFT OUTER JOIN										
                      dbo.PHIEU_BAO_TRI AS C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI LEFT OUTER JOIN										
                      dbo.MAY AS D ON C.MS_MAY = D.MS_MAY LEFT OUTER JOIN										
                          (SELECT     MS_CONG_NHAN AS MA, HO + ' ' + TEN AS DON_VI										
                            FROM          dbo.CONG_NHAN										
                            UNION										
                            SELECT     MS_KH, TEN_CONG_TY										
                            FROM         dbo.KHACH_HANG) AS E ON A.NGUOI_NHAN = E.MA	

WHERE MS_DH_XUAT_PT = @MS_DH_XUAT_PT
							
SELECT     dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT, dbo.DON_VI_TINH.TEN_1, 									
                      dbo.IC_DON_HANG_XUAT_VAT_TU.SO_LUONG_CTU, dbo.IC_DON_HANG_XUAT_VAT_TU.SO_LUONG_THUC_XUAT, 									
                      dbo.IC_DON_HANG_XUAT_VAT_TU.GHI_CHU									
FROM         dbo.IC_DON_HANG_XUAT_VAT_TU INNER JOIN									
                      dbo.IC_PHU_TUNG ON dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT INNER JOIN									
                      dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT
WHERE 	dbo.IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT=	@MS_DH_XUAT_PT		