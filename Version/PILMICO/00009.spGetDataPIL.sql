
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDataPIL')
   exec('CREATE PROCEDURE spGetDataPIL AS BEGIN SET NOCOUNT ON; END')
GO

--exec spGetDataPIL '100000000283664','NN6sAeAucVMWuqpzEuzWKH2SzAR8'
ALTER PROC [dbo].[spGetDataPIL]
	@item NVARCHAR(max) = '100000000283678',
	@token NVARCHAR(max) = 'xuTODOYrc1scUzH4mVHqLGvk6I6A'
AS 
begin try 
	DECLARE @obj INT
	DECLARE @sUrl VARCHAR(200)
	Declare @json as table(Json_Table nvarchar(max))

	SET @sUrl = 'https://pilmico-test.apigee.net/fusion/v1/item/onhandQuantityDetails?q=InventoryItemId=' + @item
	EXEC sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT

	EXEC sp_OAMethod @obj,'Open',NULL,'GET',@sUrl,false

	DECLARE @sAuthorization NVARCHAR(200)
	set @sAuthorization = 'Bearer ' + @token
	EXEC sp_OAMethod @obj, 'setRequestHeader', null, 'Authorization', @sAuthorization

	EXEC sp_OAMethod @obj,'send'
	
	INSERT into @json (Json_Table) EXEC sp_OAGetProperty @obj, 'responseText'
	--select * from @json
	SELECT [OnhandQuantity] FROM OPENJSON((select * from @json), N'$.items')
	WITH (   
		[OrganizationId] nvarchar(max) N'$.OrganizationId', 
		[OrganizationCode] nvarchar(max) N'$.OrganizationCode',
		[InventoryItemId] nvarchar(max) N'$.InventoryItemId',
		[ItemNumber] nvarchar(max) N'$.ItemNumber',
		[SubinventoryCode] nvarchar(max) N'$.SubinventoryCode',
		[LocatorId] nvarchar(max) N'$.LocatorId',
		[LotNumber] nvarchar(max) N'$.LotNumber',
		[OnhandQuantity] float N'$.OnhandQuantity',
		[SecondaryOnhandQuantity] nvarchar(max) N'$.SecondaryOnhandQuantity',
		[ReceivingQuantity] nvarchar(max) N'$.ReceivingQuantity',
		[SecondaryReceivingQuantity] nvarchar(max) N'$.SecondaryReceivingQuantity',
		[ReservedQuantity] nvarchar(max) N'$.ReservedQuantity',
		[SecondaryReservedQuantity] nvarchar(max) N'$.SecondaryReservedQuantity',
		[InboundQuantity] nvarchar(max) N'$.InboundQuantity',
		[SecondaryInboundQuantity] nvarchar(max) N'$.SecondaryInboundQuantity',
		[ConsignedQuantity] nvarchar(max) N'$.ConsignedQuantity',
		[SecondaryConsignedQuantity] nvarchar(max) N'$.SecondaryConsignedQuantity',
		[OwningOrganizationId] nvarchar(max) N'$.OwningOrganizationId',
		[OwningOrganization] nvarchar(max) N'$.OwningOrganization',
		[SerialNumber] nvarchar(max) N'$.SerialNumber',
		[PrimaryUOMCode] nvarchar(max) N'$.PrimaryUOMCode',
		[SecondaryUOMCode] nvarchar(max) N'$.SecondaryUOMCode'
	)



	--SELECT * FROM OPENJSON((select * from @json), N'$.items')
	--WITH (   
	--	[OrganizationId] nvarchar(max) N'$.OrganizationId', 
	--	[OrganizationCode] nvarchar(max) N'$.OrganizationCode',
	--	[InventoryItemId] nvarchar(max) N'$.InventoryItemId',
	--	[ItemNumber] nvarchar(max) N'$.ItemNumber',
	--	[SubinventoryCode] nvarchar(max) N'$.SubinventoryCode',
	--	[LocatorId] nvarchar(max) N'$.LocatorId',
	--	[LotNumber] nvarchar(max) N'$.LotNumber',
	--	[OnhandQuantity] nvarchar(max) N'$.OnhandQuantity',
	--	[SecondaryOnhandQuantity] nvarchar(max) N'$.SecondaryOnhandQuantity',
	--	[ReceivingQuantity] nvarchar(max) N'$.ReceivingQuantity',
	--	[SecondaryReceivingQuantity] nvarchar(max) N'$.SecondaryReceivingQuantity',
	--	[ReservedQuantity] nvarchar(max) N'$.ReservedQuantity',
	--	[SecondaryReservedQuantity] nvarchar(max) N'$.SecondaryReservedQuantity',
	--	[InboundQuantity] nvarchar(max) N'$.InboundQuantity',
	--	[SecondaryInboundQuantity] nvarchar(max) N'$.SecondaryInboundQuantity',
	--	[ConsignedQuantity] nvarchar(max) N'$.ConsignedQuantity',
	--	[SecondaryConsignedQuantity] nvarchar(max) N'$.SecondaryConsignedQuantity',
	--	[OwningOrganizationId] nvarchar(max) N'$.OwningOrganizationId',
	--	[OwningOrganization] nvarchar(max) N'$.OwningOrganization',
	--	[SerialNumber] nvarchar(max) N'$.SerialNumber',
	--	[PrimaryUOMCode] nvarchar(max) N'$.PrimaryUOMCode',
	--	[SecondaryUOMCode] nvarchar(max) N'$.SecondaryUOMCode'
	--)

	EXEC sp_OADestroy @obj
end try
begin catch
		declare @error int, @message varchar(4000), @xstate int;
        select @error = ERROR_NUMBER(),
                 @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
		raiserror ('usp_my_procedure_name: %d: %s', 16, 1, @error, @message) ;
end catch    
