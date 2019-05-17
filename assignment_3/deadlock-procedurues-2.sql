CREATE OR ALTER PROCEDURE deadlock2 AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Superheroes SET secretIdentity = 'Dinah Drake' WHERE alterEgo = 'Black Canary'
	WAITFOR DELAY '00:00:10'
	UPDATE Teams SET base = 'The Aeries' WHERE name = 'Birds of Prey'
	COMMIT TRANSACTION 
END
GO

EXEC deadlock2