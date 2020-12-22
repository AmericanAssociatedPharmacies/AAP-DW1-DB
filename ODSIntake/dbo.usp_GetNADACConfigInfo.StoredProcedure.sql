USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetNADACConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetNADACConfigInfo]

	@FileDir VARCHAR(500)

AS

SET NOCOUNT ON;

BEGIN


	SELECT dt.FilePath
	FROM(SELECT FilePath
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
		) AS dt


END


GO
