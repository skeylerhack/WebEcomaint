


if not exists(select * from sys.columns 
            where Name = N'MS_LOAI_CV' and Object_ID = Object_ID(N'LOAI_BAO_TRI'))
begin
    ALTER TABLE LOAI_BAO_TRI ADD MS_LOAI_CV SMALLINT
END    
