


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'INVECO') and Object_ID = Object_ID(N'NHA_XUONG'))
BEGIN
		ALTER TABLE NHA_XUONG ADD  INVECO FLOAT DEFAULT 0
END
GO
update NHA_XUONG SET INVECO = 1 WHERE MS_N_XUONG = '10'
update NHA_XUONG SET INVECO = 2 WHERE MS_N_XUONG = '12'
update NHA_XUONG SET INVECO = 3 WHERE MS_N_XUONG = '15'
update NHA_XUONG SET INVECO = 3.1 WHERE MS_N_XUONG = '15.01'
update NHA_XUONG SET INVECO = 3.2 WHERE MS_N_XUONG = '15.02'
update NHA_XUONG SET INVECO = 3.3 WHERE MS_N_XUONG = '15.03'
update NHA_XUONG SET INVECO = 3.4 WHERE MS_N_XUONG = '15.04'
update NHA_XUONG SET INVECO = 4 WHERE MS_N_XUONG = '20'
update NHA_XUONG SET INVECO = 5 WHERE MS_N_XUONG = '24'
update NHA_XUONG SET INVECO = 6 WHERE MS_N_XUONG = '50'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '30'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '31'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '33'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '27'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '35'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '37'
update NHA_XUONG SET INVECO = 7 WHERE MS_N_XUONG = '40'
update NHA_XUONG SET INVECO = 8 WHERE MS_N_XUONG = '44'
update NHA_XUONG SET INVECO = 9 WHERE MS_N_XUONG = '42'


