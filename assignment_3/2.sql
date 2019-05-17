/* create a stored procedure that inserts data into tables that are in a m:n relationship; if one insert fails, all the operations performed by the procedure must be rolled back */

CREATE OR ALTER FUNCTION uf_ValidateSpecies (@species varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return int
	SET @return = 0
	IF (@species IN ('Human','Metahuman','Kryptonian','Amazon','Martian'))
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION uf_ValidateBase (@base varchar(100)) RETURNS INT AS
BEGIN
	DECLARE @return int
	SET @return = 0
	IF (@base IN ('Gotham', 'Metropolis', 'Star City', 'Outer Space', 'Unknown', 'New York'))
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER PROCEDURE AddNewSuperhero @secretIdentity varchar(100), @alterEgo varchar(100), @species varchar(50), @homebase varchar(50) AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		IF (dbo.uf_ValidateSpecies(@species) <> 1)
			BEGIN
				RAISERROR('Invalid species name. Must be one of the following: Human, Metahuman, Kryptonian, Amazon, Martian', 14, 1)
			END

		INSERT INTO Superheroes (secretIdentity, alterEgo, species, homeBase) VALUES (@secretIdentity, @alterEgo, @species, @homebase)
		COMMIT TRAN
		SELECT 'Transaction committed'
	END TRY

	BEGIN CATCH 
		ROLLBACK TRAN
		SELECT 'Transaction rollbacked'
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE AddNewTeam @name varchar(100), @base varchar(100) AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		IF (dbo.uf_ValidateBase(@base) <> 1)
			BEGIN
				RAISERROR('Invalid base location. Must be one of the following: Metropolis, Gotham, Star City, Outer Space, Unknown, New York', 14, 1)
			END

		INSERT INTO Teams (name, base) VALUES (@name, @base)
		COMMIT TRAN
		SELECT 'Transaction committed'
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction rollbacked'
	END CATCH
END
GO

/* scenario with success (commit) for the first table */
SELECT * FROM Superheroes
EXEC AddNewSuperhero 'Peter Parker','Spiderman','Metahuman','New York'
SELECT * FROM Superheroes

/* scenario without success (rollback) for the first table */
SELECT * FROM Superheroes 
EXEC AddNewSuperhero 'Jean Grey','Phoenix','Mutant','Unknown'
SELECT * FROM Superheroes

/* scenario with success (commit) for the second table */
SELECT * FROM Teams
EXEC AddNewTeam 'The Avengers','New York'
SELECT * FROM Teams

/* scenario without success (commit) for the second table */
SELECT * FROM Teams
EXEC AddNewTeam 'The Revengers','Asgard'
SELECT * FROM Teams