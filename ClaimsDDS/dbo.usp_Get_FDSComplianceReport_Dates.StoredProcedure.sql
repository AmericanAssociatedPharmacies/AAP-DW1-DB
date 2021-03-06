USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Get_FDSComplianceReport_Dates]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_Get_FDSComplianceReport_Dates]

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @T TABLE(DateKey INT)

	--Get dates not in SalesFact table
	INSERT INTO @T(DateKey)
	SELECT ca.DateKey
	FROM(SELECT DISTINCT CAST(CONVERT(VARCHAR(20), DATEADD(day, -366, DATEADD(d, 0, DATEDIFF(d, 0, GETDATE()))), 112) AS INT) AS StartDateKey
			, CAST(CONVERT(VARCHAR(20), GETDATE(), 112) AS INT) AS EndDateKey
			FROM SalesDDS.dbo.DateDim
			) AS dt
	CROSS APPLY SalesDDS.dbo.DateDim AS ca
	WHERE ca.DateKey BETWEEN dt.StartDateKey AND dt.EndDateKey
	ORDER BY ca.DateKey ASC
	
	-- Truncate table and reload to get dates to load
	TRUNCATE TABLE [dbo].[FDSComplianceReportDatesToLoad]

	INSERT INTO [dbo].[FDSComplianceReportDatesToLoad](RN, DateKey)
	SELECT ca.RN
	, ca.DateKey
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY DateKey ASC) AS RN
			, DateKey
			FROM @T
		) AS dt
	CROSS APPLY(SELECT CASE
						WHEN dt.RN % 3 = 1 THEN 1
						WHEN dt.RN % 3 = 2 THEN 2
						ELSE 3
						END AS RN
				, DateKey
				FROM @T
				) AS ca
	WHERE dt.DateKey = ca.DateKey


	UPDATE STATISTICS [dbo].[FDSComplianceReportDatesToLoad]

	SELECT RN, DateKey
	FROM [dbo].[FDSComplianceReportDatesToLoad]

END






































GO
