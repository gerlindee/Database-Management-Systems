
INSERT INTO Books(Title, Category, LibraryID, PublisherID) VALUES ('Bleach', 'Manga', 1, 1)
BEGIN TRANSACTION
WAITFOR DELAY '00:00:10'
UPDATE Books set Category = 'Anime' WHERE Title = 'Bleach'
COMMIT TRANSACTION