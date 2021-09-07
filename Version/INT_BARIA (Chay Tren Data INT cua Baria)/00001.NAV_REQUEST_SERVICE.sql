if not exists(select * from sys.columns 
            where Name = N'ID_PSDV_NHOM' and Object_ID = Object_ID(N'NAV_REQUEST_SERVICE'))
begin
    ALTER TABLE NAV_REQUEST_SERVICE ADD ID_PSDV_NHOM BIGINT
END    


if not exists(select * from sys.columns 
            where Name = N'ID_PSDV_NHOM' and Object_ID = Object_ID(N'NAV_REQUEST_SERVICE_RETURN'))
begin
    ALTER TABLE NAV_REQUEST_SERVICE_RETURN ADD ID_PSDV_NHOM BIGINT
END    

