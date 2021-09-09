IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spPhanBoLaiBaria')
   exec('CREATE PROCEDURE spPhanBoLaiBaria AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spPhanBoLaiBaria 'WO-201511000008' 
ALTER PROC spPhanBoLaiBaria
	@MsPBT NVARCHAR(50)
AS


DELETE FROM SYN_TB_ALLOCATION_VTPT_FOR_PBT WHERE   MS_PHIEU_BT = @MsPBT 

DELETE FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO WHERE MS_PHIEU_BAO_TRI = @MsPBT

DELETE FROM IC_DON_HANG_XUAT_VAT_TU_CHI_TIET WHERE MS_DH_XUAT_PT IN(SELECT MS_DH_XUAT_PT FROM IC_DON_HANG_XUAT WHERE MS_PHIEU_BAO_TRI = @MsPBT)

DELETE FROM IC_DON_HANG_XUAT_VAT_TU WHERE MS_DH_XUAT_PT IN(SELECT MS_DH_XUAT_PT FROM IC_DON_HANG_XUAT WHERE MS_PHIEU_BAO_TRI = @MsPBT)

DELETE FROM IC_DON_HANG_XUAT WHERE MS_PHIEU_BAO_TRI = @MsPBT 

UPDATE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET SET SL_TT = NULL WHERE MS_PHIEU_BAO_TRI = @MsPBT

UPDATE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG SET SL_TT = NULL WHERE MS_PHIEU_BAO_TRI = @MsPBT