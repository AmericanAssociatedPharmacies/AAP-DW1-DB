USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_UandC]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [test].[usp_rpt_UandC] @StartDate DATETIME
                                     , @EndDate   DATETIME
AS
BEGIN
SET NOCOUNT ON;
	SELECT dt.RxFilledDate
		, dt.PMID
		, dt.PharmacyName
		, dt.PrescriptionNumber
		, dt.BINNumber
		, dt.NDC
		, dt.ProductDescription
		, dt.QuantityDispensed
		, dt.UsualandCustomaryCharge
		, dt.RX30TotalPrice
		, dt.AWPDispensed
		, dt.NADACDispensed
	FROM
	(
		SELECT ed.DateOfService AS RxFilledDate
			, MAX(pd.PMID) AS PMID	--Gets the most up to date PMID for BIA accounts
			, MAX(pd.AccountName) AS PharmacyName
			, ed.PrescriptionNumber
			, ed.BINNumber
			, ed.NDC
			, dd.DrugName AS ProductDescription
			, ed.QuantityDispensed
			, FORMAT(cf.UsualandCustomaryCharge, 'C') AS UsualandCustomaryCharge
			, FORMAT(cf.TotalAmountPaid, 'C') AS RX30TotalPrice
			, FORMAT((dd.AWPPerDose * ed.QuantityDispensed), 'C') AS AWPDispensed
			, FORMAT((pf.NADACPricePerUnit * ed.QuantityDispensed), 'C') AS NADACDispensed
		FROM Rx30.dbo.EventDim AS ed
		INNER JOIN RX30.dbo.ClaimFact AS cf ON ed.EventKey = cf.EventKey
		INNER JOIN RX30.dbo.PharmacyDim AS pd ON cf.PharmacyKey = pd.PharmacyKey
		INNER JOIN (SELECT NDC, MAX(DrugKey) AS DrugKey, AWPPerDose, DrugName 
			FROM Rx30.dbo.DrugDim
			GROUP BY NDC, AWPPerDose, DrugName) AS dd ON ed.NDC = dd.NDC
		INNER JOIN RX30.dbo.DateDim AS di ON cf.DateKey = di.DateKey
		INNER JOIN (SELECT NDC, DrugName, MAX(DrugKey) AS DrugKey 
			FROM Pricing.dbo.DrugDim
			GROUP BY NDC, DrugName) AS pdd ON dd.NDC = pdd.NDC
		LEFT JOIN Pricing.dbo.PriceFact AS pf ON cf.DateKey = pf.DateKey AND pdd.DrugKey = pf.DrugKey
		WHERE di.TheDate >= @StartDate
		AND di.TheDate < DATEADD(dd, 1, @EndDate)
		GROUP BY ed.DateOfService, ed.PrescriptionNumber, ed.BINNumber, ed.NDC, dd.DrugName
		, cf.UsualandCustomaryCharge, cf.TotalAmountPaid, dd.AWPPerDose, ed.QuantityDispensed, pf.NADACPricePerUnit
	) AS dt
	WHERE dt.RX30TotalPrice = dt.UsualandCustomaryCharge
END;




GO
