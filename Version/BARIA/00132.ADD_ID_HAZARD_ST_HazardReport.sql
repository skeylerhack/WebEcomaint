if not exists(select * from sys.columns 
           where Name = N'ID_HAZARD' and Object_ID = Object_ID(N'ST_HazardReport'))
begin
ALTER TABLE dbo.ST_HazardReport ADD ID_HAZARD INT END  