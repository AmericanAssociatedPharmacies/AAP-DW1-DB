USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_UandC_RSE_20200421]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_rpt_UandC_RSE_20200421] @StartDate DATETIME
                                     , @EndDate   DATETIME

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @StartDateKey INT
	, @EndDateKey INT

	SET @StartDateKey = CAST(CONVERT(VARCHAR(20),@StartDate,112) as INT)
	SET @EndDateKey = CAST(CONVERT(VARCHAR(20),@EndDate,112) as INT)


	SELECT DISTINCT dt.RxFilledDate
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
		SELECT CONVERT(DATE,di.TheDate) AS RxFilledDate
			, pd.PMID
			, pd.PharmacyName
			, ed.PrescriptionNumber
			, ed.BIN AS BINNumber
			, dd.NDC
			, dd.DrugName AS ProductDescription
			, cf.QuantityDispensed
			--, FORMAT(cf.UsualandCustomaryCharge, 'C') AS UsualandCustomaryCharge
			, FORMAT(cf.[UandC], 'C') AS UsualandCustomaryCharge
			--, FORMAT(cf.TotalAmountPaid, 'C') AS RX30TotalPrice
			, FORMAT(cf.[ClaimAmountPaid], 'C') AS RX30TotalPrice
			, FORMAT((dd.AWPPerDose * cf.QuantityDispensed), 'C') AS AWPDispensed
			, FORMAT(ISNULL((pf.NADACPricePerUnit * cf.QuantityDispensed),0.00), 'C') AS NADACDispensed
		--FROM ClaimsDDS.dbo.EventDim AS ed
		FROM ClaimsDDS.dbo.ClaimFactFDS AS cf
		INNER JOIN ClaimsDDS.dbo.EventDimFDS AS ed ON ed.EventKey = cf.EventKey
		INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON cf.PharmacyKey = pd.PharmacyKey
		INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON cf.DrugKey = dd.DrugKey
		--INNER JOIN (SELECT NDC, MAX(DrugKey) AS DrugKey, AWPPerDose, DrugName 
		--	FROM ClaimsDDS.dbo.DrugDim
		--	GROUP BY NDC, AWPPerDose, DrugName) AS dd ON ed.NDC = dd.NDC
		INNER JOIN ClaimsDDS.dbo.DateDim AS di ON cf.[DateofServiceKey] = di.DateKey
		--INNER JOIN (SELECT NDC, DrugName, MAX(DrugKey) AS DrugKey 
		--	FROM [Pricing].dbo.DrugDim
		--	GROUP BY NDC, DrugName) AS pdd ON dd.NDC = pdd.NDC
		LEFT JOIN [Pricing].dbo.PriceFact AS pf ON cf.[DateofServiceKey] = pf.DateKey AND dd.DrugKey = pf.DrugKey
		WHERE cf.[DateofServiceKey] BETWEEN @StartDateKey AND @EndDateKey
		AND cf.[ClaimAmountPaid] = cf.[UandC]
		AND pd.PMID > 0
		AND pd.PharmacyKey > 0
		AND dd.DrugKey > 0
		--WHERE di.TheDate >= @StartDate
		--AND di.TheDate < DATEADD(dd, 1, @EndDate)
		--GROUP BY ed.DateOfService, pd.AccountName, ed.PrescriptionNumber, ed.BINNumber, ed.NDC, dd.DrugName
		--, cf.UsualandCustomaryCharge, cf.TotalAmountPaid, dd.AWPPerDose, ed.QuantityDispensed, pf.NADACPricePerUnit
	) AS dt
	--WHERE dt.RX30TotalPrice = dt.UsualandCustomaryCharge
	ORDER BY dt.RXFilledDate ASC, dt.PMID ASC
END;

GO
