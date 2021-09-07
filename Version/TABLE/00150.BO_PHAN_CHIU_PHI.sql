if not exists(select * from sys.columns 
            where Name = N'TEN_BPCP_ANH' and Object_ID = Object_ID(N'BO_PHAN_CHIU_PHI'))
begin
    ALTER TABLE BO_PHAN_CHIU_PHI ADD TEN_BPCP_ANH NVARCHAR(250)
END    

if not exists(select * from sys.columns 
            where Name = N'TEN_BPCP_HOA' and Object_ID = Object_ID(N'BO_PHAN_CHIU_PHI'))
begin
    ALTER TABLE BO_PHAN_CHIU_PHI ADD TEN_BPCP_HOA NVARCHAR(250)
END    


ALTER TABLE LOAI_BAO_TRI ALTER COLUMN TEN_LOAI_BT nvarchar(250)


ALTER TABLE BO_PHAN_CHIU_PHI ALTER COLUMN TEN_BP_CHIU_PHI nvarchar(250)