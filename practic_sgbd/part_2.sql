-- Non-repeatable reads = occur when, during the course of a transaction, a row is retrieved twice and the values within the row differ between reads

-- non repeatable reads happen under isolation level read committed
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT * FROM Books
WAITFOR DELAY '00:00:15'
SELECT * FROM Books
COMMIT TRANSACTION

-- Solution => repeatable read isolation level
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT * FROM Books
WAITFOR DELAY '00:00:15'
SELECT * FROM Books
COMMIT TRANSACTION