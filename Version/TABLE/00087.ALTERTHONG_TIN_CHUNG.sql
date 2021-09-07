IF not EXISTS(select * from sys.columns 
            where Name IN (N'MUC_UU_TIEN') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD  MUC_UU_TIEN BIT
END
