if not exists(select * from sys.columns 
            where Name = N'TAI_SD' and Object_ID = Object_ID(N'IC_PHU_TUNG'))
begin
    ALTER TABLE dbo.IC_PHU_TUNG ADD TAI_SD BIT  DEFAULT (0)
END    
GO	
UPDATE dbo.IC_PHU_TUNG SET TAI_SD = 0 WHERE TAI_SD IS NULL

    
