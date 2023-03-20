Drop database JukskeiDatabase
--------------------------------------------------------------------------Tournament Tables---------------------------------------------------------------------------------------------------------------

	--Creating Tournament_period Table. This table will facilitate The date which the tournamnet will be played over.
	--This table will also look at Tournamnet Exstensions which will be the case when a league day is canceled,
	--and the tournamnet will be moved on one week.

Go
Create Table 
	Tournaments_Period(
	Tournament_Period_Id int Identity(1, 1) Primary Key,
	Days_Played int not null check (Days_Played < 14),
	Tournament_Date Date not Null,
	Tournament_Extension int check (Tournament_Extension < 5),
	IsActive bit not null)

	--Creating Tournament_Type table which will facilitate tournaments which are of diffrent types,
	--Example of Types of Tournamnets Week (5 Days of play), league (3 days of play over 3 weeks), 
	--Day Tournamnet (One day of Play).

Go
Use 
	JukskeiDatabase
Create Table 
	Tournaments_Types(
	Tournament_Type_Id int Identity(1, 1) Primary Key,
	Tournament_Type VarChar(20) not null)

	--Creating Playouts Table which will be used to check iff there will be playouts or not.
	--The top teams in each Group will be specified by the Number_Of_Top_Teams_Playout and these top teams
	--Will play out agains each other.

Go
Use 
	JukskeiDatabase
Create Table 
	Playouts(
	Playouts_Id int Primary Key Identity(1,1),
	PlayoutsActive bit not null,
	Number_Of_Top_Teams_Playout int not null)

	--Creating the Tournamnets table which will be the main table which will inherit from all the sub tables.
	--Tournaments Have a one to many relationship with 3 tables.
	--Tournaments is the One in the relationship. Where the other table is the Many in the relationship.

	drop table Tournaments

Use 
	JukskeiDatabase
Create Table 
	Tournaments(
	Tournament_Id int Identity(1, 1) Primary Key,
	Tournament_Period_Id int not null,
	Tournament_Type_Id int not null,
	Playouts_Id int,
    FOREIGN KEY (Tournament_Period_Id) REFERENCES Tournaments_Period(Tournament_Period_Id),
	FOREIGN KEY (Tournament_Type_Id) REFERENCES Tournaments_Types(Tournament_Type_Id),
	FOREIGN KEY (Playouts_Id) REFERENCES Playouts(Playouts_Id))

----------------------------------------------------------Inserting Dummy data into the Tournament Tables-----------------------------------------------------------------------------------------------------------

		Select * From Tournaments_Period

		--Inserting dummy data into the Tournaments_Period Table.

INSERT INTO		
		Tournaments_Period (Days_Played, Tournament_Date, Tournament_Extension, IsActive)
VALUES	
		(5, '2022-05-10', 3, 1),
		(10, '2022-07-15', 2, 0),
		(7, '2022-09-23', 1, 1);

		Select * From Tournaments_Types

		--Inserting dummy data into the Tournaments_Types Table.

INSERT INTO Tournaments_Types (Tournament_Type)
VALUES 
	('Day Tournament'),
	('Week Tournament'),
	('League Tournament');

		Select * From Playouts

	   --Inserting dummy data into the Playouts Table.

INSERT INTO 
		Playouts (PlayoutsActive, Number_Of_Top_Teams_Playout)
VALUES 
		(1, 2),
        (0, 3),
        (1, 4);

		Select * From Tournaments

		--Inserting dummy data into the Tournaments Table.

INSERT INTO 
		Tournaments (Tournament_Period_Id, Tournament_Type_Id, Playouts_Id)
VALUES 
		(1, 2, 1),
        (2, 1, null),
        (3, 3, 3);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------Team, Player and Roster Tables-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Creating the Teams table which will house the team names.

Use
	JukskeiDatabase
Create Table
	Teams(
	Team_Id int Primary Key Identity(1,1),
	Team_Name VarChar(20))

	--Creating The Players Table.
	--The Players Table will have a One to Many relationship with Teams.
	--Players can have one team where teams can have multiple players.

Use
	JukskeiDatabase
Create Table
	Players(
	Player_Id int Primary Key Identity(1,1),
	Player_Name VarChar(20),
	Team_Id int not null,
	FOREIGN KEY (Team_Id) REFERENCES Teams(Team_Id))

	--Creating the Rosters Table.
	--Roster table will have a one to many ralationship with the Teams and Players Table.
	--Roster can have Many Players and Teams where as the Player and Teams table can only have one roster.
	
Use
	JukskeiDatabase
Create Table
	Rosters(
	Roster_Id int Primary Key Identity(1, 1),
	Team_Id int not null,
	Player_Id int not null,
	FOREIGN KEY (Team_Id) REFERENCES Teams(Team_Id),
	FOREIGN KEY (Player_Id) REFERENCES Players(Player_Id))
	
-------------------------------------------------------Inserting Dummy data into the Team, Player and Roster-----------------------------------------------------------------------------------------------------------

		--Inserting data into the "Teams" table

		select * From Teams

INSERT INTO 
		Teams (Team_Name)
VALUES 
		('Team A'),
		('Team B'),
		('Team C');

		--Inserting data into the "Players" table

		select * From Players

INSERT INTO 
		Players (Player_Name, Team_Id)
VALUES 
		('John', 1),
		('Jane', 1),
		('Bob', 2),
		('Alice', 3);

		--Inserting data into the "Rosters" table

INSERT INTO 
		Rosters (Team_Id, Player_Id)
VALUES 
		(1, 1),
		(1, 2),
		(2, 3),
		(3, 4);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------Client and Payment Tables-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Creating the Clients Table which will house all the Client Details.

	drop table Clients_Admin
	drop table Payments

Use
	JukskeiDatabase
Create Table
	Clients_Admin(
	Client_Admin_Id int Primary Key Identity(1,1),
	Client_Admin_UserName VarChar(30) Unique not null,
	Client_Admin_Password VarChar(20) not null check (Len(Client_Admin_Password) >= 5),
	Client_Admin_Name VarChar(20) not null,
	Client_Admin_SurName VarChar(20) not null,
	Client_Admin_Email VarChar(30) not null)

	--Creating the Payments Tables.
	--The Payments table will house all the payments that are done by the clients which is facilitated through a One to many relationship.

Use
	JukskeiDatabase
Create Table
	Payments(
	Payment_Id int Primary Key Identity(1,1),
	Payment_Amount Money not null Check (Payment_Amount >= 0),
	Outstanding_balance Money Check (Outstanding_balance >= 0),
	Payment_Date Date not null,
	Client_Admin_Id int not null,
	Tournament_Id int not null,
	FOREIGN KEY (Client_Admin_Id) REFERENCES Clients_Admin(Client_Admin_Id),
	FOREIGN KEY (Tournament_Id) REFERENCES Tournaments(Tournament_Id))

-------------------------------------------------------Inserting Dummy data into the Team, Player and Roster-----------------------------------------------------------------------------------------------------------

		Select * From Clients_Admin

		--Inserting data into Clients table

INSERT INTO 
		Clients_Admin (Client_Admin_UserName, Client_Admin_Password, Client_Admin_Name, Client_Admin_SurName, Client_Admin_Email)
VALUES 
		('john_doe', '12345', 'John', 'Doe', 'john.doe@example.com'),
        ('jane_doe', '12345', 'Jane', 'Doe', 'jane.doe@example.com'),
        ('bob_smith', '12345', 'Bob', 'Smith', 'bob.smith@example.com');

		--Inserting data into Payments table

		Select * From Payments

INSERT INTO 
		Payments (Payment_Amount, Outstanding_balance, Payment_Date, Client_Admin_Id, Tournament_Id)
VALUES 
		(500.00, 0.00, '2022-02-15', 1, 1),
        (750.00, 1250.00, '2022-03-01', 2, 2),
        (1000.00, 0.00, '2022-03-15', 3, 3);