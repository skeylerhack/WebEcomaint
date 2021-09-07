IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_TA') and Object_ID = Object_ID(N'MUC_UU_TIEN'))
BEGIN
		ALTER TABLE MUC_UU_TIEN ADD TEN_TA NVARCHAR(100)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SO_NGAY_PHAI_BD') and Object_ID = Object_ID(N'MUC_UU_TIEN'))
BEGIN
		ALTER TABLE MUC_UU_TIEN ADD SO_NGAY_PHAI_BD INT DEFAULT 0
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SO_NGAY_PHAI_KT') and Object_ID = Object_ID(N'MUC_UU_TIEN'))
BEGIN
		ALTER TABLE MUC_UU_TIEN ADD SO_NGAY_PHAI_KT INT DEFAULT 0
END
