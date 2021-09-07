
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MS_VI_TRI_PT') and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY_PHU_TUNG'))
BEGIN
ALTER TABLE THOI_GIAN_NGUNG_MAY_PHU_TUNG ADD MS_VI_TRI_PT nvarchar(50) NULL
END            

