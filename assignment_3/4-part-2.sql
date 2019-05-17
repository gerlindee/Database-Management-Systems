/* create scenarios that reporduce some concurrency issues
	this is the file where we have the T2 transactions, where the isolation levels are set */

-- T2 = starts right after T1

-- 1) Dirty reads = occur when a transaction is allowed to read data from a row that has been modified by another running transaction but not yet committed
	-- T2 = select + delay + select

-- T2 - dirty reads happen under isolation level read uncommited
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION
SELECT * FROM Superheroes -- value will be displayed as the updated one => "Dirty read"
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes -- value will be displayed as it actually is in the database, not updated, due to rolling back in T1
COMMIT TRANSACTION

-- Solution => read committed (guarantees that any data read was committed at the moment is read)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM Superheroes -- value unchanged
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes -- value unchanged
COMMIT TRANSACTION

-- 2) Non-repeatable reads = occur when, during the course of a transaction, a row is retrieved twice and the values within the row differ between reads
	-- T2 = select + delay + select

-- T2 - non repeatable reads happen under isolation level read committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM Superheroes
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes
COMMIT TRANSACTION

-- Solution => repeatable read isolation level
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT * FROM Superheroes
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes
COMMIT TRANSACTION

-- 3) Phantom reads = occur when, in the course of a transaction, new rows are added or removed by another transaction to the records being read
	-- T2 = select + delay + select

-- T2 - phantom reads happen under isolation level repeatable read
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT * FROM Superheroes
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes
COMMIT TRANSACTION

-- Solution => serializable isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
SELECT * FROM Superheroes
WAITFOR DELAY '00:00:25'
SELECT * FROM Superheroes
COMMIT TRANSACTION