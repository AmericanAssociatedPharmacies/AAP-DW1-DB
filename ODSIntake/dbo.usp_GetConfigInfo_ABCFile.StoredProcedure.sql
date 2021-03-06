USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfigInfo_ABCFile]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_GetConfigInfo_ABCFile]

AS

SET NOCOUNT ON

BEGIN

	--Get values from Tues - Friday to copy weekly file
	DECLARE @Date DATETIME

	SET @Date = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))


	--Copy Monday's file
	SELECT dt.Source
	, dt.StagingDestination
	, dt.ArchiveDestination
	FROM(SELECT FilePath AS Source
		, CONVERT(VARCHAR(500), '\\fs1\Server\IT Department\ABC\' + LEFT(FileName, 3) + '_' +CAST(FORMAT(FileCreateTime, 'yyyyMMdd') AS VARCHAR(8)) + RIGHT(FileName, 4)) AS StagingDestination
		, CONVERT(VARCHAR(500), '\\fs1\Server\IT Department\ABC\Archive\' + LEFT(FileName, 3) + '_' +CAST(FORMAT(FileCreateTime, 'yyyyMMdd') AS VARCHAR(8)) + RIGHT(FileName, 4)) AS ArchiveDestination
		FROM [dbo].[mtvf_GetFileInfo]('\\apinetstore\shared\Denise\Sherrie\ABC')
		WHERE filename = 'ABC.TXT'
		--AND FileCreateTime >= @Date
		) AS dt

END



GO
