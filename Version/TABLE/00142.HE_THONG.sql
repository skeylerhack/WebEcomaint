
if not exists(select * from sys.columns 
            where Name = N'STT' and Object_ID = Object_ID(N'HE_THONG'))
begin
    ALTER TABLE HE_THONG ADD STT INT NULL


END   

if not exists(select * from sys.columns 
            where Name = N'MS_CHA' and Object_ID = Object_ID(N'HE_THONG'))
begin
    ALTER TABLE HE_THONG ADD MS_CHA INT NULL


END   

GO
--if exists(select * from sys.columns 
--        where Name = N'MS_CHA' and Object_ID = Object_ID(N'HE_THONG'))
--		BEGIN
--		UPDATE HE_THONG SET MS_CHA = MS_HE_THONG WHERE MS_CHA IS NULL
--		END
	

if not exists(select * from sys.columns 
            where Name = N'TAI_LIEU' and Object_ID = Object_ID(N'HE_THONG'))
begin
    ALTER TABLE HE_THONG ADD TAI_LIEU NVARCHAR(250) NULL
END   


ALTER TABLE HE_THONG ALTER COLUMN TEN_HE_THONG nvarchar(250)

ALTER TABLE HE_THONG ALTER COLUMN MA_HE_THONG nvarchar(50) NULL
