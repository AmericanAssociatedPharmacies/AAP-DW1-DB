USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReport_AllStores_AllCompliancePercent]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_ComplianceReport_AllStores_AllCompliancePercent]

			@StartDate DATE
			, @EndDate DATE

AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT


		SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),[FirstDayOfMonth],112) as INT) 
		FROM SalesDDS.dbo.DateDim
		WHERE TheDate = @StartDate

		SELECT @EndDateKey = CAST(CONVERT(VARCHAR(20),[FirstDayOfMonth],112) as INT) 
		FROM SalesDDS.dbo.DateDim
		WHERE TheDate =  @EndDate


	SELECT dt.PMID
	, dd.PharmacyName
	, CONVERT(DECIMAL(6,2),(dt.TotalPurchased/NULLIF(dt.TotalDispensed,0))) AS CompliancePercent 
	, CONVERT(DECIMAL(6,2),(dt.GenericPurchased/NULLIF(dt.GenericDispensed,0))) AS GenericCompliancePercent	
	, CONVERT(DECIMAL(6,2),(dt.BrandPurchased/NULLIF(dt.BrandDispensed,0))) AS BrandCompliancePercent	
	FROM(SELECT PMID
			,SUM(APIPurchasedAtIP + CAHPurchasedAtIP) as TotalPurchased
			,SUM(APIGenericPurchasedAtIP + CAHGenericPurchasedAtIP) as GenericPurchased
			,SUM(APIBrandPurchasedAtIP + CAHBrandPurchasedAtIP) as BrandPurchased
			,SUM(TotalDispensedIP) as TotalDispensed
			,SUM(GenericDispensedIP) as GenericDispensed 
			,SUM(BrandDispensedIP) as BrandDispensed 
			--, CONVERT(DECIMAL(6,2),AVG([CompliancePercent])) AS CompliancePercent	
			--, CONVERT(DECIMAL(6,2),AVG([GenericCompliancePercent])) AS GenericCompliancePercent	
			--, CONVERT(DECIMAL(6,2),AVG([BrandCompliancePercent])) AS BrandCompliancePercent				
			FROM Reports.[dbo].[ComplianceAllStores]
			WHERE DateKey BETWEEN @StartDateKey AND @EndDateKey
			AND PMID = (PMID + 0) -- Required for performance. DO NOT REMOVE!			
			GROUP BY PMID
		) AS dt
	INNER JOIN RXMaster.dbo.PharmacyDim AS dd ON dd.PMID = dt.PMID
	ORDER BY dt.PMID ASC


	

END





GO
