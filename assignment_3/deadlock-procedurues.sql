CREATE OR ALTER PROCEDURE deadlock1 AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Superheroes SET alterEgo = 'Batgirl' WHERE secretIdentity = 'Barbara Gordon'
	-- exclusive lock on Superheroes
	WAITFOR DELAY '00:00:10'
	-- T2 called
	UPDATE Teams SET base = 'Asgard' WHERE name = 'The Revengers'
	COMMIT TRANSACTION
END
GO

EXEC deadlock1