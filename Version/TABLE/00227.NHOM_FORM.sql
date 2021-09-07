
UPDATE dbo.CHI_TIET_FORMS SET TEN_FORMS_VIET = N'2.4. Địa điểm hoạt động',TEN_FORMS_ANH= N'2.4. Work site' WHERE FORM_NAME  ='frmBranch'

GO	

DELETE FROM dbo.NHOM_FORM WHERE FORM_NAME = 'frmDanhmucnhaxuong' 
GO 
DELETE FROM CHI_TIET_FORMS WHERE FORM_NAME = 'frmDanhmucnhaxuong' 
GO 

DELETE FROM dbo.DS_FORM WHERE FORM_NAME = 'frmDanhmucnhaxuong' 
