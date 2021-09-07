--GetAllChildMenu 'mnuMaster'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAllChildMenu')
   exec('CREATE PROCEDURE GetAllChildMenu AS BEGIN SET NOCOUNT ON; END')
GO

alter PROC GetAllChildMenu 
	@MenuID NVARCHAR(50) = 'mnuDSYeuCauNSD'
AS
BEGIN

DECLARE @Root INT = 0
DECLARE @ID INT

SELECT   @ID = ID, @Root = [Root] FROM WebMenu WHERE MenuID = @MenuID

WHILE (@Root <> 0)
BEGIN
	SELECT  @ID =  ID,  @Root = [Root] FROM WebMenu WHERE [ID] = @Root
END
SELECT * FROM WebMenu WHERE ID = @ID or [Root] = @ID
END