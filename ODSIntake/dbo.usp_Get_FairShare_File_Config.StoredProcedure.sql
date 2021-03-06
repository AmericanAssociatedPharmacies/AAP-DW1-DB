USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Get_FairShare_File_Config]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Get_FairShare_File_Config]

	@FileDir VARCHAR(1000)
	

AS


SET NOCOUNT ON;


BEGIN

	SELECT dt.Source
	, dt.DateKey
	FROM(SELECT FilePath AS Source
		, CONVERT(INT, REPLACE(RIGHT(FileName, 12), '.csv', '')) AS DateKey
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		WHERE FileName LIKE '%FairShare%'
		AND FileName LIKE '%.csv'
		) AS dt

END

GO
