IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetLoaiBaoTriHinhThuc')
   exec('CREATE PROCEDURE spGetLoaiBaoTriHinhThuc AS BEGIN SET NOCOUNT ON; END')
GO
-----------------

ALTER proc [dbo].[spGetLoaiBaoTriHinhThuc]
@MS_MAY NVARCHAR(30)
AS

	SELECT     LOAI_BAO_TRI.MS_LOAI_BT, LOAI_BAO_TRI.TEN_LOAI_BT, 0 AS HU_HONG, 1 AS PHONG_NGUA
	FROM         LOAI_BAO_TRI INNER JOIN
	                      MAY_LOAI_BTPN ON LOAI_BAO_TRI.MS_LOAI_BT = MAY_LOAI_BTPN.MS_LOAI_BT
	                     
	WHERE     (MAY_LOAI_BTPN.MS_MAY = @MS_MAY)

UNION

	SELECT     MS_LOAI_BT, TEN_LOAI_BT,HU_HONG, 0 AS PHONG_NGUA
	FROM         LOAI_BAO_TRI
	WHERE     MS_HT_BT IN
	                          (SELECT     MS_HT_BT
	                            FROM          HINH_THUC_BAO_TRI
	                            WHERE      PHONG_NGUA = 0)

ORDER BY TEN_LOAI_BT
