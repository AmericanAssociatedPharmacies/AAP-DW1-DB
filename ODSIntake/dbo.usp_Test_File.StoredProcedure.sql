USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Test_File]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


----S:\IT Department\API\Test

--SET @FileDir = '\\fs1\Server\IT Department\API\Test'


CREATE PROCEDURE [dbo].[usp_Test_File]

	@FileDir VARCHAR(1000)

AS

SET NOCOUNT ON

BEGIN

	DECLARE @FileCount INT

	SELECT @FileCount = COUNT(*)
	FROM [dbo].[mtvf_GetFileInfo](@FileDir)

	SELECT @FileCount

	IF @FileCount = 0
		BEGIN

			--Send email notification
			EXEC msdb.dbo.sp_send_dbmail  
			 @recipients = 'scott.edwards@rxaap.com'
			 , @body = 'No API Inventory Files were downloaded from the SFTP server. Please contact the Help Desk.'
			 , @subject = 'No API Inventory Files' 	
			 , @importance = 'High'

			 --Stop this SQL Job
			EXEC msdb.dbo.sp_stop_job N'SQL FIle Test'


		END

	ELSE IF @FileCount > 0
	BEGIN

		RETURN

	END
		

END
GO
