IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spDieuDoXoa')
   exec('CREATE PROCEDURE spDieuDoXoa AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC spDieuDoXoa
	@ID_DD BIGINT = 2
AS

--Phieu bao tri
UPDATE PHIEU_BAO_TRI SET NGAY_BD_KH = NGAY_BD_KH_GOC, NGAY_KT_KH = NGAY_KT_KH_GOC
FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
WHERE  ID_DD = @ID_DD

UPDATE PHIEU_BAO_TRI SET NGAY_BD_KH_GOC = NULL, NGAY_KT_KH_GOC = NULL
FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
WHERE ID_DD = @ID_DD

UPDATE PHIEU_BAO_TRI_CONG_VIEC SET ID_DD = NULL,DD_SN = NULL,DD_NGAY = NULL WHERE ID_DD = @ID_DD


-- Ke hoach tong the
UPDATE KE_HOACH_TONG_THE SET NGAY = NGAY_GOC, NGAY_DK_HT = NGAY_DK_HT_GOC
FROM KE_HOACH_TONG_THE T1 INNER JOIN KE_HOACH_TONG_CONG_VIEC T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID
WHERE  ID_DD = @ID_DD

UPDATE KE_HOACH_TONG_THE SET NGAY_GOC = NULL, NGAY_DK_HT_GOC = NULL
FROM KE_HOACH_TONG_THE T1 INNER JOIN KE_HOACH_TONG_CONG_VIEC T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID
WHERE  ID_DD = @ID_DD

UPDATE KE_HOACH_TONG_CONG_VIEC SET  ID_DD = NULL,DD_SN = NULL,DD_NGAY = NULL WHERE ID_DD = @ID_DD


-- ke hoach van phong
UPDATE KE_HOACH_THUC_HIEN SET NGAY = NGAY_GOC,THOI_HAN = THOI_HAN_GOC,   ID_DD = NULL,DD_SN = NULL,DD_NGAY = NULL WHERE ID_DD = @ID_DD

UPDATE KE_HOACH_THUC_HIEN SET NGAY_GOC = NULL, THOI_HAN_GOC = NULL WHERE ID_DD = @ID_DD


-- Giam sat TT
UPDATE GIAM_SAT_TINH_TRANG SET NGAY_KT = NGAY_KT 
FROM GIAM_SAT_TINH_TRANG T1 INNER JOIN GIAM_SAT_TINH_TRANG_TS T2 ON T1.STT = T2.STT
WHERE ID_DD = @ID_DD

UPDATE GIAM_SAT_TINH_TRANG_TS SET ID_DD = NULL,DD_SN = NULL,DD_NGAY = NULL WHERE ID_DD = @ID_DD




DELETE DIEU_DO_NGAY WHERE ID_DD = @ID_DD
DELETE DIEU_DO_BD WHERE ID_DD = @ID_DD
DELETE DIEU_DO_PBT WHERE ID_DD = @ID_DD
DELETE DIEU_DO_KHTT WHERE ID_DD = @ID_DD
DELETE DIEU_DO_GSTT WHERE ID_DD = @ID_DD
DELETE DIEU_DO_CVVP WHERE ID_DD = @ID_DD

DELETE DIEU_DO WHERE ID_DD = @ID_DD

exec spResetIntity 'DIEU_DO_PBT','ID_DD_PBT'
exec spResetIntity 'DIEU_DO_KHTT','ID_DD_KHTT'
exec spResetIntity 'DIEU_DO_GSTT','ID_DD_GSTT'
exec spResetIntity 'DIEU_DO_CVVP','ID_DD_CVVP'
exec spResetIntity 'DIEU_DO','ID_DD'
