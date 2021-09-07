
if not exists(select * from sys.columns 
            where Name = N'MS_TT_CT' and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
begin
    ALTER TABLE PHIEU_BAO_TRI ADD MS_TT_CT INT
    

END    




