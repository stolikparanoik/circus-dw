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
Date date,
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
	OLD_ID_Activity int,
	ID_Viewer int foreign key references Viewer,
    ID_Event int,
    ID_Entertainment int foreign key references Entertainment,
	ID_Time int foreign key references Time,
	ID_Date int foreign key references Date, 
	ID_Type int foreign key references Type
);

USE CircusDW
GO
create table Event (
ID_Event integer identity(1,1) primary key,
OLD_ID_Event int,
Tickets_sold int,
ID_Performer int foreign key references Performer,
ID_Performance int foreign key references Performance,
Performer_likes int,
ID_Time int foreign key references Time,
ID_Date int foreign key references Date,
Junk_ID int foreign key references Junk
);
