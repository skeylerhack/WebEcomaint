mail dropbox
ecomaint.cmms@gmail.com
Vietsoft@123


--Loại cập nhật (LOAI_CN) = 0 ~ cập nhật cũ
--1 ~ cập nhật mới - LAN
--2 ~ cập nhật mới - NET

--LINK1 ~ update.zip
--link2 ~ version.txt
--link3 ~ LAN - \\\\IP\\folder
--link 1 2 3 không được null hoặc "" -  mặc định .
update THONG_TIN_CHUNG 
set LOAI_CN = 1,
LINK1 = '.',
LINK2 = '.',
LINK3 = N'\\\\192.168.2.10\\X-Public\\02-Users\\Nhat.Tran\\Update' --\\\\192.168.2.22\\Update     
--where [PRIVATE] = 'VARD'

---------------------------GREENFEED
----------update THONG_TIN_CHUNG 
----------set LOAI_CN = 0,
----------LINK1 = '.',
----------LINK2 = '.',
----------LINK3 = '.' 
----------where [PRIVATE] = 'GREENFEED'


---------------------------VINHKHANH
----------update THONG_TIN_CHUNG 
----------set LOAI_CN = 0,
----------LINK1 = '.',
----------LINK2 = '.',
----------LINK3 = '.' 
----------where [PRIVATE] = 'VINHKHANH'

---------------------------VIETROLL
----------update THONG_TIN_CHUNG 
----------set LOAI_CN = 0,
----------LINK1 = '.',
----------LINK2 = '.',
----------LINK3 = '.' 
----------where [PRIVATE] = 'VIETROLL'


---------------------------BARIA
----------update THONG_TIN_CHUNG 
----------set LOAI_CN = 0,
----------LINK1 = '.',
----------LINK2 = '.',
----------LINK3 = '.' 
----------where [PRIVATE] = 'BARIA'