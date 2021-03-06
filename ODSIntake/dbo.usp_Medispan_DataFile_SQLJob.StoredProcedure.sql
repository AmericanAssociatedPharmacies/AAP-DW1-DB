USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_DataFile_SQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Medispan_DataFile_SQLJob]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @LastFriday DATETIME
	, @RowCount INT 

	SELECT @LastFriday = DATEADD(d,-1-(DATEPART(dw,GETDATE()) % 7),GETDATE())

	SELECT @RowCount = COUNT(*)
	FROM(SELECT DISTINCT CONVERT(DATE, FileCreateTime) AS C1
			FROM [dbo].[mtvf_GetFileInfo]('\\AAPDW1\c$\Medispan\Staging\Data\MEDFV2\USAENG\DB\DELIMIT')
		) AS dt
	WHERE dt.C1 > @LastFriday

	IF @RowCount = 0
		BEGIN

		EXEC msdb.dbo.sp_stop_job N'Medispan DataFile ETL' ;  
		
		EXEC msdb.dbo.sp_send_dbmail      
		@recipients = 'scott.edwards@rxaap.com;yodi.haile@rxaap.com' 
		--@recipients = 'maxfriz1973@gmail.com' ----used for testing only
		, @body = 'There are no data files to load.'
		, @subject = 'Stopping Medispan Data File Load' 
		, @importance = 'high'

		END

	ELSE

		RETURN


END


GO
