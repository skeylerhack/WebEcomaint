
if not exists(select * from sys.columns 
            where Name = N'NO_ACTIVE' and Object_ID = Object_ID(N'IC_PHU_TUNG'))
begin
    ALTER TABLE IC_PHU_TUNG ADD NO_ACTIVE BIT DEFAULT(0)
END    
