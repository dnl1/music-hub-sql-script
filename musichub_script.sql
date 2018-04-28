-- SCHEMA
CREATE DATABASE musichub

USE musichub

CREATE TABLE IF NOT EXISTS Musician (
   id int auto_increment primary key,
   name varchar(100) not null,
   email varchar(70) not null,
   password varchar(40) not null,
   birth_date DATE
)

ALTER TABLE Musician
ADD UNIQUE (email);

CREATE TABLE IF NOT EXISTS MusicalGenre(
	id int auto_increment primary key,
    name varchar(35) not null
)

INSERT INTO MusicalGenre(name) VALUES("Punk"),("Pop Punk"),("Hard Rock"),("Rock Classico"),("Heavy Metal")

CREATE TABLE IF NOT EXISTS MusicalProject (
   id int auto_increment primary key,
   name varchar(100) not null,
   owner_id int not null,
   musical_genre_id int not null,
   finish int null,
   created_at DateTime not null,
   updated_at DateTime not null,
   foreign key (owner_id) references Musician(id),
   foreign key (musical_genre_id) references MusicalGenre(id)
)

CREATE TABLE IF NOT EXISTS Instrument(
	id int auto_increment primary key,
	name varchar(100) not null    
)

INSERT INTO Instrument (name) VALUES ("Lead Guitar"),("Bass"),("Drums"),("Voice"),("Piano"),("Rhythm Guitar")

CREATE TABLE IF NOT EXISTS ContributionStatus(
	id int auto_increment primary key,
	name varchar(50) not null    
)

INSERT INTO ContributionStatus(name) VALUES ("Waiting for approval"),("Approved"),("Refused")

CREATE TABLE IF NOT EXISTS ContributionType(
	id int auto_increment primary key,
	name varchar(20) not null    
)

INSERT INTO ContributionType(name) VALUES ("Free Contribution"),("Private Contribution")

CREATE TABLE IF NOT EXISTS MusicalProjectInstrument(
	id int auto_increment primary key,
	musical_project_id int not null,
	foreign key (musical_project_id) references MusicalProject(id),
	instrument_id int not null,
    is_base_instrument bool not null,
	foreign key (instrument_id) references Instrument(id)    
)

CREATE TABLE IF NOT EXISTS Contribution(
	id int auto_increment primary key,
    musician_id int not null,
    foreign key (musician_id) references Musician(id),
    musical_project_instrument_id int,
    foreign key (musical_project_instrument_id) references MusicalProjectInstrument(id),
	musical_project_id int,
    foreign key (musical_project_id) references MusicalProject(id),
	status_id int not null,
    foreign key (status_id) references ContributionStatus(id),
	type_id int not null,
    foreign key (type_id) references ContributionType(id),
    musical_genre_id int not null,
	foreign key (musical_genre_id) references MusicalGenre(id),
    timing varchar(8) not null,
    created_at Datetime not null    
)

CREATE TABLE IF NOT EXISTS RateMusician(
	id int auto_increment primary key,
    musician_owner_id int not null,
    foreign key (musician_owner_id) references Musician(id),
	musician_target_id int not null,
    foreign key (musician_target_id) references Musician(id),
    rate_value int(5) not null
)

CREATE TABLE IF NOT EXISTS RateContribution(
	id int auto_increment primary key,
    musician_id int not null,
    foreign key (musician_id) references Musician(id),
	contribution_id int not null,
    foreign key (contribution_id) references Contribution(id),
    rate_value int(5) not null
)


CREATE TABLE IF NOT EXISTS RateMusicalProject(
	id int auto_increment primary key,
    musician_id int not null,
    foreign key (musician_id) references Musician(id),
	musical_project_id int not null,
    foreign key (musical_project_id) references MusicalProject(id),
    rate_value int(5) not null
)

CREATE TABLE IF NOT EXISTS BearerAuthentication(
    id int auto_increment primary key,
    access_token nvarchar(200),
    client nvarchar(100),
    uid nvarchar(150),
    expiry datetime null
)

SELECT * FROM Musician