IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_NCC') and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG'))
BEGIN
		ALTER TABLE DE_XUAT_MUA_HANG ADD MS_NCC NVARCHAR(250) NULL
END


