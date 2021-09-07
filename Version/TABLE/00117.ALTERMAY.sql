



if not exists(select * from sys.columns 
            where Name = N'DVT_SL' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE MAY ADD DVT_SL  NVARCHAR(50)
END    

GO