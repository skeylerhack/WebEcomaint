


if not exists(select * from sys.columns 
            where Name = N'BPCP_MAIL' and Object_ID = Object_ID(N'BO_PHAN_CHIU_PHI'))
begin
    ALTER TABLE BO_PHAN_CHIU_PHI ADD BPCP_MAIL NVARCHAR(50)
END    
