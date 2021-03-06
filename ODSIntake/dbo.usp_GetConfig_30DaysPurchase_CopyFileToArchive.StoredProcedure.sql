USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfig_30DaysPurchase_CopyFileToArchive]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetConfig_30DaysPurchase_CopyFileToArchive]

	@FileDir VARCHAR(500)

AS

BEGIN

--SET @FileDir = '\\fs1\Server\IT Department\Marketing\30DayPurchase\'


	SELECT dt.Source
	, dt.Destination
	FROM(SELECT CONVERT(VARCHAR(500), FilePath) AS Source
		, CONVERT(VARCHAR(500),FileDirectory + '\Archive\' + FileName) AS Destination 
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	) AS dt

END
GO
