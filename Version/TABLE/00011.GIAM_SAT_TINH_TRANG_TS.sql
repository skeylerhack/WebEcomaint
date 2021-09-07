if not exists(select * from sys.columns 
            where Name = N'GHI_CHU' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD GHI_CHU NVARCHAR(MAX)
END    
