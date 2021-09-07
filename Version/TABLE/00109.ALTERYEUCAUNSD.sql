IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_VI_TRI_PT') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET_BO_PHAN'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET_BO_PHAN ADD  MS_VI_TRI_PT NVARCHAR(30)
END


