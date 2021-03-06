USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_30DaysLastPurchase_Email]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_30DaysLastPurchase_Email]

	@Recipients VARCHAR(500)
	, @Body VARCHAR(500)
	, @Subject VARCHAR(500)
	, @FileAttachment VARCHAR(500)

AS

SET NOCOUNT ON;

BEGIN

	SET @Recipients = 'marketing@rxaap.com'

	EXEC msdb.dbo.sp_send_dbmail  
		@recipients = @Recipients
		, @body = @Body 
		, @subject = @Subject
		, @file_attachments = @FileAttachment

END

GO
