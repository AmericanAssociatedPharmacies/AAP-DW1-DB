USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_BenLarson_MailFiles]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[usp_BenLarson_MailFiles]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @FileDir VARCHAR(1000)
	, @File VARCHAR(1000)

	SET @FileDir = '\\fs1\Server\IT Department\BenLarson'

	SELECT @File = dt.Source
	FROM(SELECT FilePath AS Source
		FROM ODSIntake.[dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%zip'
		) AS dt

		

	--Mail files
	EXEC msdb.dbo.sp_send_dbmail
		
		@recipients = 'ben@penpharmrx.com;DataServices@rxaap.com' 
		--@recipients = 'dave.bohler@rxaap.com'
		--@recipients = 'maxfriz1973@gmail.com' ----used for testing only 
		, @body = 'The attached file are API daily invoices.'
		, @subject = 'Daily Invoices' 
		, @file_attachments = @File;

END






GO
