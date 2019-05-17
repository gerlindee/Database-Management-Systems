/* create scenarios that reproduce some concurrency issues 
	this is the file where we have the T1 transactions aka the transactions that may or may not cause an issue, within different isolation levels */

-- T1 = starts first

-- 1) Dirty reads
	-- T1 = update + delay + rollback

BEGIN TRANSACTION
UPDATE Superheroes set alterEgo = 'Batgirl' where secretIdentity = 'Barbara Gordon'
WAITFOR DELAY '00:00:15'
ROLLBACK TRANSACTION

-- 2) Dirty reads
	-- T1 = insert + delay + update + commit

INSERT INTO Superheroes(secretIdentity, alterEgo, species, homeBase) VALUES ('Scott Summers','Cyclops','Mutant','New York')
BEGIN TRANSACTION
WAITFOR DELAY '00:00:15'
UPDATE Superheroes set homeBase = 'Xavier School for the Gifted' WHERE secretIdentity='Scott Summers'
COMMIT TRANSACTION

-- 3) Phantom reads
	-- T1 = delay + insert + commit

BEGIN TRANSACTION
WAITFOR DELAY '00:00:15'
INSERT INTO Superheroes(secretIdentity, alterEgo, species, homeBase) VALUES ('Ororo Munroe','Storm','Mutant','New York')
COMMIT TRANSACTION

-- 4) Deadlock
	-- T1 = update + delay + update

BEGIN TRANSACTION
UPDATE Superheroes SET alterEgo = 'Batgirl' WHERE secretIdentity = 'Barbara Gordon'
-- exclusive lock on Superheroes
WAITFOR DELAY '00:00:10'
-- T2 called
UPDATE Teams SET base = 'Asgard' WHERE name = 'The Revengers'
COMMIT TRANSACTION
