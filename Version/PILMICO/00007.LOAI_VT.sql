IF NOT EXISTS (SELECT * FROM LOAI_VT WHERE MS_LOAI_VT = '0000')
BEGIN
INSERT INTO LOAI_VT (MS_LOAI_VT,TEN_LOAI_VT_TV,TEN_LOAI_VT_TA,TEN_LOAI_VT_TH,VAT_TU)
VALUES	('0000','Integration','Integration','Integration',0)
END