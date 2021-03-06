USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_MapSambaDrive]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_MapSambaDrive]

AS

SET NOCOUNT ON;

BEGIN

	
	DECLARE @DriveBatchFile VARCHAR(1000)
	, @DriveLetter VARCHAR(1)
	, @MapSambaDrive VARCHAR(1000)

	--Set batchfile paths
	SET @DriveBatchFile = 'C:\DBA\DrivesOutputBatchFile.bat' 
	SET @MapSambaDrive = 'C:\DBA\MapSambaDrive.bat' 

	--Execute batch file to get existing drives on server
	EXEC master..xp_cmdshell @DriveBatchFile

	TRUNCATE TABLE ODSIntake.dbo.DrivesOutput

	--Bulk insert flat file from output from batch file
	BULK INSERT ODSIntake.dbo.vw_DrivesOutput
	FROM 'C:\DBA\DrivesOutput_2.txt'
	WITH(FIRSTROW = 2
			, DATAFILETYPE='widechar'
			)

	/*If the Samba drive, which should be mapped as X drive, doesn't exist, create it. If it already does, exit from this sproc. For whatever reason, the X drive does not always appear 
	under "This PC" in File Explorer. To verify that it does or does not exist, run the code down to the BULK INSERT statement.
	*/ 
	IF NOT EXISTS(SELECT 1
					FROM(SELECT LTRIM(RTRIM(REPLACE(C1, ':', ''))) AS DriveLetter
							FROM ODSIntake.dbo.vw_DrivesOutput
						) AS dt
					WHERE dt.DriveLetter = 'X'
					)

		BEGIN

			EXEC master..xp_cmdshell @MapSambaDrive
					

		END

	ELSE

		RETURN


END
GO
