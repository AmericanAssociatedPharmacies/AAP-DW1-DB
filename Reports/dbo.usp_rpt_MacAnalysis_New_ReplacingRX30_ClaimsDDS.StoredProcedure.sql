USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_MacAnalysis_New_ReplacingRX30_ClaimsDDS]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_rpt_MacAnalysis_New_ReplacingRX30_ClaimsDDS] 

		@API_CAH   VARCHAR(3)
		, @StartDate DATETIME
		, @EndDate   DATETIME

AS

SET NOCOUNT ON;
     
	 
BEGIN

	--Declare Variables
	DECLARE @StartDateKey INT, @EndDateKey INT;
	SET @StartDateKey = CAST(CONVERT(VARCHAR(20), @StartDate, 112) AS INT);
	SET @EndDateKey = CAST(CONVERT(VARCHAR(20), @EndDate, 112) AS INT);



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
				, RX30TotalPrice             MONEY
				, RX30ReimbursedPricePerUnit MONEY
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

	CREATE NONCLUSTERED INDEX nci_foo_1 ON #T (PharmacyKey, DrugKey, PMID);
        
	INSERT INTO #T
	(PharmacyKey
	, DrugKey
	, BINNumber
	, PrescriptionNumber
	, PayerName
	, QuantityDispensed
	, RXDateFilled
	, UsualandCustomaryCharge
	, RX30TotalPrice
	, RX30ReimbursedPricePerUnit
	, TotalPharmacyPaid
	, NDC
	, DrugName
	, DrugForm
	, PackageSize
	, PMID
	)

	SELECT PharmacyKey
	, DrugKey
	, BINNumber
	, PrescriptionNumber
	, PayerName
	, QuantityDispensed
	, [RXDateFilled]
	, [UsualandCustomaryCharge]
	, [RX30TotalPrice]
	, [RX30ReimbursedPricePerUnit]
	, [TotalPharmacyPaid]
	, NDC
	, DrugName
	, DrugForm
	, PackageSize
	, PMID
	FROM ClaimsDDS.dbo.vwMACAnalysis WITH(NOEXPAND)
	WHERE DateOfServiceKey >= @StartDateKey
	AND DateOfServiceKey < @EndDateKey
			
	--SELECT DISTINCT
	--pd.PharmacyKey
	--, cf.DrugKey
	--, ED.BINNumber
	--, ED.PrescriptionNumber
	--, ED.GroupID AS PayerName
	--, CF.QuantityDispensed
	--, CONVERT(DATE, ED.DateOfService) AS [RXDateFilled]
	--, [UsualandCustomaryCharge]
	--, CF.TotalPrice AS [RX30TotalPrice]
	--, CONVERT(MONEY, (CF.TotalPrice / CF.QuantityDispensed)) AS [RX30ReimbursedPricePerUnit]
	--, cf.OtherAmount AS [TotalPharmacyPaid]
	--FROM [ClaimsDDS].[dbo].[ClaimFactRX30] AS CF
	--INNER JOIN [ClaimsDDS].[dbo].[EventDimRX30] AS ED ON CF.EventKey = ED.EventKey
	--INNER JOIN(SELECT PMID
	--			, PharmacyKey
	--			--, MAX(PharmacyKey) AS PharmacyKey
	--			FROM [ClaimsDDS].[dbo].[PharmacyDim]
	--			WHERE PMID > 0
	--			AND APIStatusName = 'Active'
	--			AND AAPQuitDate IS NULL				
	--			AND AAPNumber IS NOT NULL	
	--			--GROUP BY PMID
	--			) AS pd ON cf.PharmacyKey = pd.PharmacyKey
	--INNER JOIN ClaimsDDS.dbo.DrugDim AS dd ON cf.DrugKey = dd.DrugKey
	--WHERE cf.DateOfServiceKey >= @StartDateKey
	--AND cf.DateOfServiceKey < @EndDateKey
	--AND cf.TotalPrice > 0
	--AND CF.QuantityDispensed >= 1
	--AND dd.DrugType LIKE '%GENERIC%'
	--AND dd.IsOTC = 0

    --UPDATE x
    --SET
    --    NDC = dd.NDC
    --    , DrugName = dd.DrugName
    --    , DrugForm = dd.Form
    --    , PackageSize = dd.PackageSize
    --FROM #T AS x
    --INNER JOIN [ClaimsDDS].[dbo].[DrugDim] AS dd ON x.DrugKey = dd.DrugKey;
         
	UPDATE x
    SET CaseSize = dm.CSP
        , Unit = dm.Unit
        , ProductDescription = dd2.Description
    FROM #T AS x
    INNER JOIN Medispan.dbo.DrugMaster AS DM ON DM.NDC = x.NDC
    INNER JOIN DrugMaster.dbo.DrugDim AS dd2 ON x.NDC = dd2.NDC;
         
	UPDATE x
	SET PharmacyName = pd.PharmacyName
    --SET PMID = p.PMID
    --    , PharmacyName = p.AccountName
    FROM #T AS x
    INNER JOIN [ClaimsDDS].[dbo].[PharmacyDim] AS pd ON x.PharmacyKey = pd.PharmacyKey
    --INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON pd.PMID = p.PMID;
         
	UPDATE x
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
							THEN CONVERT(MONEY, (RX30TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice) / (PackageSize * CaseSize)))
							ELSE CONVERT(MONEY, (RX30TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice * .78) / (PackageSize * CaseSize)))
						END
	, CAHLossGainPerDispensed = CASE
									WHEN cdd.CAHContractType = 'PSB EXCLUDED'
									THEN CONVERT(MONEY, ((RX30TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice) / (PackageSize * CaseSize))) * QuantityDispensed)
									ELSE CONVERT(MONEY, ((RX30TotalPrice / QuantityDispensed) - ((pf.CardinalInvoicePrice * .78) / (PackageSize * CaseSize))) * QuantityDispensed)
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
        , APILossGainPerUnit = CONVERT(MONEY, (RX30TotalPrice / QuantityDispensed) - (APICustomerNetPrice / (PackageSize * CaseSize)))
        , APILossGainPerDispensed = CONVERT(MONEY, ((RX30TotalPrice / QuantityDispensed) - (APICustomerNetPrice / (PackageSize * CaseSize))) * QuantityDispensed);


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
        , RX30TotalPrice
        , RX30ReimbursedPricePerUnit
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


END



GO
