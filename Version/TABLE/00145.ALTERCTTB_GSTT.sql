IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_UU_TIEN') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD MS_UU_TIEN INT
END
