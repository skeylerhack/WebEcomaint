
if not exists(select * from sys.columns 
            where Name = N'TEN_LOAI_CV_ANH' and Object_ID = Object_ID(N'LOAI_CONG_VIEC'))
begin
    ALTER TABLE LOAI_CONG_VIEC ADD  TEN_LOAI_CV_ANH  NVARCHAR(500)
END    

GO 
if not exists(select * from sys.columns 
            where Name = N'TEN_LOAI_CV_HOA' and Object_ID = Object_ID(N'LOAI_CONG_VIEC'))
begin
    ALTER TABLE LOAI_CONG_VIEC ADD  TEN_LOAI_CV_HOA  NVARCHAR(500)
END    

