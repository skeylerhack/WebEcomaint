
--GetlanguageWeb 'DonViWeb'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetlanguageWeb')
   exec('CREATE PROCEDURE GetlanguageWeb AS BEGIN SET NOCOUNT ON; END')
GO

alter procedure [dbo].[GetlanguageWeb]
@FORM AS NVARCHAR(50)
 AS
SELECT FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,STT,MS_MODULE
FROM LANGUAGES
WHERE FORM=@FORM AND VIETNAM IS NOT NULL

UNION 

SELECT '',MenuID , Name , NameEng, '','', '' FROM WebMenu

UNION

SELECT FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,STT,MS_MODULE
FROM LANGUAGES WHERE FORM='NavbarMenu' AND VIETNAM IS NOT NULL
