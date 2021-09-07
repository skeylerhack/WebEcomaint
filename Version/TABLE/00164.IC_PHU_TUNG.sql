if not exists(select * from sys.columns 
            where Name = N'GIA_VTPT' and Object_ID = Object_ID(N'IC_PHU_TUNG'))
begin
    ALTER TABLE IC_PHU_TUNG ADD GIA_VTPT float
END    
