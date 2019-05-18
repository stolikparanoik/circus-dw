-- ############################################### Entertainment
Merge Into CircusDW.dbo.Entertainment as target
        Using CircusDB.dbo.Entertainment as source
	      On target.OLD_ID_Entertainment = source.EntertainmentID
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values (source.EntertainmentID,source.Genre);

--select * from CircusDW.dbo.Entertainment
--select * from CircusDB.dbo.Entertainment

-- ############################################### Viewer
Merge Into CircusDW.dbo.Viewer as target
        Using CircusDB.dbo.Viewers as source
	      On target.OLD_ID_Viewer = source.ViewerID
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values (source.ViewerID,source.ID, source.Name, source.Surname, source.Origin, source.Birth, cast(
					CASE 
					WHEN DATEDIFF(YY,source.Birth, GETDATE()) < 40 THEN 'young'
					WHEN DATEDIFF(YY,source.Birth, GETDATE()) >= 41 THEN 'old'
					END as varchar(50)
					));
select * from CircusDW.dbo.Viewer

-- ############################################### Performer
USE CircusDB
GO
create table tempCEOperformer(
ID_temp integer identity(1,1) primary key,
Frst_Day date,
Last_Day date,
ID varchar(11),
Name varchar(30),
Surname varchar(50),
Date_Of_Birth date,
Skills varchar(30)
)

BULK
INSERT tempCEOperformer
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\Circus-Data-1.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n')
select * from tempCEOperformer

Merge Into CircusDW.dbo.Performer as target
        Using CircusDB.dbo.tempCEOperformer as source
	      On target.ID = source.ID 
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.ID, source.Name, source.Surname, source.Skills);

select * from CircusDW.dbo.Performer

-- ############################################### Performance
use CircusDB
go

create table tempCEOperformance(
ID integer identity(1,1) primary key,
Tickets_sold int,
Starting_Hour time,
Worker_Name varchar(30),
Worker_Surname varchar(30),
Worker_Part varchar(70),
Payment integer,
)
drop table tempCEOperformance
BULK
INSERT tempCEOperformance
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane\Circus-Data-1a.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
--select * from tempCEOperformance
Merge Into CircusDW.dbo.Performance as target
        Using CircusDB.dbo.tempCEOperformance as source
	      On target.OLD_ID_Performance = source.ID 
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.ID, source.Worker_Part);
--select * from CircusDW.dbo.Performance

-- ############################################### Type
Merge Into CircusDW.dbo.Type as target
        Using CircusDB.dbo.Activity as source
	      On target.OLD_ID_Type = source.ActivityID 
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.ActivityID, cast(
					CASE when Likes = 1 then 'Like'
						 when Share = 1 then 'Share'
						 when Comment = 1 then 'Comment'
					END as varchar(20)
					));
--select * from CircusDW.dbo.Type

-- ############################################### Junk
use CircusDB
go

create table tempJunk (
ID_Junk integer identity(1,1) primary key,
OLD_ID_Event int,
Contest bit
);

Merge Into tempJunk as target
        Using CircusDB.dbo.Posts as source
	      On target.OLD_ID_Event = source.EventID 
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.EventID , cast(
					CASE when Type = 'likecontest' then 1
						 when Type = 'commentcontest' then 1
					END as BIT
					));

Merge Into CircusDW.dbo.Junk as target
        Using tempJunk as source
	      On target.OLD_ID_Event = source.OLD_ID_Event and source.Contest is not null
			When Not Matched and source.Contest is not null
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.OLD_ID_Event , source.Contest);

--delete from CircusDW.dbo.Junk
--select * from CircusDW.dbo.Junk

