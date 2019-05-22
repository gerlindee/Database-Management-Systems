-- problema 3) part 1
-- execute begin + select from here, then the update from the other file; then the other select + commit

BEGIN TRANSACTION
SELECT * FROM Users WHERE UserId = 1
-- WAITFOR DELAY '00:00:05'
SELECT * FROM Users WHERE UserID = 1
COMMIT TRANSACTION

-- solution
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT * FROM Users WHERE UserId = 1
-- WAITFOR DELAY '00:00:05'
SELECT * FROM Users WHERE UserID = 1
COMMIT TRANSACTION
