IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_PT_OLD') and Object_ID = Object_ID(N'IC_PHU_TUNG'))
BEGIN
		ALTER TABLE IC_PHU_TUNG ADD TEN_PT_OLD NVARCHAR(100)
END
