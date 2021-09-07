
if not exists(select * from sys.columns 
            where Name = N'SAVE_TMP' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD SAVE_TMP NVARCHAR(250) DEFAULT '0'
END    
GO
--0 or null nhu cu mo filediaglog len cho nguoi ta chon duong dan
--1 luu vao temp win
--2 luu vao thu muc app luc nay fai co thu muc temp trong app
--3 có duong dan file. luu thang vao duong dabn file
if exists(select * from sys.columns 
            where Name = N'SAVE_TMP' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    UPDATE THONG_TIN_CHUNG SET SAVE_TMP = '0' WHERE SAVE_TMP IS NULL
END    
