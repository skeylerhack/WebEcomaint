IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_KHO') and Object_ID = Object_ID(N'IC_PHU_TUNG'))
BEGIN
		ALTER TABLE IC_PHU_TUNG ADD MS_KHO INT
END