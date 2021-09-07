ALTER FUNCTION UDF_ConvertListItem2Table  
    (  
        @ListItem VARCHAR(MAX),  
        @Delimiter CHAR  
    )  
RETURNS  
@Tab TABLE  
    (  
        Id int IDENTITY(1, 1),  
        Item VARCHAR(MAX)  
    )  
AS  
BEGIN  
 DECLARE @Item VARCHAR(MAX);  
 DECLARE @Index INT;  
 SET @ListItem = LTRIM(RTRIM(@ListItem)) + @Delimiter  
 SET @Index = CHARINDEX(@Delimiter, @ListItem)  
 WHILE @Index > 0  
 BEGIN  
  SET @Item = LTRIM(RTRIM(LEFT(@ListItem, @Index - 1)))  
  IF @Item != ''  
  BEGIN  
  INSERT INTO @Tab(Item)   VALUES(CAST(@Item AS VARCHAR(MAX)))  
  END  
  SET @ListItem = RIGHT(@ListItem, LEN(@ListItem) - @Index)  
  SET @Index = CHARINDEX(@Delimiter, @ListItem, 1)  
 END 
 return 
END
