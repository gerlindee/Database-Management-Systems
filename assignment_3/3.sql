/* create a stored procuedure that inserts data in tables that are in a n:m relationship; if an insert fails, try to recover as much as possible from the entire operation: 
for example, if the user wants to add a team and its members, succeeds adding the superheroes, but fails with the team, the superheroes should remain in the database */

CREATE OR ALTER FUNCTION uf_ValidateMember (@yearsActive int) RETURNS INT AS
BEGIN
	DECLARE @return int
	SET @return = 0
	IF (@yearsActive > 1)
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER PROCEDURE AddSuperheroTeam @secretIdentity varchar(100), @alterEgo varchar(100), @species varchar(50), @homebase varchar(50), @name varchar(100), @base varchar(100), @yearsActive int AS
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				IF (dbo.uf_ValidateSpecies(@species) <> 1)
					BEGIN
						RAISERROR('Invalid species name. Must be one of the following: Human, Metahuman, Kryptonian, Amazon, Martian', 14, 1)
					END
				INSERT INTO Superheroes (secretIdentity, alterEgo, species, homeBase) VALUES (@secretIdentity, @alterEgo, @species, @homebase)
				DECLARE @superheroID int
				SELECT @superheroID = MAX(id) FROM Superheroes
			COMMIT TRANSACTION
			SELECT 'Transaction for superheroes committed'
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SELECT 'Transaction for superheroes rollbacked'
		END CATCH

		BEGIN TRY
			BEGIN TRANSACTION
				IF (dbo.uf_ValidateBase(@base) <> 1)
					BEGIN
						RAISERROR('Invalid base location. Must be one of the following: Metropolis, Gotham, Star City, Outer Space, Unknown, New York', 14, 1)
					END
				INSERT INTO Teams (name, base) VALUES (@name, @base)
				DECLARE @teamID int
				SELECT @teamID = MAX(id) FROM Teams
			COMMIT TRANSACTION
			SELECT 'Transaction for teams committed'
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SELECT 'Transaction for teams rollbacked'
		END CATCH

		BEGIN TRY
			BEGIN TRANSACTION
				IF (dbo.uf_ValidateMember(@yearsActive) <> 1)
					BEGIN
						RAISERROR('Invalid activity duration. Value must be larger than 1.',14,1)
					END
				INSERT INTO MemberOf (superheroID, teamID, yearsActive) VALUES (@superheroID, @teamID, @yearsActive)
			COMMIT TRANSACTION
			SELECT 'Transaction for membership committed'
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SELECT 'Transaction for membership rollbacked'
		END CATCH
	END 

/* case one: everything succeeds */
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf
EXEC AddSuperheroTeam 'Tony Stark','Iron Man','Human','New York','The Avengers','New York',5
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf

/* case two: superhero insertion fails, but team insertion succeeeds */
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf
EXEC AddSuperheroTeam 'Thor Odinson','Thor','Asgardian','Asgard','The Revengers','Outer Space',3
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf

/* case three: superhero insertion succeeds, but team insertion fails */
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf
EXEC AddSuperheroTeam 'Brunnhilde','Valkyrie','Metahuman','Asgard','The Revengers','Asgard',5
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf

/* case three: superhero insertion succeeds, team insertion succeeds, but membership insertion fails */
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf
EXEC AddSuperheroTeam 'Selina Kyle','Catwoman','Human','Gotham','Gotham City Sirens','Gotham',0
SELECT * FROM Superheroes
SELECT * FROM Teams
SELECT * FROM MemberOf
