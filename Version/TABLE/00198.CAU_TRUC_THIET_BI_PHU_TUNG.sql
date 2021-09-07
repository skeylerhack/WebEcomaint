if not exists(select * from sys.columns 
           where Name = N'TUOI_THO' and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_PHU_TUNG'))
begin
   ALTER TABLE CAU_TRUC_THIET_BI_PHU_TUNG ADD TUOI_THO INT DEFAULT 0
END    
