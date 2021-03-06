USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConfig_BenLarsen_EmailFile]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetConfig_BenLarsen_EmailFile]

	@FileDir VARCHAR(500)

AS

BEGIN

--SET @FileDir = '\\fs1\Server\IT Department\Marketing\30DayPurchase\'


	SELECT dt.Source
	, dt.Recipients
	, dt.Body
	, dt.Subject
	, dt.FileAttachment
	FROM(SELECT CONVERT(VARCHAR(500), FilePath) AS Source
		, CONVERT(VARCHAR(500), 'scott.edwards@rxaap.com') AS Recipients
		, CONVERT(VARCHAR(500), 'Export') AS Subject
		, CONVERT(VARCHAR(500), 'Please find attached the Excel file.') AS Body
		, CONVERT(VARCHAR(500), FilePath) AS FileAttachment
		FROM [dbo].[mtvf_GetFileInfo](@FileDir)
	) AS dt

END

GO
