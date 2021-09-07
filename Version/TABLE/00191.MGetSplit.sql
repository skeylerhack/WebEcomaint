

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'MGetSplit')
   exec('CREATE FUNCTION  dbo.MGetSplit ()returns  @MSplit TABLE (Pos [INT]) as begin return end')
GO

--	SELECT * FROM [dbo].[MGetSplit](N'OK!Sửa chữa xong!Phải sửa chữa!Cần chú ý' ,N'!')  A 





ALTER FUNCTION [dbo].[MGetSplit] (
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
    )
RETURNS @out_put TABLE (
    [POS] INT IDENTITY(1, 1) NOT NULL,
    [VALUE] NVARCHAR(MAX)
    )
AS
BEGIN
    DECLARE @value NVARCHAR(MAX),
        @pos INT = 0,
        @len INT = 0

    SET @string = CASE 
            WHEN RIGHT(@string, 1) != @delimiter
                THEN @string + @delimiter
            ELSE @string
            END

    WHILE CHARINDEX(@delimiter, @string, @pos + 1) > 0
    BEGIN
        SET @len = CHARINDEX(@delimiter, @string, @pos + 1) - @pos
        SET @value = SUBSTRING(@string, @pos, @len)

        INSERT INTO @out_put ([value])
        SELECT LTRIM(RTRIM(@value)) AS [column]

        SET @pos = CHARINDEX(@delimiter, @string, @pos + @len) + 1
    END

    RETURN
END