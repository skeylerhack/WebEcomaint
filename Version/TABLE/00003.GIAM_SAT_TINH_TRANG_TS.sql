
if not exists(select * from sys.columns 
            where Name = N'STT_VAN_DE' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD STT_VAN_DE INT
END    
