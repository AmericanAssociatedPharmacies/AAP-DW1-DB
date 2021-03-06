USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSQLJobData]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_GetSQLJobData]

	@FinalDate VARCHAR(25) 
	

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @p1 DATETIME
	
	SET @p1 = CONVERT(DATETIME, @FinalDate)

	SELECT CONVERT(VARCHAR(255), j.[name]) AS JobName
	, CONVERT(VARCHAR(255), s.step_name) AS JobStepName
	, h.step_id AS StepID
	, msdb.dbo.agent_datetime(run_date, run_time) AS 'RunDateTime'
	, CONVERT(INT, ((run_duration/10000*3600 + (run_duration/100)%100*60 + run_duration%100 + 31 ) / 60)) 
          as RunDurationMinutes
	, h.sql_severity
	, CONVERT(VARCHAR(8000), h.message) AS ErrorMessage
	, CONVERT(VARCHAR(255), h.server) AS ServerName
	, CONVERT(BIT, CASE
					WHEN h.message LIKE '%failed%' THEN 1
					ELSE 0
					END
			  ) AS IsError
	FROM msdb.dbo.sysjobhistory h  
	INNER JOIN msdb.dbo.sysjobs AS j  ON h.job_id = j.job_id  
	INNER JOIN msdb.dbo.sysjobsteps s ON j.job_id = s.job_id 
									AND h.step_id = s.step_id  
	--WHERE h.run_date > @FinalDate  
	WHERE msdb.dbo.agent_datetime(run_date, run_time) > @p1
	ORDER BY h.job_id ASC, h.instance_id ASC, h.step_id ASC, run_date ASC, run_time ASC


END


GO
