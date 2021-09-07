
if not exists(select * from sys.columns 
            where Name = N'NGAY_GS_CUOI' and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
begin
    ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD NGAY_GS_CUOI DATETIME NULL 
END    
