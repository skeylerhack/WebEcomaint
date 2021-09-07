if not exists(select * from sys.columns 
            where Name = N'GIO_CHAY_MAY' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG ADD GIO_CHAY_MAY FLOAT
END   


if not exists(select * from sys.columns 
            where Name = N'NHAN_XET' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG ADD NHAN_XET NVARCHAR(255)
END   



if not exists(select * from sys.columns 
            where Name = N'USERNAME' and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG'))
begin
    ALTER TABLE GIAM_SAT_TINH_TRANG ADD USERNAME NVARCHAR(255)
END   

