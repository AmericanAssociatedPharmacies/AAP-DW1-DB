USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_MacAnalysis_New_RSE_20200505]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO















CREATE PROCEDURE [dbo].[usp_rpt_MacAnalysis_New_RSE_20200505] 

		@API_CAH   VARCHAR(3)
		, @StartDate DATETIME
		, @EndDate   DATETIME
AS

-- =============================================
-- Author:		<LeeAnn Carrell>
-- Create date: <10-25-2017>
-- Description:	<MAC Analysis V1.0.1 BETA>
-- Added CAHContract Type. Correct API Cust Net Price Calc. Correct CAH Rebate Calc to not apply rebates to PSB Excluded contract type.
-- Modified for the 3rd time on: 04-12-2018
-- Complete rewrite of sproc using table variables and UPDATE statements. Was able to reduce time to 40ish seconds.


SET NOCOUNT ON;
     
	 
BEGIN

	--Declare Variables
	DECLARE @StartDateKey INT, @EndDateKey INT;
	SET @StartDateKey = CAST(CONVERT(VARCHAR(20), @StartDate, 112) AS INT);
	SET @EndDateKey = CAST(CONVERT(VARCHAR(20), @EndDate, 112) AS INT);


	--DECLARE #T TABLE(RowID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY CLUSTERED
	--			, PharmacyKey                INT
	--			, DrugKey                    INT
	--			, BINNumber                  VARCHAR(25)
	--			, PrescriptionNumber         VARCHAR(25)
	--			, PayerName                  VARCHAR(250)
	--			, NDC                        VARCHAR(13) INDEX idx_NDC
	--			, DrugName                   VARCHAR(100)
	--			, DrugForm                   VARCHAR(4)
	--			, ProductDescription         VARCHAR(1000)
	--			, QuantityDispensed          INT
	--			, RXDateFilled               DATE
	--			, PMID                       INT
	--			, CAHContractType            VARCHAR(50)
	--			, PharmacyName               VARCHAR(100)
	--			, UsualandCustomaryCharge    MONEY
	--			, RX30TotalPrice             MONEY
	--			, RX30ReimbursedPricePerUnit MONEY
	--			, APICustomerNetPrice        MONEY
	--			, PackageSize                NUMERIC(8, 3)
	--			, CaseSize                   NUMERIC(37, 0)
	--			, Unit                       VARCHAR(2)
	--			, TotalPharmacyPaid          MONEY
	--			, APIPricePerUnit            MONEY
	--			, APILossGainPerUnit         MONEY
	--			, APILossGainPerDispensed    MONEY
	--			, CardinalCustomerNetPrice   MONEY
	--			, CAHPricePerUnit            MONEY
	--			, CAHLossGainPerUnit         MONEY
	--			, CAHLossGainPerDispensed    MONEY
	--			);

CREATE TABLE #T(RowID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY CLUSTERED
				, PharmacyKey                INT
				, DrugKey                    INT
				, BINNumber                  VARCHAR(25)
				, PrescriptionNumber         VARCHAR(25)
				, PayerName                  VARCHAR(250)
				, NDC                        VARCHAR(13) INDEX idx_NDC
				, DrugName                   VARCHAR(100)
				, DrugForm                   VARCHAR(4)
				, ProductDescription         VARCHAR(1000)
				, QuantityDispensed          INT
				, RXDateFilled               DATE
				, PMID                       INT
				, CAHContractType            VARCHAR(50)
				, PharmacyName               VARCHAR(100)
				, UsualandCustomaryCharge    MONEY
				, TotalPrice             MONEY
				, ReimbursedPricePerUnit MONEY
				, APICustomerNetPrice        MONEY
				, PackageSize                NUMERIC(8, 3)
				, CaseSize                   NUMERIC(37, 0)
				, Unit                       VARCHAR(2)
				, TotalPharmacyPaid          MONEY
				, APIPricePerUnit            MONEY
				, APILossGainPerUnit         MONEY
				, APILossGainPerDispensed    MONEY
				, CardinalCustomerNetPrice   MONEY
				, CAHPricePerUnit            MONEY
				, CAHLossGainPerUnit         MONEY
				, CAHLossGainPerDispensed    MONEY
				);
        
	INSERT INTO #T
	(PharmacyKey
	, DrugKey
	, BINNumber
	, PrescriptionNumber
	, PayerName
	, QuantityDispensed
	, RXDateFilled
	, UsualandCustomaryCharge
	, TotalPrice
	, ReimbursedPricePerUnit
	, TotalPharmacyPaid
	)

	SELECT DISTINCT
	pd.PharmacyKey
	, cf.DrugKey
	, ED.[BIN] AS BINNumber
	, ED.PrescriptionNumber
	, ed.[GroupNumber] AS PayerName
	, cf.QuantityDispensed
	, CONVERT(DATE, ED.[TransactionDate]) AS [RXDateFilled]
	, cf.UandC AS [UsualandCustomaryCharge]
	, CF.[ClaimAmountPaid] + ISNULL([CopayAmountPaid],0.00) + ISNULL([SalesTaxPaid],0.00) AS [TotalPrice]
	, CONVERT(MONEY, (CF.[ClaimAmountPaid] / cf.QuantityDispensed)) AS [ReimbursedPricePerUnit]
	, cf.[ClaimAmountPaid] AS [TotalPharmacyPaid]
	FROM ClaimsDDS.[dbo].[ClaimFactFDS] AS cf
	INNER JOIN ClaimsDDS.dbo.EventDimFDS AS ed ON cf.EventKey = ed.EventKey
	INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON cf.PharmacyKey = pd.PharmacyKey
	INNER JOIN ClaimsDDS.dbo.DrugDim AS d ON cf.DrugKey = d.DrugKey
	WHERE cf.[DateofServiceKey] >= @StartDateKey
	AND cf.[DateofServiceKey] < @EndDateKey
	AND cf.[ClaimAmountPaid] > 0
	AND cf.QuantityDispensed >= 1
	AND pd.PMID > 0
	AND d.DrugType LIKE '%GENERIC%'
	AND d.IsOTC = 0
	AND pd.APIStatusName = 'Active'
	AND pd.AAPQuitDate IS NOT NULL
    AND pd.AAPNumber IS NOT NULL
			
	--SELECT DISTINCT
	--pd.PharmacyKey
	--, cf.DrugKey
	--, ED.BINNumber
	--, ED.PrescriptionNumber
	--, ED.GroupID AS PayerName
	--, ED.QuantityDispensed
	--, CONVERT(DATE, ED.DateOfService) AS [RXDateFilled]
	--, [UsualandCustomaryCharge]
	--, CF.TotalPrice AS [RX30TotalPrice]
	--, CONVERT(MONEY, (CF.TotalPrice / ED.QuantityDispensed)) AS [RX30ReimbursedPricePerUnit]
	--, cf.OtherAmount AS [TotalPharmacyPaid]
	--FROM ClaimsDDS.dbo.ClaimFact AS CF
	--INNER JOIN ClaimsDDS.dbo.EventDim AS ed ON cf.EventKey = ed.EventKey
	--INNER JOIN(SELECT PMID
	--			, MAX(PharmacyKey) AS PharmacyKey
	--			FROM ClaimsDDS.dbo.PharmacyDim
	--			GROUP BY PMID
	--			) AS pd ON cf.PharmacyKey = pd.PharmacyKey
	--WHERE cf.DateKey >= @StartDateKey
	--AND cf.DateKey < @EndDateKey
	----AND ed.DateOfService >= @StartDate
	----AND ed.DateOfService < @EndDate
	--AND cf.TotalPrice > 0
	--AND ED.QuantityDispensed >= 1
	--AND EXISTS(SELECT 1
	--			FROM Pricing.dbo.DrugDim AS DD
	--			WHERE ED.NDC = DD.NDC
	--			AND dd.DrugType LIKE '%GENERIC%'
	--			AND dd.IsOTC = 0
	--			)
	--AND EXISTS(SELECT 1
	--			FROM ClaimsDDS.dbo.PharmacyDim AS pd
	--			WHERE cf.PharmacyKey = pd.PharmacyKey
	--			AND pd.PMID > 0
	--			)
	--AND EXISTS(SELECT 1
	--			FROM PharmacyMaster.dbo.PM_Pharmacy AS p
	--			WHERE pd.PMID = p.PMID
	--			AND p.APIStatus = 'Active'
	--			AND (p.AAPQuitDate IS NULL
	--				AND p.AAPAccountNo IS NOT NULL
	--				)
	--			);

    UPDATE #T
    SET
        NDC = dd.NDC
        , DrugName = dd.DrugName
        , DrugForm = dd.Form
        , PackageSize = dd.PackageSize
    FROM #T AS x
        LEFT OUTER JOIN ClaimsDDS.dbo.DrugDim AS dd ON x.DrugKey = dd.DrugKey;
         
	UPDATE #T
    SET CaseSize = dm.CSP
        , Unit = dm.Unit
        , ProductDescription = dd2.Description
    FROM #T AS x
        LEFT OUTER JOIN Medispan.dbo.DrugMaster AS DM ON DM.NDC = x.NDC
        LEFT OUTER JOIN DrugMaster.dbo.DrugDim AS dd2 ON x.NDC = dd2.NDC;
         
	UPDATE #T
    SET PMID = p.PMID
        , PharmacyName = p.AccountName
    FROM #T AS x
        INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
        INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON pd.PMID = p.PMID;
         
	UPDATE #T
    SET CAHContractType = cdd.CAHContractType
	, APICustomerNetPrice = pf.APICustomerNetPrice
	, CardinalCustomerNetPrice = CASE
									WHEN cdd.CAHContractType = 'PSB EXCLUDED'
									THEN(pf.CardinalInvoicePrice)
									ELSE(pf.CardinalInvoicePrice * .78)
								END
	, CAHPricePerUnit = CASE
							WHEN cdd.CAHContractType = 'PSB EXCLUDED'
							THEN CONVERT(MONEY, ((pf.CardinalInvoicePrice) / (PackageSize * CaseSize)))
							ELSE CONVERT(MONEY, ((pf.CardinalInvoicePrice * .78) / (PackageSize * CaseSize)))
						END
	, CAHLossGainPerUnit = CASE
							WHEN cdd.CAHContractType = 'PSB EXCLUDED'
							THEN CONVERT(MONEY, (TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice) / (PackageSize * CaseSize)))
							ELSE CONVERT(MONEY, (TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice * .78) / (PackageSize * CaseSize)))
						END
	, CAHLossGainPerDispensed = CASE
									WHEN cdd.CAHContractType = 'PSB EXCLUDED'
									THEN CONVERT(MONEY, ((TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice) / (PackageSize * CaseSize))) * QuantityDispensed)
									ELSE CONVERT(MONEY, ((TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice * .78) / (PackageSize * CaseSize))) * QuantityDispensed)
								END
	FROM #T AS x
		INNER JOIN Pricing.dbo.CompetitorDrugDim AS cdd ON x.NDC = cdd.NDC
		INNER JOIN Pricing.dbo.PriceFact AS pf ON cdd.CompetitorDrugKey = pf.CompetitorDrugKey
												AND cdd.DateKey = pf.DateKey
    WHERE cdd.[CAHContractType] IN('AAP SOURCE', 'AAP SOURCE BACKUP', 'AAP TOP-GENERICS SOURCE', 'PSB EXCLUDED')
        AND cdd.DateKey >= @StartDateKey
        AND cdd.DateKey < @EndDateKey
        AND pf.DateKey >= @StartDateKey
        AND pf.DateKey < @EndDateKey;
         
	UPDATE #T
    SET
        APIPricePerUnit = CONVERT(MONEY, (APICustomerNetPrice / (PackageSize * CaseSize)))
        , APILossGainPerUnit = CONVERT(MONEY, (TotalPrice / QuantityDispensed) - (APICustomerNetPrice / (PackageSize * CaseSize)))
        , APILossGainPerDispensed = CONVERT(MONEY, ((TotalPrice / QuantityDispensed) - (APICustomerNetPrice / (PackageSize * CaseSize))) * QuantityDispensed);


    SELECT BINNumber
        , PrescriptionNumber
        , PayerName
        , NDC
        , DrugName
        , DrugForm
        , ProductDescription
        , QuantityDispensed
        , RXDateFilled
        , PMID
        , CAHContractType
        , PharmacyName
        , UsualandCustomaryCharge
        , TotalPrice
        , ReimbursedPricePerUnit
        , APICustomerNetPrice
        , PackageSize
        , CaseSize
        , Unit
        , TotalPharmacyPaid
        , APIPricePerUnit
        , APILossGainPerUnit
        , APILossGainPerDispensed
        , CardinalCustomerNetPrice
        , CAHPricePerUnit
        , CAHLossGainPerUnit
        , CAHLossGainPerDispensed
    FROM #T
    WHERE IIF(@API_CAH = 'API', APILossGainPerUnit, CAHLossGainPerUnit) < 0;
     END;





GO
