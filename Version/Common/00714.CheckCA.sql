IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CheckCA')
   exec('CREATE PROCEDURE CheckCA AS BEGIN SET NOCOUNT ON; END')
GO



ALTER procedure [dbo].[CheckCA]
@CA NVARCHAR(50)

 AS

		SELECT CA FROM CA 
		WHERE UPPER(CA)=UPPER(@CA)

