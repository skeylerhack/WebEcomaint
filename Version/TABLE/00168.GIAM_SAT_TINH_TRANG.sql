if not exists(select * from sys.columns 
            where Name = N'TONG_GIO' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG ADD TONG_GIO float
END    

if not exists(select * from sys.columns 
            where Name = N'R' and Object_ID = Object_ID(N'DON_VI_THOI_GIAN'))
begin
    ALTER TABLE DON_VI_THOI_GIAN ADD [R] INT
END    

if not exists(select * from sys.columns 
            where Name = N'G' and Object_ID = Object_ID(N'DON_VI_THOI_GIAN'))
begin
    ALTER TABLE DON_VI_THOI_GIAN ADD [G] INT
END    

if not exists(select * from sys.columns 
            where Name = N'B' and Object_ID = Object_ID(N'DON_VI_THOI_GIAN'))
begin
    ALTER TABLE DON_VI_THOI_GIAN ADD [B] INT
END    
