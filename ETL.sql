-- ############################################### Entertainment
Merge Into CircusDW.dbo.Entertainment as target
        Using CircusDB.dbo.Entertainment as source
	      On target.OLD_ID_Entertainment = source.EntertainmentID
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values (source.EntertainmentID,source.Genre);

-- ############################################### Viewer
Merge Into CircusDW.dbo.Viewer as target
        Using CircusDB.dbo.Viewers as source
	      On target.ID = source.ID
			When Not Matched 
				Then -- The ID in the Source is not found in the Target
					INSERT 
					Values (source.ViewerID,source.ID, source.Name, source.Surname, source.Origin, source.Birth, cast(
					CASE 
					WHEN DATEDIFF(YY,source.Birth, GETDATE()) < 40 THEN 'young'
					WHEN DATEDIFF(YY,source.Birth, GETDATE()) >= 41 THEN 'old'
					END as varchar(50)))
			WHEN MATCHED
					AND DATEDIFF(YY,source.Birth, GETDATE()) >= 41 AND target.age = 'young'
				THEN UPDATE 
					SET target.Age = cast('old' as varchar(50));

						Insert into CircusDW.dbo.Viewer
		( OLD_ID_Viewer, ID, Name, Surname, Origin, Date_of_Birth, Age)
		Select ViewerID, ID, Name, Surname, Origin, Birth, cast(
					CASE 
					WHEN DATEDIFF(YY,Birth, GETDATE()) > 0 THEN 'young'
					END as varchar(50)) from CircusDB.dbo.Viewers 
		Except 
		Select OLD_ID_Viewer, ID, Name, Surname, Origin, Date_of_Birth, Age from CircusDW.dbo.Viewer

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
Skills varchar(30),
Likes int
)

BULK
INSERT tempCEOperformer
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane2\Circus-Data-1.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n')

Merge Into CircusDW.dbo.Performer as target
        Using CircusDB.dbo.tempCEOperformer as source
	      On target.ID = source.ID 
			When Not Matched 
				Then 
					INSERT 
					Values(source.ID, source.Name, source.Surname, source.Skills);

-- ############################################### Performance
use CircusDB
go
create table tempCEOperformance(
ID int,
Tickets_sold int,
Starting_Hour int,
Worker_Name varchar(30),
Worker_Surname varchar(30),
Worker_Part varchar(70),
Payment integer,
Date date,
)

BULK
INSERT tempCEOperformance
FROM 'C:\Users\aaszl\Desktop\sem4\DW\dane2\Circus-Data-1a.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
Merge Into CircusDW.dbo.Performance as target
        Using CircusDB.dbo.tempCEOperformance as source
	      On target.OLD_ID_Performance = source.ID 
			When Not Matched 
				Then -- The ID in the Source is not found the Target
					INSERT 
					Values(source.ID, source.Worker_Part);

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
				Then 
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
				Then 
					INSERT 
					Values(source.OLD_ID_Event , source.Contest);

-- ############################################### DATE
--DECLARE @start DATE = '2015-12-06'
--	WHILE @start < DATEADD(month, 3, GETDATE())
--	  BEGIN
--		INSERT INTO circusDW.dbo.Date (Date, Day, Month, Year, Working_Day, Holiday)
--		VALUES(@start, CASE
--					WHEN DATEPART(dw,@start) = 1 THEN 'sunday'
--					WHEN DATEPART(dw,@start) = 2 THEN 'monday'
--					WHEN DATEPART(dw,@start) = 3 THEN 'tuesday'
--					WHEN DATEPART(dw,@start) = 4 THEN 'wednesday'
--					WHEN DATEPART(dw,@start) = 5 THEN 'thursday'
--					WHEN DATEPART(dw,@start) = 6 THEN 'friday'
--					WHEN DATEPART(dw,@start) = 7 THEN 'saturday'
--				END, 
--				CASE 
--					WHEN DATEPART(mm,@start)= 1 THEN 'january'
--					WHEN DATEPART(mm,@start)= 2 THEN 'february'
--					WHEN DATEPART(mm,@start)= 3 THEN 'march'
--					WHEN DATEPART(mm,@start)= 4 THEN 'april'
--					WHEN DATEPART(mm,@start)= 5 THEN 'may'
--					WHEN DATEPART(mm,@start)= 6 THEN 'april'
--					WHEN DATEPART(mm,@start)= 7 THEN 'june'
--					WHEN DATEPART(mm,@start)= 8 THEN 'july'
--					WHEN DATEPART(mm,@start)= 9 THEN 'september'
--					WHEN DATEPART(mm,@start)= 10 THEN 'october'
--					WHEN DATEPART(mm,@start)= 11 THEN 'november'
--					WHEN DATEPART(mm,@start)= 12 THEN 'december'
--				END,
--				DATEPART(YY,@start), 
--				CASE
--					WHEN DATEPART(dw,@start) = 1 THEN 1
--					WHEN DATEPART(dw,@start) = 2 THEN 1
--					WHEN DATEPART(dw,@start) = 3 THEN 1
--					WHEN DATEPART(dw,@start) = 4 THEN 1
--					WHEN DATEPART(dw,@start) = 5 THEN 1
--					WHEN DATEPART(dw,@start) = 6 THEN 0
--					WHEN DATEPART(dw,@start) = 7 THEN 0
--				END,

--					CASE
--					WHEN DATEPART(dw,@start) = 1 THEN 0
--					WHEN DATEPART(dw,@start) = 2 THEN 0
--					WHEN DATEPART(dw,@start) = 3 THEN 0
--					WHEN DATEPART(dw,@start) = 4 THEN 0
--					WHEN DATEPART(dw,@start) = 5 THEN 0
--					WHEN DATEPART(dw,@start) = 6 THEN 1
--					WHEN DATEPART(dw,@start) = 7 THEN 1
--				END)
--		SET @start = DATEADD(dd,1,@start)
--	  END

--DECLARE @start2 INT = 0
--	WHILE @start2 < 24
--	  BEGIN
--		INSERT INTO circusDW.dbo.Time (Hour, Daytime)
--		VALUES(@start2,
--					CASE
--					WHEN @start2 BETWEEN 0 AND 4 THEN 'Night'
--					WHEN @start2 BETWEEN 4 AND 8 THEN 'Early Morning'
--					WHEN @start2 BETWEEN 8 AND 12 THEN 'Morning'
--					WHEN @start2 BETWEEN 12 AND 18 THEN 'Afternoon'
--					WHEN @start2 BETWEEN 18 AND 24 THEN 'Late Afternoon'
--				END )
--		SET @start2 = @start2+1
--	  END

-- ############################################### Event

MERGE INTO CircusDW.dbo.Event AS Target
	USING CircusDB.dbo.tempCEOperformance AS Excel
	ON Target.ID_Event = Excel.ID
	WHEN NOT MATCHED 
		THEN INSERT VALUES  
		(Excel.ID, Excel.Tickets_sold, 
		(SELECT ID_Performer FROM CircusDW.dbo.Performer as eh
						 WHERE Excel.Worker_Name = eh.Name and 
						 Excel.Worker_Surname=eh.Surname), 
		(SELECT ID_Performance FROM CircusDW.dbo.Performance as eh
						 WHERE Excel.ID = eh.OLD_ID_Performance), 
		(SELECT Likes FROM CircusDB.dbo.tempCEOperformer as eh
						 WHERE Excel.Worker_Name = eh.Name and 
						 Excel.Worker_Surname=eh.Surname),
		(Select ID_Time FROM CircusDW.dbo.Time as eh where  Excel.Starting_Hour  = eh.Hour),
		(SELECT ID_Date FROM CircusDW.dbo.Date AS T1 WHERE T1.Date = Excel.Date),
		(SELECT  ID_Junk from CircusDW.dbo.Junk 
						 WHERE Excel.ID=CircusDW.dbo.Junk.ID_Junk)); 

-- ############################################### Activity
CREATE VIEW tempEVENTID AS
select CircusDW.dbo.Event.ID_Event as EventDW, CircusDB.dbo.Activity.PostID as PostDB, 
				CircusDB.dbo.Posts.PostID as PostDB2, CircusDB.dbo.Posts.EventID as EventDB, CircusDB.dbo.Events.EventID as EventDB2
				from CircusDB.dbo.Activity join CircusDB.dbo.Posts
				on CircusDB.dbo.Posts.PostID=CircusDB.dbo.Activity.PostID
				join CircusDW.dbo.Event on CircusDW.dbo.Event.OLD_ID_Event=CircusDB.dbo.Posts.EventID
				join CircusDB.dbo.Events on CircusDB.dbo.Events.EventID=CircusDB.dbo.Posts.EventID;
go

CREATE VIEW tempENTID AS
select CircusDW.dbo.Entertainment.ID_Entertainment as EntDW, CircusDW.dbo.Entertainment.OLD_ID_Entertainment as OldEntDW, 
CircusDB.dbo.Viewers.ViewerID as ViewerDB, CircusDB.dbo.Isinto.ViewerID as ViewerDB2, 
CircusDB.dbo.Isinto.EntertainmentID as EntDB, eh.EntertainmentID as EntDB2
from CircusDB.dbo.Viewers join CircusDB.dbo.Isinto on CircusDB.dbo.Viewers.ViewerID=CircusDB.dbo.Isinto.ViewerID
join CircusDB.dbo.Entertainment as eh on eh.EntertainmentID=CircusDB.dbo.Isinto.EntertainmentID
join CircusDW.dbo.Entertainment on CircusDW.dbo.Entertainment.OLD_ID_Entertainment=eh.EntertainmentID;
go
CREATE VIEW tempActivity AS
select ActivityID, ViewerID, PostID,  cast(CASE when Likes = 1 then 'Like'
						 when Share = 1 then 'Share'
						 when Comment = 1 then 'Comment'
					END as varchar(20) ) as type
					from CircusDB.dbo.Activity;
					go


CREATE VIEW tempType AS
select CircusDW.dbo.Type.ID_Type as TypeDW,CircusDB.dbo.Posts.PostID as PostDB, tempActivity.PostID, 
				tempActivity.Type, tempActivity.ViewerID
				from CircusDW.dbo.Type join tempActivity
				on CircusDW.dbo.Type.OLD_ID_Type=tempActivity.PostID
				join CircusDB.dbo.Posts
				on CircusDB.dbo.Posts.PostID=tempActivity.PostID;
				go

MERGE INTO CircusDW.dbo.Activity AS Target
	USING CircusDB.dbo.Activity AS Source
		ON Target.OLD_ID_ACTIVITY = Source.ActivityID
			WHEN NOT MATCHED
				THEN INSERT VALUES (Source.ActivityID, 
				-- viever ID
				(SELECT ID_Viewer FROM CircusDW.dbo.Viewer AS T1 WHERE T1.ID_Viewer = Source.ViewerID),
				--Event ID
				(SELECT top 1 EventDW FROM tempEVENTID AS T1 WHERE T1.PostDB = Source.PostID),
				--Entertainment ID
				(SELECT top 1 EntDW FROM tempENTID AS T1 WHERE T1.ViewerDB = Source.ViewerID),
				(SELECT ID_Time FROM CircusDW.dbo.Time AS T1 WHERE T1.Hour = Source.Time),
				(SELECT ID_Date FROM CircusDW.dbo.Date AS T1 WHERE T1.Date = Source.Date),
				-- Type ID
				(SELECT distinct TypeDW FROM tempType AS T1 WHERE T1.PostDB = Source.PostID));

use CircusDB
go
drop view tempEVENTID
drop view tempENTID
drop table tempCEOperformer
drop table tempCEOperformance

--use CircusDW
--go
--truncate table Entertainment
--truncate table CircusDW.dbo.Viewer
--truncate table CircusDW.dbo.Performer
--truncate table CircusDW.dbo.Performance
--truncate table CircusDW.dbo.Type
--truncate table CircusDW.dbo.Junk
--truncate table CircusDW.dbo.Activity
--truncate table CircusDW.dbo.Event

