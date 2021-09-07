if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI_PT' and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY_PHU_TUNG'))
begin
    ALTER TABLE THOI_GIAN_NGUNG_MAY_PHU_TUNG ADD MS_VI_TRI_PT nvarchar(30)
END   