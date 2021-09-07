USE master
------------EXEC sp_configure 'Ole Automation Procedures';
------------go

------------sp_configure 'show advanced options', 1;
------------GO
------------RECONFIGURE;
------------GO
------------sp_configure 'Ole Automation Procedures', 1;
------------GO
------------RECONFIGURE;
------------GO





DECLARE	@item NVARCHAR(max) = '-1'
 
begin try 
	DECLARE @obj INT
	DECLARE @sUrl VARCHAR(200)
	Declare @json as table(Json_Table nvarchar(max))

	SET @sUrl = 'http://10.39.244.220/Api/api/DuLieuKhoiTao/GetVatTu?BarCode=' + @item
	SET @sUrl = 'http://localhost:41218/api/Items/ApiGetPhuTung/AIC-AC-001'
	EXEC sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT

	EXEC sp_OAMethod @obj,'Open',NULL,'GET',@sUrl,false

	EXEC sp_OAMethod @obj,'send'
	
	INSERT into @json (Json_Table) EXEC sp_OAGetProperty @obj, 'responseText'
	select * from @json

	--SELECT * FROM OPENJSON((select * from @json), N'$.items')
	--WITH (   
	--	BarCode nvarchar(max) N'$.BarCode', 
	--	ItemName nvarchar(max) N'$.ItemName',
	--	UoM nvarchar(max) N'$.UoM'
	--)


	SELECT * FROM OPENJSON((select * from @json), N'$.items')
	WITH (   
		MS_PT nvarchar(max) N'$.MS_PT', 
		TEN_PT nvarchar(max) N'$.TEN_PT',
		QUY_CACH nvarchar(max) N'$.QUY_CACH'
	)

	--SELECT * FROM OPENJSON((select * from @json))
	--WITH (   
	--	mS_PT nvarchar(max) N'$.MS_PT', 
	--	teN_PT nvarchar(max) N'$.teN_PT',
	--	mS_KHO nvarchar(max) N'$.mS_KHO'
	--)

	--Select company_name,json_extract(products,'$[1].name') product_name from table where json_extract(products,'$[1].pending')='false' ;


	EXEC sp_OADestroy @obj


	--SELECT * FROM #tmp
end try
begin catch
		declare @error int, @message varchar(4000), @xstate int;
        select @error = ERROR_NUMBER(),
                 @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
		raiserror ('usp_my_procedure_name: %d: %s', 16, 1, @error, @message) ;
end catch    


