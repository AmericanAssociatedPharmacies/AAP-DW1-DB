USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_activites_detail]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_activites_detail]
@User nvarchar(50) 
AS
     SET NOCOUNT ON;
    BEGIN
        DECLARE @TodayDayOfWeek INT;
        DECLARE @EndOfPrevWeek DATETIME;
        DECLARE @StartOfPrevWeek DATETIME;

        --get number of a current day (1-Monday, 2-Tuesday... 7-Sunday)
        SET @TodayDayOfWeek = DATEPART(dw, GETDATE());
        --get the last day of the previous week (last Sunday)
        SET @EndOfPrevWeek = CAST(DATEADD(dd, -@TodayDayOfWeek, GETDATE()) AS DATE);
        --get the first day of the previous week (the Monday before last)
        SET @StartOfPrevWeek = CAST(DATEADD(dd, -(@TodayDayOfWeek + 6), GETDATE()) AS DATE);
        SELECT CAST(a.actualend AS DATE) AS actualend,
               CASE
                   WHEN a.activitytypecode = 'appointment'
                   THEN 'Visit'
                   WHEN a.activitytypecode = 'incidentresolution'
                   THEN 'Case Resolution'
                   WHEN a.activitytypecode = 'bulkoperation'
                   THEN 'Quick Campaign'
                   WHEN a.activitytypecode = 'phonecall'
                   THEN 'Phone Call'
                   WHEN a.activitytypecode = 'task'
                   THEN 'Task'
                   WHEN a.activitytypecode = 'email'
                   THEN 'Email'
                   ELSE a.activitytypecode
               END AS activity, 
               a.owneridname, 
               a.regardingobjectidname, 
               a.subject,
			   a.description
        FROM DynamicsODS.dbo.CRM_Activities AS a
        WHERE CAST(a.actualend AS DATE) >= @StartOfPrevWeek
              AND CAST(a.actualend AS DATE) <= @EndOfPrevWeek
			  -- This clause identifies comleted
              AND a.statecode = 1
			  -- Removes the admin account 
              AND a.owneridname <> 'AAP Admin'
			  AND a.owneridname	= @User	
              AND a.activitytypecode <> 'opportunityclose'
			  AND a.subject	NOT LIKE 'Act-On Email%';
    END;
GO
