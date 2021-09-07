
if not exists(select * from sys.columns 
            where Name = N'TUOI_THO' and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_PHU_TUNG'))
begin
    ALTER TABLE CAU_TRUC_THIET_BI_PHU_TUNG ADD  TUOI_THO  int
END    

GO
if not exists(select * from sys.columns 
            where Name = N'HIEU_LUC' and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI'))
begin
    ALTER TABLE CAU_TRUC_THIET_BI ADD  HIEU_LUC  BIT DEFAULT(1);
END    
GO
UPDATE CAU_TRUC_THIET_BI  SET HIEU_LUC  = 1 WHERE HIEU_LUC IS NULL



