
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetTypeOfMaintenanceByDevice')
   exec('CREATE PROCEDURE GetTypeOfMaintenanceByDevice AS BEGIN SET NOCOUNT ON; END')
GO

--GetTypeOfMaintenanceByDevice '10-05-CVM-002-00'
ALTER proc GetTypeOfMaintenanceByDevice
	@deviceID NVARCHAR(30)
AS
   
	SELECT LOAI_BAO_TRI.MS_LOAI_BT ID,TEN_LOAI_BT  [Name], THU_TU [Index], MS_HT_BT MaintenanceFormID, LOAI_BAO_TRI.GHI_CHU Note,HU_HONG Breakdown,MS_LOAI_CV TypeOfWorkID 
	FROM         LOAI_BAO_TRI INNER JOIN
	                      MAY_LOAI_BTPN ON LOAI_BAO_TRI.MS_LOAI_BT = MAY_LOAI_BTPN.MS_LOAI_BT
	WHERE     (MAY_LOAI_BTPN.MS_MAY = @deviceID)

UNION

	SELECT   LOAI_BAO_TRI.MS_LOAI_BT ID,TEN_LOAI_BT  [Name], THU_TU [Index], MS_HT_BT MaintenanceFormID, LOAI_BAO_TRI.GHI_CHU Note,HU_HONG Breakdown,MS_LOAI_CV TypeOfWorkID 
	FROM         LOAI_BAO_TRI
	WHERE     MS_HT_BT IN
	                          (SELECT     MS_HT_BT
	                            FROM          HINH_THUC_BAO_TRI
	                            WHERE      PHONG_NGUA = 0)

ORDER BY TEN_LOAI_BT
