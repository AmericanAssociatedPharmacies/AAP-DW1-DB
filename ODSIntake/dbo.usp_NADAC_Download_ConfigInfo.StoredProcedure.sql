USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_NADAC_Download_ConfigInfo]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_NADAC_Download_ConfigInfo]

AS

SET NOCOUNT ON;

BEGIN


	SELECT dt.URLDownload
	, cj.FileDestination
	FROM(SELECT 1 AS C1
		--, URLDownload
		, CONVERT(VARCHAR(1000), 'http://data.medicaid.gov/api/views/a4y5-998d/rows.csv?accessType=DOWNLOAD&bom=true&format=true') AS URLDownload
		FROM dbo.NADAC_Config
		) AS dt
	CROSS JOIN(SELECT 1 AS C1 
				, CONVERT(VARCHAR(500), '\\fs1.aap.local\Server\IT Department\NADAC\NADAC_' + CONVERT(VARCHAR, DateKey) + '.csv') AS FileDestination
				FROM Pricing.dbo.DateDim
				WHERE TheDate =  DATEADD(DAY, 0 ,DATEDIFF(DAY, 0 ,GETDATE()))
				) AS cj
	WHERE dt.C1 = cj.C1


END
GO
