USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFactFDS_Update]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [Staging].[usp_ClaimFactFDS_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	--DO NOT REMOVE!!!
	UPDATE STATISTICS [Staging].[ClaimFactFDS]
	UPDATE STATISTICS Pricing.[dbo].[PriceFact] 
	UPDATE STATISTICS Pricing.[dbo].[CompetitorDrugDim]	
	UPDATE STATISTICS dbo.DrugDim;
	
	--Dispensed revenue
	UPDATE x
	SET [DispensedRevenue] = CONVERT(MONEY, x.[ClaimAmountPaid] + x.[CopayAmountPaid] + x.[OtherAmountPaid] + x.[eVoucherAmountPaid])
	FROM [Staging].[ClaimFactFDS] AS x

	--Brand Cost
	UPDATE t
	SET BrandCost = ISNULL(s.BrandCost, 0.00)
	FROM [Staging].[ClaimFactFDS] AS t
	INNER JOIN(SELECT DISTINCT x.DateofServiceKey
			, x.PharmacyKey
			, x.DrugKey
			, x.EventKey
			, CONVERT(MONEY, f.CardinalInvoicePrice - (f.CardinalInvoicePrice * cah.CAH_COG_Brand_Percent)) AS BrandCost
				FROM [Staging].[ClaimFactFDS] AS x
				INNER JOIN(SELECT DrugKey, NDC
							FROM dbo.DrugDim 
							WHERE [IsCAHGeneric] = 0
							) AS dd ON x.Drugkey = dd.Drugkey
				INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
				INNER JOIN Pricing.[dbo].[PriceFact] AS f ON x.DateofServiceKey = f.DateKey													
				INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
																		AND c.CAH_NDC = dd.NDC
				INNER JOIN(SELECT u.new_pmid AS PMID, (cah.[new_cah_cog]/100) AS CAH_COG_Brand_Percent
							FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity] AS c ON u.Userkey = c.UserKey
							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS cah ON cah.[CAHKey] = c.CAHKey
							WHERE cah.[new_cah_cog] IS NOT NULL
							) AS cah ON cah.PMID = pd.PMID	
				--CROSS APPLY(SELECT f.DateKey, [CAH_NDC], CONVERT(MONEY, f.CardinalInvoicePrice - (f.CardinalInvoicePrice * cah.CAH_COG_Brand_Percent)) AS BrandCost
				--			FROM Pricing.[dbo].[PriceFact] AS f
				--			INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
				--			WHERE c.[CAH_NDC] IS NOT NULL
				--			AND x.DateofServiceKey = f.DateKey
				--			) AS ca
				--WHERE dd.[IsCAHGeneric] = 0
				--AND ca.DateKey = x.DateofServiceKey
				--AND ca.CAH_NDC = dd.NDC
		        ) AS s ON s.DateofServiceKey = t.DateofServiceKey
						AND s.PharmacyKey = t.PharmacyKey 
						AND s.DrugKey = t.DrugKey 
						AND s.EventKey = t.EventKey
 

	--SPXCost
	UPDATE t
	SET SPXCost = ISNULL(s.SPXCost,0.00)
	FROM [Staging].[ClaimFactFDS] AS t
	INNER JOIN(SELECT DISTINCT x.DateofServiceKey
			, x.PharmacyKey
			, x.DrugKey
			, x.EventKey
			, CONVERT(MONEY,f.CardinalInvoicePrice - (f.CardinalInvoicePrice * 0.025)) AS SPXCost
				FROM [Staging].[ClaimFactFDS] AS x
				INNER JOIN(SELECT DrugKey, NDC
							FROM dbo.DrugDim 
							WHERE IsSPX = 1
							) AS dd ON x.Drugkey = dd.Drugkey
				INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
				INNER JOIN Pricing.[dbo].[PriceFact] AS f ON x.DateofServiceKey = f.DateKey													
				INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
																		AND c.CAH_NDC = dd.NDC
				--CROSS APPLY(SELECT f.DateKey, [CAH_NDC], CONVERT(MONEY,f.CardinalInvoicePrice - (f.CardinalInvoicePrice * 0.025)) AS SPXCost -- Per DS-9, 2.5% of Invoice price
				--			FROM Pricing.[dbo].[PriceFact] AS f
				--			INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
				--			WHERE c.[CAH_NDC] IS NOT NULL
				--			AND x.DateofServiceKey = f.DateKey
				--			) AS ca
				--WHERE ca.DateKey = x.DateofServiceKey
				--AND ca.CAH_NDC = dd.NDC
		        ) AS s ON s.DateofServiceKey = t.DateofServiceKey
						AND s.PharmacyKey = t.PharmacyKey 
						AND s.DrugKey = t.DrugKey 
						AND s.EventKey = t.EventKey

	--Generic cost for contract items only
	UPDATE t
	SET GenericCost = ISNULL(s.[GenericCost],0.00)
	FROM [Staging].[ClaimFactFDS] AS t
	INNER JOIN(SELECT DISTINCT x.DateofServiceKey
				, x.PharmacyKey
				, x.DrugKey
				, x.EventKey
				, f.CardinalInvoicePrice
				, ISNULL(CONVERT(MONEY, f.CardinalInvoicePrice - (f.CardinalInvoicePrice * (cah.CAHGericPercent + cah.CAHHCRebatePercent))),0.00) AS [GenericCost]
				FROM [Staging].[ClaimFactFDS] AS x
				INNER JOIN(SELECT DrugKey, NDC
							FROM dbo.DrugDim 
							WHERE [IsCAHGeneric] = 1
							) AS dd ON x.Drugkey = dd.Drugkey
				INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
				INNER JOIN(SELECT u.new_pmid AS PMID, (ISNULL(cah.[new_cahgenericrebate],0.00)/100) AS CAHGericPercent, (ISNULL(cah.[new_cahhighvolumerebate],0.00)/100) AS CAHHCRebatePercent
							FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity] AS c ON u.Userkey = c.UserKey
							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS cah ON cah.[CAHKey] = c.CAHKey
							) AS cah ON cah.PMID = pd.PMID
				INNER JOIN Pricing.[dbo].[PriceFact] AS f ON x.DateofServiceKey = f.DateKey													
				INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
																		AND c.CAH_NDC = dd.NDC
				        ) AS s ON s.DateofServiceKey = t.DateofServiceKey
						AND s.PharmacyKey = t.PharmacyKey 
						AND s.DrugKey = t.DrugKey 
						AND s.EventKey = t.EventKey




	--UPDATE t
	--SET GenericCost = s.[GenericCost]
	--FROM [Staging].[ClaimFactFDS] AS t
	--INNER JOIN(SELECT DISTINCT x.DateofServiceKey
	--			, x.PharmacyKey
	--			, x.DrugKey
	--			, x.EventKey
	--			, ca.[GenericCost]
	--				FROM [Staging].[ClaimFactFDS] AS x
	--				INNER JOIN(SELECT DrugKey, NDC
	--							FROM dbo.DrugDim 
	--							WHERE [IsCAHGeneric] = 1
	--							) AS dd ON x.Drugkey = dd.Drugkey
	--				INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	--				INNER JOIN(SELECT u.new_pmid AS PMID, (ISNULL(cah.[new_cahgenericrebate],0.00)/100) AS CAHGericPercent, (ISNULL(cah.[new_cahhighvolumerebate],0.00)/100) AS CAHHCRebatePercent
	--							FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
	--							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity] AS c ON u.Userkey = c.UserKey
	--							INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS cah ON cah.[CAHKey] = c.CAHKey
	--							) AS cah ON cah.PMID = pd.PMID
	--				CROSS APPLY(SELECT f.DateKey, [CAH_NDC], ISNULL(CONVERT(MONEY, f.CardinalInvoicePrice - (f.CardinalInvoicePrice * (cah.CAHGericPercent + cah.CAHHCRebatePercent))),0.00) AS [GenericCost]
	--							FROM Pricing.[dbo].[PriceFact] AS f
	--							INNER JOIN Pricing.[dbo].[CompetitorDrugDim] AS c ON f.[CompetitorDrugKey] = c.[CompetitorDrugKey]
	--							WHERE c.[CAH_NDC] IS NOT NULL
	--							AND dd.NDC = c.CAH_NDC
	--							AND x.DateofServiceKey = f.DateKey
	--							) AS ca
	--				WHERE ca.DateKey = x.DateofServiceKey
	--				AND ca.CAH_NDC = dd.NDC				
	--			        ) AS s ON s.DateofServiceKey = t.DateofServiceKey
	--					AND s.PharmacyKey = t.PharmacyKey 
	--					AND s.DrugKey = t.DrugKey 
	--					AND s.EventKey = t.EventKey
	

END TRY
BEGIN CATCH

	DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

		SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-'),
		@ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );	

END CATCH
END











GO
