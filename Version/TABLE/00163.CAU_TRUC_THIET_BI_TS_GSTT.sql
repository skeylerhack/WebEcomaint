if NOT exists (select 1 from sys.columns where name = 'MS_UU_TIEN' and object_name(object_id) = 'CAU_TRUC_THIET_BI_TS_GSTT') 
BEGIN
	ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT  ADD MS_UU_TIEN INT;
END
