if NOT exists(SELECT * FROM CHUC_NANG WHERE STT = 112)
	INSERT INTO CHUC_NANG (STT,TEN_CHUC_NANG) VALUES (112,N'Import danh mục giá VTPT')
GO
if NOT exists(SELECT * FROM DS_IMPORT WHERE MS_IMPORT = 92)
	INSERT INTO DS_IMPORT(MS_IMPORT, TEN_IMPORT,SU_DUNG,IMPORT,MS_IMPORT_CHA)	values (92, N'Cập nhập giá vật tư phụ tùng',1,1,102)

GO
if NOT exists (select 1 from sys.columns where name = 'GIA_VTPT' and object_name(object_id) = 'IC_PHU_TUNG') 
BEGIN
	ALTER TABLE IC_PHU_TUNG  ADD GIA_VTPT FLOAT;
END
