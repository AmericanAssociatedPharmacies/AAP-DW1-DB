USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Medispan_FTP_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Medispan_FTP_Config]

AS

SET NOCOUNT ON;

BEGIN



	SELECT dt.FTPRemoteDir
	, dt.LocalDir
	FROM(SELECT CONVERT(VARCHAR(500), '/Medispan/1407711049/*delimt*') AS FTPRemoteDir
		, CONVERT(VARCHAR(500), '\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload\Data\') As LocalDir

		UNION

		SELECT CONVERT(VARCHAR(500), '/Medispan/1407711049/*image*') AS FTPRemoteDir
		, CONVERT(VARCHAR(500), '\\fs1.aap.local\Server\IT Department\Medispan\FTPDownload\Images\') As LocalDir
		) AS dt


END
GO
