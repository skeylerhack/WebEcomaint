


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TARGET') and Object_ID = Object_ID(N'NHA_XUONG'))
BEGIN
		ALTER TABLE NHA_XUONG ADD  [TARGET] FLOAT DEFAULT 0.0
END

GO

update NHA_XUONG SET [TARGET] = 13.2 
