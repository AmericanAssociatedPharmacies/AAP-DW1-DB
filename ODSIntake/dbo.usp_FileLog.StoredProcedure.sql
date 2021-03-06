USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_FileLog]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_FileLog]

	@FileName VARCHAR(1000)
	, @Process VARCHAR(250)
	, @FileDownloadDateTime DATETIME = NULL
	, @IsRawFileLoaded BIT = NULL


AS

SET NOCOUNT ON;

BEGIN


	INSERT INTO dbo.FileLog(FileName, DownloadDateTime, Process, [IsRawFileLoaded])
	VALUES (@FileName, ISNULL(@FileDownloadDateTime, GETDATE()), @Process, ISNULL(@IsRawFileLoaded, 0))



END



GO
