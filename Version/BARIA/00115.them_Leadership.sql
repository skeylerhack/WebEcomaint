﻿-- them menu Leadership
DECLARE @menu nvarchar(500)
DECLARE @menu1 nvarchar(500)

SET @menu1 = 'mnuLeadership'
set @menu = N'ΞΠή͜ΎΆΌΎΨΪΔΖΤ'

--DELETE FROM dbo.LIC_MENU WHERE MENU_ID = @menu
IF NOT EXISTS (SELECT * FROM dbo.LIC_MENU WHERE MENU_ID = @menu)
	INSERT INTO LIC_MENU (MENU_ID,TYPE_LIC) VALUES ( @menu,N'̦')

	--DELETE FROM dbo.MENU WHERE MENU_ID = @menu1
IF NOT EXISTS (SELECT * FROM dbo.MENU WHERE MENU_ID = @menu1)
	INSERT	dbo.MENU(MENU_ID,MENU_TEXT,MENU_ENGLISH,MENU_PARENT,MENU_LINE,MENU_INDEX,CLASS_NAME,FUNCTION_NAME,AN_HIEN)
		VALUES(@menu1, N'10.10 Leadership',  N'10.10 Leadership', 'mnuSafety',0,10,'frmMain','ShowFormLeaderShip',1 )
	
	--DELETE  FROM NHOM_MENU WHERE MENU_ID = @menu1

IF NOT EXISTS (SELECT * FROM NHOM_MENU WHERE MENU_ID = @menu1)
	INSERT INTO NHOM_MENU(MENU_ID,GROUP_ID)
	VALUES(@menu1, 1)

-- them FORM Leadership
DECLARE @form nvarchar(500)
DECLARE @form1 nvarchar(500)
set @form = N'FrmLeadership'
set @form1 = N'͐ΨΞ͜ΎΆΌΎΨΪΔΖΤ'
--DELETE FROM CHI_TIET_FORMS WHERE FORM_NAME = @form
IF NOT EXISTS (SELECT * FROM CHI_TIET_FORMS WHERE FORM_NAME = @form)
	INSERT INTO CHI_TIET_FORMS(FORM_NAME , TEN_FORMS_VIET , TEN_FORMS_ANH)
	VALUES(@form , N'10.10 Leader ship', N'10.10 Leader')

--DELETE FROM NHOM_FORM WHERE FORM_NAME = @form
IF NOT EXISTS (SELECT * FROM NHOM_FORM WHERE FORM_NAME = @form)
INSERT INTO NHOM_FORM(GROUP_ID, FORM_NAME , QUYEN)
VALUES(1,@form , N'Full access')

--DELETE FROM LIC_FORM WHERE FORM_NAME = @form1
IF NOT EXISTS (SELECT * FROM LIC_FORM WHERE FORM_NAME = @form1)
INSERT INTO LIC_FORM(FORM_NAME , TYPE_LIC)
VALUES(@form1 , N'̦')
