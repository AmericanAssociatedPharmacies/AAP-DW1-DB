USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[ups_RX30_RenameZippedFiles]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ups_RX30_RenameZippedFiles]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.CurrentFileName
	, dt.NewFileName
	FROM(SELECT FilePath AS CurrentFileName
			, CONVERT(VARCHAR(1000), FileDirectory + '\' + REPLACE(FileName, '.csv.gz', '.gz')) AS NewFileName
			FROM [dbo].[mtvf_GetFileInfo]('\\fs1.aap.local\Server\IT Department\RX30\Staging')
			WHERE FileName LIKE '%.csv.gz'
			) AS dt


END
GO
