USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceComparison_Load]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_PriceComparison_Load]

AS

SET NOCOUNT ON;

BEGIN

	--TRUNCATE TABLE
	TRUNCATE TABLE [Archive].[PriceCompare_RSE_20170815]

	---Archive current data
	ALTER TABLE [dbo].[PriceCompare_RSE_20170815]
	SWITCH TO [Archive].[PriceCompare_RSE_20170815]

	DECLARE @DateKey INT

	SELECT @DateKey = MAX(DateKey)
	FROM dbo.CompetitorDrugDim
	WHERE API_ItemNumber IS NOT NULL
	AND CAHItemNumber IS NOT NULL
	--AND ABCItemNumber IS NOT NULL

	--Load current date
	INSERT INTO Pricing.[dbo].[PriceCompare_RSE_20170815]
			(GPI
				, API_NDC
				, CAH_NDC
				, ABC_NDC
				, DrugName
				, API_ItemNumber
				, API_PackageSize
				, [APICustomerInvoicePrice]
				, APICustomerNetPrice
				, API_Manufacturer
				, CardinalInvoicePrice
				, CardinalPackageSize
				, CAH_Manufacturer
				, ABCInvoicePrice
				, ABCPackageSize
				, ABC_Manufacturer
				, IsCAHContract
				)


	SELECT dt.GPI
	, dt.API_NDC
	, cah.CAH_NDC
	, abc.ABC_NDC
	, dt.DrugName
	, dt.API_ItemNumber
	, dt.API_PackageSize
	, dt.[APICustomerInvoicePrice]
	, dt.APICustomerNetPrice
	, dt.API_Manufacturer
	, cah.CardinalInvoicePrice
	, cah.CardinalPackageSize
	, cah.CAH_Manufacturer
	, abc.ABCInvoicePrice
	, abc.ABCPackageSize
	, abc.ABC_Manufacturer
	, cah.IsCAHContract
	FROM(SELECT DISTINCT dd.NDC AS API_NDC
			, cdd.API_ItemNumber
			, dd.GPI
			, dd.[DrugName]
			, dd.[PackageSize] AS API_PackageSize
			, pf.APICustomerInvoicePrice
			, pf.APICustomerNetPrice
			, dd.Manufacturer AS API_Manufacturer
			FROM dbo.CompetitorDrugDim AS cdd
			INNER JOIN Pricing.dbo.DrugDim AS dd ON cdd.NDC = dd.NDC
			INNER JOIN dbo.PriceFact AS pf ON cdd.CompetitorDrugKey= pf.CompetitorDrugKey
												AND cdd.DateKey = pf.DateKey
												AND dd.DrugKey = pf.DrugKey
			WHERE dd.IsOTC = 0
			AND cdd.DateKey =  @DateKey
			AND pf.DateKey = @DateKey
			AND dd.DrugType LIKE '%GENERIC%'
			AND pf.APICustomerInvoicePrice IS NOT NULL
			) AS dt
	INNER JOIN(SELECT DISTINCT cdd.NDC AS CAH_NDC
				, dd.PackageSize AS CardinalPackageSize
				, pf.CardinalInvoicePrice
				, dd.Manufacturer AS CAH_Manufacturer
				, dd.GPI
				, CONVERT(BIT, CASE
					WHEN cdd.CAHContractType LIKE '%[a-zA-Z0-9]%' THEN 1
					ELSE 0
					END
					) AS IsCAHContract
				FROM dbo.CompetitorDrugDim AS cdd 
				INNER JOIN dbo.DrugDim AS dd ON dd.NDC= cdd.NDC
				INNER JOIN dbo.PriceFact AS pf ON cdd.DateKey = pf.DateKey
													AND cdd.CompetitorDrugKey =  pf.CompetitorDrugKey
													AND dd.DrugKey = pf.DrugKey
				WHERE dd.IsOTC = 0
				AND cdd.DateKey =  @DateKey
				AND pf.DateKey = @DateKey
				AND dd.DrugType LIKE '%GENERIC%'
				AND pf.CardinalInvoicePrice IS NOT NULL
				) AS cah ON dt.GPI = cah.GPI
	INNER JOIN(SELECT DISTINCT cdd.NDC AS ABC_NDC
				, dd.PackageSize AS ABCPackageSize
				, dd.GPI
				, pf.ABCInvoicePrice
				, dd.Manufacturer AS ABC_Manufacturer
				FROM dbo.CompetitorDrugDim AS cdd
				INNER JOIN dbo.DrugDim AS dd ON cdd.NDC = dd.NDC
				INNER JOIN dbo.PriceFact AS pf ON cdd.CompetitorDrugKey = pf.CompetitorDrugKey
												AND cdd.DateKey = pf.DateKey
												AND dd.DrugKey = pf.DrugKey
				WHERE dd.IsOTC = 0
				AND cdd.DateKey =  @DateKey
				AND pf.DateKey = @DateKey
				AND dd.DrugType LIKE '%GENERIC%'
				AND pf.ABCInvoicePrice IS NOT NULL
				) AS abc ON dt.GPI = abc.GPI 
							AND cah.GPI = abc.GPI													
ORDER BY GPI ASC, dt.API_NDC ASC, CAH_NDC ASC, ABC_NDC ASC

	
/************************************OLD CODE**********************************************************************/
	--SELECT DISTINCT
	--dt.GPI
	--, dt.API_NDC
	--, cah.CAH_NDC
	--, abc.ABC_NDC
	--, dt.DrugName
	--, dt.API_ItemNumber
	--, dt.API_PackageSize
	--, dt.[APICustomerInvoicePrice]
	--, dt.APICustomerNetPrice
	--, dt.API_Manufacturer
	--, cah.CardinalInvoicePrice
	--, cah.CardinalPackageSize
	--, cah.CAH_Manufacturer
	--, abc.ABCInvoicePrice
	--, abc.ABCPackageSize
	--, abc.ABC_Manufacturer
	--, cah.IsCAHContract
	--FROM(SELECT dd.NDC AS API_NDC
	--		, ac.API_ItemNumber
	--		, dd.GPI
	--		, dd.[DrugName]
	--		, [PackageSize] AS API_PackageSize
	--		, ac.APICustomerInvoicePrice
	--		, ac.APICustomerNetPrice
	--		, dd.Manufacturer AS API_Manufacturer
	--		, MAX(ac.DateKey) AS MaxDateKey
	--		FROM ODSINtake.[dbo].[vwAPIPricing] AS ac
	--		INNER JOIN Pricing.dbo.DrugDim AS dd ON ac.NDC = dd.NDC
	--		WHERE IsOTC = 0
	--		AND DrugType LIKE '%GENERIC%'
	--		GROUP BY dd.[NDC], ac.API_ItemNumber, dd.GPI, dd.[DrugName], dd.PackageSize, [APINetPrice]
	--		, ac.APICustomerInvoicePrice, ac.APICustomerNetPrice, dd.Manufacturer
	--			  ) AS dt
	--INNER JOIN(SELECT cc.NDC AS CAH_NDC
	--			, dm.PS AS CardinalPackageSize
	--			, CardinalInvoicePrice
	--			, dm.MFG AS CAH_Manufacturer
	--			, x.GPI
	--			, CONVERT(BIT, CASE
	--				WHEN cc.ContractType LIKE '%[a-zA-Z0-9]%' THEN 1
	--				ELSE 0
	--				END
	--				) AS IsCAHContract
	--			, MAX(DateKey) AS C1 
	--			FROM ODSIntake.dbo.vwCardinalCatalog AS cc
	--			INNER JOIN [Pricing].[dbo].[GPINDCXRef] AS x ON cc.NDC = x.NDC
	--			INNER JOIN Medispan.dbo.DrugMaster AS dm ON dm.NDC= cc.NDC
	--			GROUP BY cc.NDC, dm.PS, CardinalInvoicePrice, dm.MFG, x.GPI, cc.ContractType
	--			) AS cah ON dt.GPI = cah.GPI
	--INNER JOIN(SELECT abc.NDC AS ABC_NDC
	--			, dm.PS AS ABCPackageSize
	--			, x.GPI
	--			, ABCInvoicePrice
	--			, dm.MFG AS ABC_Manufacturer
	--			, MAX(DateKey) AS MaxDateKey
	--			FROM Pricing.Staging.vwABC AS abc
	--			INNER JOIN [Pricing].[dbo].[GPINDCXRef] AS x ON abc.NDC = x.NDC
	--			INNER JOIN Medispan.dbo.DrugMaster AS dm ON abc.NDC = dm.NDC
	--			GROUP BY abc.NDC, dm.PS, x.GPI, abc.ABCInvoicePrice, dm.MFG
	--		   ) AS abc ON dt.GPI = abc.GPI AND cah.GPI = abc.GPI
	--ORDER BY GPI ASC, dt.API_NDC ASC, CAH_NDC ASC, ABC_NDC ASC


	--Update stats
	UPDATE STATISTICS [dbo].[PriceCompare_RSE_20170815]

END



GO
