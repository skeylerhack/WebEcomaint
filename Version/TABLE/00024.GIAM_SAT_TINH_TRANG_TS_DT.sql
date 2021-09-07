
if not exists(select * from sys.columns 
            where Name = N'STT_VAN_DE' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS_DT'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG_TS_DT ADD STT_VAN_DE INT
END    


if not exists(select * from sys.columns 
            where Name = N'GHI_CHU' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS_DT'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG_TS_DT ADD GHI_CHU NVARCHAR(MAX)
END    