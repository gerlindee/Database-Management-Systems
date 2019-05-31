
CREATE TABLE Libraries (
	LibraryID INT PRIMARY KEY IDENTITY(1,1),
	Library_Name VARCHAR(100),
	Library_Location VARCHAR(100)
)

CREATE TABLE Publishers (
	PublisherID INT PRIMARY KEY IDENTITY(1,1),
	Publisher_Name VARCHAR(100)
)

CREATE TABLE Books (
	BookID INT PRIMARY KEY IDENTITY(1,1),
	Title VARCHAR(100),
	Category VARCHAR(100),
	LibraryID INT REFERENCES Libraries(LibraryID), 
	PublisherID INT REFERENCES Publishers(PublisherID)
)

CREATE TABLE Authors (
	AuthorID INT PRIMARY KEY IDENTITY(1,1),
	Author_Name VARCHAR(100)
)

CREATE TABLE BooksAuthors (
	BookID INT REFERENCES Books(BookID),
	AuthorID INT REFERENCES Authors(AuthorID),

	PRIMARY KEY(BookID, AuthorID)
)

CREATE TABLE Affiliations (
	AffiliationID INT PRIMARY KEY IDENTITY(1,1),
	Affiliation_Name VARCHAR(100)
)

CREATE TABLE Readers (
	ReaderID INT PRIMARY KEY IDENTITY(1,1),
	Reader_Name VARCHAR(100),
	Preference VARCHAR(100),
	AffiliationID INT REFERENCES Affiliations(AffiliationID)
)

CREATE TABLE ReadersBooks (
	BookID INT REFERENCES Books(BookID),
	ReaderID INT REFERENCES Readers(ReaderID)

	PRIMARY KEY(BookID, ReaderID)
)

