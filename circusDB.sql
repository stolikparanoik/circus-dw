CREATE DATABASE CircusDB 
GO

USE CircusDB
GO

CREATE TABLE Viewers
(
	ViewerID integer identity(1,1) primary key,
	ID varchar(11),
	Name varchar(15), 
	Surname varchar(20),
	Birth date,
	Funpages integer,
	Origin varchar(50)
)
GO

CREATE TABLE Events
(
	EventID integer identity(1,1) primary key,
	Date date,
	Going bit,
	Maybe bit,
	Invited bit,
)
GO
CREATE TABLE Posts
(
	PostID integer identity(1,1) primary key,
	EventID integer foreign key references Events,
	DateHour smalldatetime,
	Type varchar(50),
	Performer varchar(50),
	Performance varchar(50),
	Site BIT,
	Event BIT,
)
GO

CREATE TABLE Activity
(
    ActivityID integer identity(1,1) primary key, 
	ViewerID integer foreign key references Viewers,
	PostID integer foreign key references Posts,
	Likes BIT,
	Comment BIT,
	Share BIT,
)
GO


CREATE TABLE Part
(
	PartID integer identity(1,1) primary key,
	ViewerID integer foreign key references Viewers,
	EventID integer foreign key references Events,
	DateHour smalldatetime,
)
GO

CREATE TABLE Entertainment
(
	EntertainmentID int primary key,
	Followers integer,
	Genre varchar(30),
	Name varchar(30),
)
GO

CREATE TABLE Isinto
(
	IsintoID integer identity(1,1) primary key,
	ViewerID integer foreign key references Viewers,
	EntertainmentID integer foreign key references Entertainment,
	Date datetime,
	Activity BIT,
)
GO

BULK
INSERT Viewers
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\viewers.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

BULK
INSERT Posts
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\posts.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

BULK
INSERT Events
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\events.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

GO

BULK
INSERT Part
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\parts.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

select * from Part

BULK
INSERT Entertainment
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\entertainments.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

BULK
INSERT Isinto
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\into.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

BULK
INSERT Activity
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\activities.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO
-------------------------------------------------------
--BULK
--INSERT Viewers
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\viewers2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Viewers
--delete from Viewers

--BULK
--INSERT Posts
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\posts2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Posts

--BULK
--INSERT Events
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\events2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Events

--BULK
--INSERT Part
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\parts2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Part

--BULK
--INSERT Entertainment
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\entertainments2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Entertainment

--BULK
--INSERT Isinto
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\into2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--select * from Isinto

--BULK
--INSERT Activity
--FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\activities2.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO

--delete from Part
--delete from IsInto
--delete from Activity
--delete from Events
--delete from Posts
--delete from Entertainment
--delete from Viewers
