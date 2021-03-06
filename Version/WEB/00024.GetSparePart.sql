
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSparePart')
   exec('CREATE PROCEDURE GetSparePart AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROC GetSparePart
	@username NVARCHAR(50)
AS
BEGIN
	SELECT  A.MS_PT ID, MS_PT_NCC [PartNo], MS_PT_CTY [ItemCode], TEN_PT [Name], QUY_CACH Specification, ANH_PT [Image], A.MS_LOAI_VT TypeOfMaterialID, DVT UnitOfCalculationID, DUNG_CU_DO IsMeasurementInstrument, MS_CACH_DAT_HANG PurchaseMethodID, SO_NGAY_DAT_MUA_HANG Leadtime, TON_TOI_THIEU MinInventory, MS_KH CustomerID, SL_DA_DAT_CHUA_MUA QuantityOrdered, MS_HSX ProducerID, 
                         MS_VI_TRI LocationID, MS_CLASS ClassID, TON_KHO_MAX MaxInventory, HANG_NGOAI IsForeign,  SERVICE_ID ServiceID, THEO_KHO IsMultipleWarehouse, NO_ACTIVE, USER_INSERT_PT CreatedBy, NGAY_INSERT_PT DateCreated, USER_UPDATE_PT ModifiedBy, NGAY_UPDATE_PT DateModified, ACTIVE_PT Active, KY_PB Periodic, TEN_PT_ANH NameOfEng, 
                         TEN_PT_HOA NameOfChina, VAT_TU_PT IsMaterial, MS_KHO WarehouseID, TEN_PT_OLD OldName
 FROM IC_PHU_TUNG A INNER JOIN LOAI_VT B ON A.MS_LOAI_VT = B.MS_LOAI_VT 
	INNER JOIN (SELECT DISTINCT T1.MS_PT FROM IC_PHU_TUNG_LOAI_PHU_TUNG AS T1 
	INNER JOIN NHOM_LOAI_PHU_TUNG AS T2 ON T1.MS_LOAI_PT = T2.MS_LOAI_PT 
	INNER JOIN (SELECT GROUP_ID FROM USERS WHERE USERNAME = @username ) AS T3 ON T2.GROUP_ID = T3.GROUP_ID ) AS D ON A.MS_PT = D.MS_PT 
END


