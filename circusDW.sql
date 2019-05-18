CREATE DATABASE CircusDW
GO

USE CircusDW
GO

create table Viewer (
ID_Viewer integer identity(1,1) primary key,
OLD_ID_Viewer int,
ID varchar (50),
Name varchar(50),
Surname varchar(50),
Origin varchar (50),
Date_of_Birth date,
Age varchar (50)
);

create table Type (
ID_Type integer identity(1,1) primary key,
OLD_ID_Type int,
Type varchar(20)
);

create table Entertainment (
ID_Entertainment integer identity(1,1) primary key,
OLD_ID_Entertainment int,
Genre varchar(30)
);

create table Performance (
ID_Performance integer identity(1,1) primary key,
OLD_ID_Performance int, 
Name varchar(70),
);

create table Performer (
ID_Performer integer identity(1,1) primary key,
ID varchar(11),
Name varchar(30),
Surname varchar(50),
Skill varchar(50),
);

create table Time (
ID_Time integer identity(1,1) primary key,
Hour int,
Daytime varchar(30),
);

create table Date (
ID_Date integer identity(1,1) primary key,
Day varchar (20),
Month varchar (20), 
Year int,
Working_Day varchar(10),
Holiday varchar(50)
);

create table Junk (
ID_Junk integer identity(1,1) primary key,
OLD_ID_Event int,
Contest bit
);

CREATE TABLE Activity (
    ID_Activity integer identity(1,1) primary key,
	ID_Viewer int foreign key references Viewer,
    ID_Event int,
    ID_Entertainment int foreign key references Entertainment,
	ID_Time int foreign key references Time,
	ID_Date int foreign key references Date, 
	ID_Type int foreign key references Type
);

create table Event (
ID_Event integer identity(1,1) primary key,
Tickets_sold int,
ID_Performer int foreign key references Performer,
ID_Performance int foreign key references Performance,
Performer_likes int,
ID_Time int foreign key references Time,
ID_Date int foreign key references Date,
Junk_ID int foreign key references Junk
);


--INSERT INTO Viewer(ID_Viewer, ID, Name, Surname, Origin, Date_of_Birth, Age)
--VALUES (1,'6689012','Artur','Piastowski','Gdansk','1997-09-10','child'),
--(2,'6689012','Kaleb','Piastowski','Gdansk','1997-09-10','child'),
--(3,'6689012','Martyna','Piastowski','Gdansk','1997-09-10','child'),
--(13,'6689012','AgArt','Piastowski','Gdansk','2000-09-10','child'),
--(4,'6689012','Martyna','Garnek','Warszawa','1979-11-10','adult'),
--(5,'6689012','Ahmed','Sienkiewicz','Wilno','1997-09-10','child'),
--(6,'6689012','Karyna','Style','Malborg','1997-09-10','child'),
--(7,'6689012','Chlop','Wiejski','Emblong','1961-09-10','old'),
--(8,'6689012','Siri','Android','Gdynia','1997-09-10','child'),
--(9,'6689012','Google','Master','Arka','1980-09-10','adult'),
--(10,'6689012','Study','Budy','God','1981-09-10','adult'),
--(11,'6689012','Gnooom','Pop','Nowa','1997-09-10','child'),
--(12,'6689012','Batman','Banner','Warka','1960-09-10','old');

--INSERT INTO Type(ID_Type,Type)
--VALUES (1,'Like'),
--(2,'Love'),
--(3,'Share'),
--(4,'Like'),
--(5,'Love'),
--(6,'Share'),
--(7,'Like'),
--(8,'Love'),
--(9,'Share'),
--(10,'Like'),
--(11,'Love'),
--(12,'Share');

--INSERT INTO Entertainment(ID_Entertainment,Genre)
--VALUES(1,'Music'),
--(2,'Comedy'),
--(3,'Political'),
--(4,'Music'),
--(5,'Comedy'),
--(6,'Political'),
--(7,'Music'),
--(8,'Comedy'),
--(9,'Political'),
--(10,'Music'),
--(11,'Comedy'),
--(12,'Political');

--INSERT INTO Performance(ID_Performance,Name)
--VALUES(1,'Shadow'),
--(2,'Light'),
--(3,'Funny Bunny'),
--(4,'Coster'),
--(5,'Bang'),
--(6,'Psycho'),
--(7,'Festival'),
--(8,'Light'),
--(9,'Psycho'),
--(10,'Shadow'),
--(11,'Coster'),
--(12,'Shadow');


--INSERT INTO Performer(ID_Performer,ID,Name,Surname,Skill)
--VALUES(1,'945282236','Gigi','Hamilton','Fire Eater'),
--(2,'6689112','Lewis','Hamilton','Dogs Lover'),
--(3,'6689212','Robert','Kubica','Racer'),
--(4,'6689312','Kimi','Raikonen','Nothing'),
--(5,'6689412','Michael','Schumacher','Crazy Eyes'),
--(6,'6689512','Niko','Rosberg','Singing Shallow');

--INSERT INTO Time(ID_Time,Hour,Daytime)
--VALUES(1,10,'Morning'),
--(2,13,'Afternoon'),
--(3,19,'Evening'),
--(4,24,'Midnight');

--INSERT INTO Junk(ID_Junk,Contest)
--VALUES(1,1),
--(2,1),
--(3,1),
--(4,0),
--(5,0),
--(6,1),
--(7,1),
--(8,1),
--(9,0);

--INSERT INTO Date(ID_Date,Day,Month,Year,Working_Day,Holiday)
--VALUES(1,'01','02',1999,'Yes','No'),
--(2,'02','02',2003,'Yes','No'),
--(3,'03','01',2001,'No','No'),
--(4,'04','03',1997,'Yes','No'),
--(5,'05','04',1998,'No','Yes'),
--(6,'06','01',2009,'No','No'),
--(7,'07','05',2007,'Yes','No');


--INSERT INTO Activity(ID_Activity,ID_Viewer,ID_Event,ID_Entertainment,ID_Time,ID_Date,ID_Type)
--VALUES(1,1,2,1,1,1,1),
--(2,1,2,2,2,2,2),
--(3,2,3,1,2,3,3),
--(4,3,1,4,3,2,1),
--(5,2,1,3,2,2,2),
--(6,1,5,2,1,3,3),
--(7,4,4,1,4,3,3),
--(8,5,3,1,2,4,3),
--(9,2,2,2,1,2,1),
--(10,1,1,1,3,1,1),
--(11,4,4,3,2,1,1),
--(12,7,3,1,4,1,2),
--(13,6,1,1,1,2,2),
--(14,2,1,4,2,4,3),
--(15,1,2,1,1,2,1),
--(16,3,6,1,3,1,2);

--INSERT INTO Event(ID_Event,Tickets_sold,ID_Performer,ID_Performance,Performer_likes,ID_Time,ID_Date,Junk_ID)
--VALUES(1,100,1,1,200,1,2,1),
--(2,150,1,2,200,1,4,2),
--(3,170,2,4,250,3,3,3),
--(4,182,2,4,250,2,1,4),
--(5,33,3,5,13,3,2,5),
--(6,112,1,2,200,1,3,6),
--(7,234,4,4,578,4,1,7),
--(8,98,5,2,233,2,4,8);

--select * from Event