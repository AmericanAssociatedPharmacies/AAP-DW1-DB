USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_SQLJobReport]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_SQLJobReport]
	
	 @IsError BIT = 1

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @tableHTML  NVARCHAR(MAX) 
	, @StartDateReport VARCHAR(20)
	, @EndDateReport VARCHAR(20)
	, @RowCount INT
	, @Recepients VARCHAR(500)
	, @StartDate DATETIME
	, @EndDate DATETIME

	--Set email recepient for report
	SET @Recepients = 'scott.edwards@rxaap.com;yodi.haile@rxaap.com'
	
	--Unless date parameters are passed in, this sproc will execute for the current date and set the datetime values from Sunday to Saturday.
	SET @StartDate = ISNULL(@StartDate, DATEADD(wk, DATEDIFF(wk, 7, CURRENT_TIMESTAMP), 7))
	SET @EndDate = ISNULL(@EndDate, DATEADD(wk, DATEDIFF(wk, 6, CURRENT_TIMESTAMP), 6 + 7))

		--Format dates for HTML report
	SET @StartDateReport = CONVERT(VARCHAR(20), FORMAT(@StartDate, 'MM/dd/yyyy', 'en-US'))
	SET @EndDateReport = CONVERT(VARCHAR(20), FORMAT(@EndDate, 'MM/dd/yyyy', 'en-US'))


		--#FFFFE0
		--#BDB76B

		SET @tableHTML =  
			N'<table style="background-color:#FFFFE0;"><tr style="background-color:#00004c;color:#ffffff;">'+
			N'<H1>SQL Job Error Report: ' + @StartDateReport + ' - ' + @EndDateReport +'</H1>' +  
			N'<table border="1">' +  
			--N'<table style="width:100%;text-align:left;border-collapse:collapse;background-color:gold;">'+
			--N'<tr style="background-color:blue;color:white;">' +
			N'<tr><th>ServerName</th><th>JobName</th>' +  
			N'<th>JobStepName</th><th>StepID</th><th>RunDateTime</th><th>RunDurationInMinutes</th>' +  
			N'<th>SQLServerity</th><th>ErrorMessage</th></tr>' +  
			CAST ( ( SELECT td = ServerName, '',
					td = JobName , '',
					 td = JobStepName , '',
					 td = StepID, '',
					 td = CONVERT(VARCHAR(25), RunDateTime, 121), '',
					 td = RunDurationInMinutes, '',
					 td = SQLSeverity, '',
					 td = ErrorMessage
					FROM [dbo].[SQLJobHistory]
					WHERE RunDateTime >= @StartDate
					AND RunDateTime < @EndDate
					AND [IsError] = ISNULL(@IsError, [IsError])
					  FOR XML PATH('tr'), TYPE   
			) AS NVARCHAR(MAX) ) +  
			N'</table>' ;  

	
		EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = 'AAPDW1 mail',
			@recipients= @Recepients,  
			@subject = 'SQL Job Report',  
			@body = @tableHTML,  
			@body_format = 'HTML' ;  


END





GO
