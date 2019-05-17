CREATE TABLE Superheroes (
	id int identity,
	secretIdentity varchar(100),
	alterEgo varchar(100),
	species varchar(50),
	homeBase varchar(50),

	PRIMARY KEY (id)
)

CREATE TABLE Teams (
	id int identity,
	name varchar(100),
	base varchar(100),

	PRIMARY KEY (id)
)

CREATE TABLE MemberOf (
	superheroID int,
	teamID int,

	PRIMARY KEY (superheroID, teamID),
	FOREIGN KEY (superheroID) REFERENCES Superheroes(id),
	FOREIGN KEY (teamID) REFERENCES Teams(id)
)