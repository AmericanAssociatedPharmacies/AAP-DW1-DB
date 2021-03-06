USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_RX30_SFTP_FileDownload_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RX30_SFTP_FileDownload_Config]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.Source
	, dt.Destination
	FROM(SELECT FilePath AS Source
		, CONVERT(VARCHAR(500), '\\fs1\g\IT Department\RX30\Staging\' + FileName) AS Destination
		FROM [dbo].[mtvf_GetFileInfo]('X:\rx30\sftp')
	) AS dt


END
GO
