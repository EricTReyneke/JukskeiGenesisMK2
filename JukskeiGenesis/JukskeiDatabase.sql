
Drop database JukskeiDatabase

--------------------------------------------------------------------------Tournament Tables---------------------------------------------------------------------------------------------------------------

	--Creating the Tournamnets table which will be the main table which will inherit from all the sub tables.
	--Tournaments Have a one to many relationship with 3 tables.
	--Tournaments is the One in the relationship. Where the other table is the Many in the relationship.


	drop table Tournaments;

	select * from Tournaments
	select * from Categories
	select * from Teams

Use 
	JukskeiDatabase
Create Table 
	Tournaments(
	Tournament_Id int Identity(1, 1) Primary Key,
	Tournament_Name VarChar(50) not null,
	Tournament_Location VarChar(50) not null,
	Tournament_Address VarChar(50) not null,
	Tournament_Type VarChar(20) not null,
	Tournament_Start_Date Date not Null,
	Tournament_End_Date Date not Null,
	Tournament_Extension int check (Tournament_Extension < 5),
	IsActive bit not null)

  Alter table Tournaments
  Add Tournament_State VarChar(10) check (Tournament_State = 'Upcomming' OR Tournament_State = 'Active' OR Tournament_State = 'Past')

  Alter table Tournaments
  Add Tournament_Age_Group VarChar(10)

  Alter table Tournaments
  Add Tournament_Blocks VarChar(10)

  ALTER TABLE Tournaments
ALTER COLUMN Tournament_Blocks VARCHAR(10) NOT NULL;

-- Step 2: Assign a default value
ALTER TABLE Tournaments
ALTER COLUMN Tournament_Blocks SET DEFAULT '';

  Alter table Tournaments
  Drop Column IsActive

----------------------------------------------------------Inserting Dummy data into the Tournament Tables-----------------------------------------------------------------------------------------------------------

Select 
	* 
From 
	Tournaments

	delete Tournaments
	where Tournament_Id in (5, 6, 7)


INSERT INTO 
	Tournaments (Tournament_Name, Tournament_Location, Tournament_Address, Tournament_Type, Tournament_Start_Date, Tournament_End_Date, Tournament_Extension, IsActive)
VALUES 
	('Bushi Swart', 'Johannesburg', 'Sunny Road', 'Day', '2022-12-01', '2022-12-01', 0, 0),
    ('SA Championships', 'Cape Town', 'BroodMan', 'Week', '2023-07-15', '2023-07-20', 0, 0),
    ('Wolie Coetzee', 'Durban', 'Day', 'Lekker Street', '2023-09-01', '2023-09-01', 0, 0);


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

ALTER TABLE [JukskeiDatabase].[dbo].[Teams]
ADD Tournament_Id int

ALTER TABLE [JukskeiDatabase].[dbo].[Teams]
ADD CONSTRAINT FK_Teams_Tournaments
FOREIGN KEY (Tournament_Id)
REFERENCES Tournaments(Tournament_Id);

	--Creating The Players Table.
	--The Players Table will have a One to Many relationsthip with Teams.
	--Players can have one team where teams can have multiple players.

	select * From Teams

	delete Categories
	where Tournament_Id in (5, 6, 7)
	
Use
	JukskeiDatabase
Create Table
	Categories(
	Category_Id int identity(1, 1) Primary Key,
	Category_Name VarChar(20) not null,
	Tournament_Id int not null,
	FOREIGN KEY (Tournament_Id) REFERENCES Tournaments(Tournament_Id))


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

drop table Rosters
	
Use
	JukskeiDatabase
Create Table
	Rosters(
	Roster_Id int Primary Key Identity(1, 1),
	Team_Id int not null,
	Tournament_Id int not null,
	Category_Id int not null,
	FOREIGN KEY (Team_Id) REFERENCES Teams(Team_Id),
	FOREIGN KEY (Tournament_Id) REFERENCES Tournaments(Tournament_Id),
	FOREIGN KEY (Category_Id) REFERENCES Categories(Category_Id))
	
-------------------------------------------------------Inserting Dummy data into the Team, Player and Roster-----------------------------------------------------------------------------------------------------------

		--Inserting data into the "Teams" table

		select * From Teams

INSERT INTO 
		Teams (Team_Name)
VALUES 
		('Team A'),
		('Team B'),
		('Team C');

		select * From Teams

INSERT INTO 
		Categories(Category_Name, Tournament_Id)
VALUES 
		('A', 2),
		('B', 2);

		--Inserting data into the "Players" table

		select * From Players

INSERT INTO 
		Players (Player_Name, Team_Id)
VALUES 
		('John', 1),
		('Jane', 1),
		('Arie', 1),
		('Dean', 1),
		('Eric', 2),
		('Anje', 2),
		('Marchant', 2),
		('Chris', 2),
		('Amore', 3),
		('Armand', 3),
		('James', 3),
		('Sam', 3);

		--Inserting data into the "Rosters" table

INSERT INTO 
		Rosters (Team_Id, Tournament_Id, Category_Id)
VALUES 
		(1, 2, 1),
		(2, 2, 2),
		(3, 2, 2);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------Client and Payment Tables-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	--Creating the Clients Table which will house all the Client Details.

Use
	JukskeiDatabase
Create Table
	Clients_Admin(
	Client_Admin_Id int Primary Key Identity(1,1),
	Client_Admin_UserName VarChar(30) Unique not null,
	Client_Admin_Name VarChar(20) not null,
	Client_Admin_SurName VarChar(20) not null,
	Client_Admin_Email VarChar(30) not null)

	drop table Clients_Admin

	--Creating the Payments Tables.
	--The Payments table will house all the payments that are done by the clients which is facilitated through a One to many relationship.

	drop table Payments

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
		Clients_Admin (Client_Admin_UserName, Client_Admin_Name, Client_Admin_SurName, Client_Admin_Email)
VALUES 
		('john_doe', 'John', 'Doe', 'john.doe@example.com'),
        ('jane_doe', 'Jane', 'Doe', 'jane.doe@example.com'),
        ('bob_smith', 'Bob', 'Smith', 'bob.smith@example.com');

		--Inserting data into Payments table

		Select * From Payments

INSERT INTO 
		Payments (Payment_Amount, Outstanding_balance, Payment_Date, Client_Admin_Id, Tournament_Id)
VALUES 
		(500.00, 0.00, '2022-02-15', 1, 2),
        (750.00, 1250.00, '2022-03-01', 2, 3),
        (1000.00, 0.00, '2022-03-15', 3, 4);

		Drop table MatchPoints

Create 
Table 
		MatchPoints(
		Match_Points_Id int Identity(1, 1) Primary Key,
		Match_Points int not null,
		Match_Played_Number int not null,
		Category_Id int not null,
		Tournament_Id int not null,
		Team_Id int not null,
		FOREIGN KEY (Category_Id) REFERENCES Categories(Category_Id),
		FOREIGN KEY (Team_Id) REFERENCES Teams(Team_Id),
		FOREIGN KEY (Tournament_Id) REFERENCES Tournaments(Tournament_Id))