
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThongtinthietbi' AND KEYWORD =N'lblfrmThongtinthietbiAnh') UPDATE LANGUAGES SET VIETNAM=N'Tên bộ phận (tiếng Anh)', ENGLISH=N'Part name (English)', VIETNAM_OR=N'Tên bộ phận (tiếng Anh)', ENGLISH_OR=N'Part name (English)' WHERE FORM=N'frmThongtinthietbi' AND KEYWORD=N'lblfrmThongtinthietbiAnh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThongtinthietbi',N'lblfrmThongtinthietbiAnh',N'Tên bộ phận (tiếng Anh)',N'Part name (English)',N'Tên bộ phận (tiếng Anh)',N'Part name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThongtinthietbi' AND KEYWORD =N'lblfrmThongtinthietbi_may_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên máy (tiếng Anh)', ENGLISH=N'Equipment name (English)', VIETNAM_OR=N'Tên máy (tiếng Anh)', ENGLISH_OR=N'Equipment name (English)' WHERE FORM=N'frmThongtinthietbi' AND KEYWORD=N'lblfrmThongtinthietbi_may_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThongtinthietbi',N'lblfrmThongtinthietbi_may_Anh',N'Tên máy (tiếng Anh)',N'Equipment name (English)',N'Tên máy (tiếng Anh)',N'Equipment name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNguyenNhanDungMay' AND KEYWORD =N'lblNguyenNhanNgungMayAnh') UPDATE LANGUAGES SET VIETNAM=N'Nguyên nhân ngừng máy (tiếng Anh)', ENGLISH=N'Downtime cause (English)', VIETNAM_OR=N'Nguyên nhân ngừng máy (tiếng Anh)', ENGLISH_OR=N'Downtime cause (English)' WHERE FORM=N'frmNguyenNhanDungMay' AND KEYWORD=N'lblNguyenNhanNgungMayAnh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNguyenNhanDungMay',N'lblNguyenNhanNgungMayAnh',N'Nguyên nhân ngừng máy (tiếng Anh)',N'Downtime cause (English)',N'Nguyên nhân ngừng máy (tiếng Anh)',N'Downtime cause (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThongtinthietbi' AND KEYWORD =N'lblfrmThongtinthietbi_bo_phan_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên bộ phận (tiếng Anh)', ENGLISH=N'Part name (English)', VIETNAM_OR=N'Tên bộ phận (tiếng Anh)', ENGLISH_OR=N'Part name (English)' WHERE FORM=N'frmThongtinthietbi' AND KEYWORD=N'lblfrmThongtinthietbi_bo_phan_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThongtinthietbi',N'lblfrmThongtinthietbi_bo_phan_Anh',N'Tên bộ phận (tiếng Anh)',N'Part name (English)',N'Tên bộ phận (tiếng Anh)',N'Part name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDanhmuchethong' AND KEYWORD =N'lblfrmDanhmuchethongAnh') UPDATE LANGUAGES SET VIETNAM=N'Tên dây chuyền (tiếng Anh)', ENGLISH=N'Line name (English)', VIETNAM_OR=N'Tên dây chuyền (tiếng Anh)', ENGLISH_OR=N'Line name (English)' WHERE FORM=N'frmDanhmuchethong' AND KEYWORD=N'lblfrmDanhmuchethongAnh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDanhmuchethong',N'lblfrmDanhmuchethongAnh',N'Tên dây chuyền (tiếng Anh)',N'Line name (English)',N'Tên dây chuyền (tiếng Anh)',N'Line name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDanhmucphutung_CS' AND KEYWORD =N'lblfrmDanhmucphutung_CS_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên phụ tùng (tiếng Anh)', ENGLISH=N'Spare part name (English)', VIETNAM_OR=N'Tên phụ tùng (tiếng Anh)', ENGLISH_OR=N'Spare part name (English)' WHERE FORM=N'frmDanhmucphutung_CS' AND KEYWORD=N'lblfrmDanhmucphutung_CS_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDanhmucphutung_CS',N'lblfrmDanhmucphutung_CS_Anh',N'Tên phụ tùng (tiếng Anh)',N'Spare part name (English)',N'Tên phụ tùng (tiếng Anh)',N'Spare part name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThongsoGSTT' AND KEYWORD =N'lblfrmThongsoGSTT_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên thông số (tiếng Anh)', ENGLISH=N'Parameter name (English)', VIETNAM_OR=N'Tên thông số (tiếng Anh)', ENGLISH_OR=N'Parameter name (English)' WHERE FORM=N'frmThongsoGSTT' AND KEYWORD=N'lblfrmThongsoGSTT_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThongsoGSTT',N'lblfrmThongsoGSTT_Anh',N'Tên thông số (tiếng Anh)',N'Parameter name (English)',N'Tên thông số (tiếng Anh)',N'Parameter name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThietBi' AND KEYWORD =N'lblfrmThietBi_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên loại thiết bị (tiếng Anh)', ENGLISH=N'Equipment type name (English)', VIETNAM_OR=N'Tên loại thiết bị (tiếng Anh)', ENGLISH_OR=N'Equipment type name (English)' WHERE FORM=N'frmThietBi' AND KEYWORD=N'lblfrmThietBi_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThietBi',N'lblfrmThietBi_Anh',N'Tên loại thiết bị (tiếng Anh)',N'Equipment type name (English)',N'Tên loại thiết bị (tiếng Anh)',N'Equipment type name (English)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDanhmuccongviec' AND KEYWORD =N'lblfrmDanhmuccongviec_Anh') UPDATE LANGUAGES SET VIETNAM=N'Tên công việc (tiếng Anh)', ENGLISH=N'Work name (English)', VIETNAM_OR=N'Tên công việc (tiếng Anh)', ENGLISH_OR=N'Work name (English)' WHERE FORM=N'frmDanhmuccongviec' AND KEYWORD=N'lblfrmDanhmuccongviec_Anh' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDanhmuccongviec',N'lblfrmDanhmuccongviec_Anh',N'Tên công việc (tiếng Anh)',N'Work name (English)',N'Tên công việc (tiếng Anh)',N'Work name (English)')


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_PT_ANH') and Object_ID = Object_ID(N'IC_PHU_TUNG'))
BEGIN
		ALTER TABLE IC_PHU_TUNG ADD TEN_PT_ANH NVARCHAR(250)
				
END	
GO
update  ic_phu_tung set TEN_PT_ANH = ISNULL(TEN_PT_ANH,TEN_PT) where TEN_PT_ANH = '' or ISNULL(TEN_PT_ANH,TEN_PT) = TEN_PT
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_PT_HOA') and Object_ID = Object_ID(N'IC_PHU_TUNG'))
BEGIN
		ALTER TABLE IC_PHU_TUNG ADD TEN_PT_HOA NVARCHAR(250)	
END
GO
update  ic_phu_tung set TEN_PT_HOA = ISNULL(TEN_PT_HOA,TEN_PT) where TEN_PT_HOA = '' or ISNULL(TEN_PT_HOA,TEN_PT) = TEN_PT
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_HE_THONG_ANH') and Object_ID = Object_ID(N'HE_THONG'))
BEGIN
		ALTER TABLE HE_THONG ADD TEN_HE_THONG_ANH NVARCHAR(250)
END	
GO
update  HE_THONG set TEN_HE_THONG_ANH = ISNULL(TEN_HE_THONG_ANH,TEN_HE_THONG) where TEN_HE_THONG_ANH = '' or ISNULL(TEN_HE_THONG_ANH,TEN_HE_THONG) = TEN_HE_THONG
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_HE_THONG_HOA') and Object_ID = Object_ID(N'HE_THONG'))
BEGIN	
		ALTER TABLE HE_THONG ADD TEN_HE_THONG_HOA NVARCHAR(250)
END	
GO
update  HE_THONG set TEN_HE_THONG_HOA = ISNULL(TEN_HE_THONG_HOA,TEN_HE_THONG) where TEN_HE_THONG_HOA = '' or ISNULL(TEN_HE_THONG_HOA,TEN_HE_THONG) = TEN_HE_THONG
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_BO_PHAN_ANH') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI ADD TEN_BO_PHAN_ANH NVARCHAR(250)
END	
GO
update  CAU_TRUC_THIET_BI set TEN_BO_PHAN_ANH = ISNULL(TEN_BO_PHAN_ANH,TEN_BO_PHAN) where TEN_BO_PHAN_ANH = '' or ISNULL(TEN_BO_PHAN_ANH,TEN_BO_PHAN) = TEN_BO_PHAN
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_BO_PHAN_HOA') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI'))
BEGIN	
		ALTER TABLE CAU_TRUC_THIET_BI ADD TEN_BO_PHAN_HOA NVARCHAR(250)
END	
GO
update  CAU_TRUC_THIET_BI set TEN_BO_PHAN_HOA = ISNULL(TEN_BO_PHAN_HOA,TEN_BO_PHAN) where TEN_BO_PHAN_HOA = '' or ISNULL(TEN_BO_PHAN_HOA,TEN_BO_PHAN) = TEN_BO_PHAN
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_MAY_ANH') and Object_ID = Object_ID(N'MAY'))
BEGIN
		ALTER TABLE MAY ADD TEN_MAY_ANH NVARCHAR(250)		
END	
GO
update  MAY set TEN_MAY_ANH = ISNULL(TEN_MAY_ANH,TEN_MAY) where TEN_MAY_ANH = '' or ISNULL(TEN_MAY_ANH,TEN_MAY) = TEN_MAY
GO


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_MAY_HOA') and Object_ID = Object_ID(N'MAY'))
BEGIN
		ALTER TABLE MAY ADD TEN_MAY_HOA NVARCHAR(250)	
END
GO
update  MAY set TEN_MAY_HOA = ISNULL(TEN_MAY_HOA,TEN_MAY) where TEN_MAY_HOA = '' or ISNULL(TEN_MAY_HOA,TEN_MAY) = TEN_MAY
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_TS_GSTT_ANH') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD TEN_TS_GSTT_ANH NVARCHAR(250)		
END	
GO
update  THONG_SO_GSTT set TEN_TS_GSTT_ANH = ISNULL(TEN_TS_GSTT_ANH,TEN_TS_GSTT) where TEN_TS_GSTT_ANH = '' or ISNULL(TEN_TS_GSTT_ANH,TEN_TS_GSTT) = TEN_TS_GSTT
GO



IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_TS_GSTT_HOA') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD TEN_TS_GSTT_HOA NVARCHAR(250)	
END
GO
update  THONG_SO_GSTT set TEN_TS_GSTT_HOA = ISNULL(TEN_TS_GSTT_HOA,TEN_TS_GSTT) where TEN_TS_GSTT_ANH = '' or ISNULL(TEN_TS_GSTT_HOA,TEN_TS_GSTT) = TEN_TS_GSTT
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_LOAI_MAY_ANH') and Object_ID = Object_ID(N'LOAI_MAY'))
BEGIN
		ALTER TABLE LOAI_MAY ADD TEN_LOAI_MAY_ANH NVARCHAR(250)		
END	
GO
update  LOAI_MAY set TEN_LOAI_MAY_ANH = ISNULL(TEN_LOAI_MAY_ANH,TEN_LOAI_MAY) where TEN_LOAI_MAY_ANH = '' or ISNULL(TEN_LOAI_MAY_ANH,TEN_LOAI_MAY) = TEN_LOAI_MAY
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_LOAI_MAY_HOA') and Object_ID = Object_ID(N'LOAI_MAY'))
BEGIN
		ALTER TABLE LOAI_MAY ADD TEN_LOAI_MAY_HOA NVARCHAR(250)	
END
GO
update  LOAI_MAY set TEN_LOAI_MAY_HOA = ISNULL(TEN_LOAI_MAY_HOA,TEN_LOAI_MAY) where TEN_LOAI_MAY_HOA = '' or ISNULL(TEN_LOAI_MAY_HOA,TEN_LOAI_MAY) = TEN_LOAI_MAY
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MO_TA_CV_ANH') and Object_ID = Object_ID(N'CONG_VIEC'))
BEGIN
		ALTER TABLE CONG_VIEC ADD MO_TA_CV_ANH NVARCHAR(250)		
END	
GO
update  CONG_VIEC set MO_TA_CV_ANH = ISNULL(MO_TA_CV_ANH,MO_TA_CV) where MO_TA_CV_ANH = '' or ISNULL(MO_TA_CV_ANH,MO_TA_CV) = MO_TA_CV
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'MO_TA_CV_HOA') and Object_ID = Object_ID(N'CONG_VIEC'))
BEGIN
		ALTER TABLE CONG_VIEC ADD MO_TA_CV_HOA NVARCHAR(250)	
END
GO
update  CONG_VIEC set MO_TA_CV_HOA = ISNULL(MO_TA_CV_HOA,MO_TA_CV) where MO_TA_CV_HOA = '' or ISNULL(MO_TA_CV_HOA,MO_TA_CV) = MO_TA_CV
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_NHOM_MAY_ANH') and Object_ID = Object_ID(N'NHOM_MAY'))
BEGIN
		ALTER TABLE NHOM_MAY ADD TEN_NHOM_MAY_ANH NVARCHAR(250)		
END	
GO
update  NHOM_MAY set TEN_NHOM_MAY_ANH = ISNULL(TEN_NHOM_MAY_ANH,TEN_NHOM_MAY) where TEN_NHOM_MAY_ANH = '' or ISNULL(TEN_NHOM_MAY_ANH,TEN_NHOM_MAY) = TEN_NHOM_MAY
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_NHOM_MAY_HOA') and Object_ID = Object_ID(N'NHOM_MAY'))
BEGIN
		ALTER TABLE NHOM_MAY ADD TEN_NHOM_MAY_HOA NVARCHAR(250)	
END
GO
update  NHOM_MAY set TEN_NHOM_MAY_ANH = ISNULL(TEN_NHOM_MAY_HOA,TEN_NHOM_MAY) where TEN_NHOM_MAY_HOA = '' or ISNULL(TEN_NHOM_MAY_HOA,TEN_NHOM_MAY) = TEN_NHOM_MAY
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CA_ANH') and Object_ID = Object_ID(N'CA'))
BEGIN
		ALTER TABLE CA ADD CA_ANH NVARCHAR(250)		
END	
GO
update  CA set CA_ANH = ISNULL(CA_ANH,CA) where CA_ANH = '' or ISNULL(CA_ANH,CA) = CA
GO

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CA_HOA') and Object_ID = Object_ID(N'CA'))
BEGIN
		ALTER TABLE CA ADD CA_HOA NVARCHAR(250)		
END	
GO
update  CA set CA_HOA = ISNULL(CA_HOA,CA) where CA_ANH = '' or ISNULL(CA_HOA,CA) = CA
GO