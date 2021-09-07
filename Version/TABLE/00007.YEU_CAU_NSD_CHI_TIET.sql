if not exists(select * from sys.columns 
            where Name = N'MS_NGUYEN_NHAN' and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
begin
    ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD MS_NGUYEN_NHAN INT
END    

