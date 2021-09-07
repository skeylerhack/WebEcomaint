
--if not exists(select * from sys.columns 
--           where Name = N'MS_N_XUONG' and Object_ID = Object_ID(N'USERS'))
--begin
--   ALTER TABLE USERS ADD MS_N_XUONG NVARCHAR(50)
--END    
