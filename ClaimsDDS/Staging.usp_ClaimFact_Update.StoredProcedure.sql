USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_ClaimFact_Update]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_ClaimFact_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY



	UPDATE x
	SET [DispensedRevenue] = CONVERT(MONEY, x.[ClaimAmountPaid] + x.[CopayAmountPaid] + x.[OtherAmountPaid] + x.[eVoucherAmountPaid])
	FROM [Staging].[ClaimFactFDS] AS x


	UPDATE x
	SET [BrandCost] = CONVERT(MONEY, f.CustomerInvoicePrice - (f.CustomerInvoicePrice * CAH_COG_Brand_Percent))
	FROM [Staging].[ClaimFactFDS] AS x
	INNER JOIN dbo.DrugDim AS dd ON x.Drugkey = dd.Drugkey
	INNER JOIN CAHODS.dbo.vwCurrentFormulary AS f ON dd.NDC = f.NDC
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN(SELECT u.new_pmid AS PMID, (cah.[new_cah_cog]/100) AS CAH_COG_Brand_Percent
				FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
				INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity] AS c ON u.Userkey = c.UserKey
				INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS cah ON cah.[CAHKey] = c.CAHKey
				WHERE cah.[new_cah_cog] IS NOT NULL
				) AS cah ON cah.PMID = pd.PMID
	WHERE [IsCAHGeneric] = 0


	UPDATE x
	SET [SPXCost] = CONVERT(MONEY,f.CustomerInvoicePrice - (f.CustomerInvoicePrice * 0.025)) -- Per DS-9, 2.5% of Invoice price
	FROM [Staging].[ClaimFactFDS] AS x
	INNER JOIN dbo.DrugDim AS dd ON x.Drugkey = dd.Drugkey
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN CAHODS.dbo.vwCurrentFormulary AS f ON dd.NDC = f.NDC
	WHERE [IsSPX] = 1

	UPDATE x
	SET [GenericCost] = CONVERT(MONEY, f.CustomerInvoicePrice - (f.CustomerInvoicePrice * (CAHGericPercent + CAHHCRebatePercent)))
	FROM [Staging].[ClaimFactFDS] AS x
	INNER JOIN dbo.DrugDim AS dd ON x.Drugkey = dd.Drugkey
	INNER JOIN CAHODS.dbo.vwCurrentFormulary AS f ON dd.NDC = f.NDC
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN(SELECT u.new_pmid AS PMID, (ISNULL(cah.[new_cahgenericrebate],0.00)/100) AS CAHGericPercent, (ISNULL(cah.[new_cahhighvolumerebate],0.00)/100) AS CAHHCRebatePercent
				FROM DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u
				INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity] AS c ON u.Userkey = c.UserKey
				INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_CAH] AS cah ON cah.[CAHKey] = c.CAHKey
				) AS cah ON cah.PMID = pd.PMID
	WHERE [IsCAHGeneric] = 1

	DECLARE @StartDateKey INT
	, @EndDateKey INT

	--6 months ago
	SELECT @StartDateKey = dd.DateKey
	FROM dbo.DateDim AS dd
	CROSS JOIN(SELECT CONVERT(DATE,DATEADD(mm, -6, GETDATE())) AS C1
				) AS cj
	WHERE dd.TheDate = cj.C1

	SELECT @EndDateKey = DateKey
	FROM dbo.DateDim
	WHERE TheDate = CONVERT(DATE, GETDATE())

	SELECT dd.NDC, AVG([CardinalInvoicePrice]) AS CANInvoicePrice
	FROM Pricing.[dbo].[PriceFact] AS p
	INNER JOIN [Pricing].dbo.DrugDim AS dd ON p.DrugKey = dd.DrugKey
	WHERE p.DateKey BETWEEN @StartDateKey AND @EndDateKey
	GROUP BY dd.NDC

	UPDATE x
	SET [GenericCost] = c.CAHInvoicePrice
	FROM [Staging].[ClaimFactFDS] AS x
	INNER JOIN dbo.DrugDim AS dd ON x.Drugkey = dd.Drugkey
	INNER JOIN dbo.PharmacyDim AS pd ON x.PharmacyKey = pd.PharmacyKey
	INNER JOIN(SELECT dd.NDC, AVG([CardinalInvoicePrice]) AS CAHInvoicePrice
				FROM Pricing.[dbo].[PriceFact] AS p
				INNER JOIN [Pricing].dbo.DrugDim AS dd ON p.DrugKey = dd.DrugKey
				WHERE p.DateKey BETWEEN @StartDateKey AND @EndDateKey
				GROUP BY dd.NDC
				) AS c ON dd.NDC = c.NDC
	WHERE NOT EXISTS(SELECT 1
					FROM CAHODS.dbo.vwCurrentFormulary AS f 
					WHERE dd.NDC = f.NDC
					)

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
