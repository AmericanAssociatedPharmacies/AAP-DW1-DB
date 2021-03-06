USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceReport_Attestation_AllStores]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[usp_ComplianceReport_Attestation_AllStores]

			@StartDate DATE
			, @EndDate DATE
			, @TM INT = NULL
			, @IsAttestationRequired BIT = NULL

AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT

	SELECT @StartDateKey = DateKey
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @StartDate

	SELECT @EndDateKey = DateKey
	FROM SalesDDS.dbo.DateDim
	WHERE TheDate = @EndDate

	SELECT dt.PMID, dt.PharmacyName, dt.City, dt.ST, dt.AAPEffectiveDate, dt.TM, dt.AttestationRequired, dt.AttestationDate, a.CompliancePercent, a.GenericCompliancePercent, a.BrandCompliancePercent, b.TotalSales
	FROM(SELECT pd.PMID
		, pd.PharmacyName
		, pd.[AAPEffectiveDate]
		, pd.Territory AS TM
		, dt.AttestationRequired
		, dt.AttestationDate
		, dt.City
		, dt.ST
		FROM RXMaster.dbo.PharmacyDim AS pd 
		INNER JOIN(SELECT CONVERT(INT,u.new_pmid) AS PMID
					, CONVERT(VARCHAR(3), CASE
							WHEN a.[new_primaryattestationrequired] = 1 THEN 'Yes'
							WHEN a.[new_primaryattestationrequired] = 0 THEN 'No'
							ELSE 'No'
							END
							) AS AttestationRequired
					, a.new_primaryattestation AS AttestationDate
					, CONVERT(VARCHAR(50), [address1_city]) AS City
					, CONVERT(VARCHAR(50), [address1_stateorprovince]) AS ST
					FROM DynamicsODS.[dbo].[CRM_AccountEntity] AS c
					INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_User] AS u ON c.UserKey = u.UserKey
					INNER JOIN DynamicsODS.[dbo].[CRM_AccountEntity_Attestation] AS a ON c.AttKey = a.AttKey
					INNER JOIN  DynamicsODS.[dbo].CRM_AccountEntity_Address AS ad ON c.AddressKey = ad.[AddressKey]
					WHERE a.[new_primaryattestationrequired] = ISNULL(@IsAttestationRequired, a.[new_primaryattestationrequired])
					AND u.[new_aapquit] IS NULL
					) AS dt ON pd.PMID = dt.PMID	
		WHERE pd.Territory = ISNULL(@TM,pd.Territory)	
		) AS dt
	INNER JOIN(SELECT dt.PMID
				, CONVERT(DECIMAL(6,2),(SUM(PurchasesIP)/NULLIF(SUM(DispensedIP),0))) AS CompliancePercent --Removed *100 so that its a deciaml DAB 6/22
				, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIGenericPurchasesIP) + SUM(dt.CAHGenericPurchasesIP))/NULLIF(SUM(GenericDispensedIP),0)),0.00)) AS GenericCompliancePercent
				, CONVERT(DECIMAL(6,2), ISNULL(((SUM(dt.APIBrandPurchasesIP) + SUM(dt.CAHBrandPurchasesIP))/NULLIF(SUM(BrandDispensedIP),0)),0.00)) AS BrandCompliancePercent
				FROM(SELECT c.PMID
						, c.TotalQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIInvoicePerDose,0),NULLIF(CAHInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS DispensedIP
						, c.GenericQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIGenericInvoicePerDose,0),NULLIF(c.CAHGenericInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS GenericDispensedIP
						, c.BrandQuantityDispensed * ISNULL(ISNULL(ISNULL(NULLIF(c.APIBrandInvoicePerDose,0),NULLIF(c.CAHBrandInvoicePerDose,0)), agpi.APIPricePerUnit), cgpi.CAHPricePerUnit) AS BrandDispensedIP	
						, (c.APIPurchasedAtIP + c.CAHPurchasedAtIP) AS PurchasesIP
						, c.APIGenericPurchasedAtIP AS APIGenericPurchasesIP
						, c.APIBrandPurchasedAtIP AS APIBrandPurchasesIP
						, c.CAHGenericPurchasedAtIP AS CAHGenericPurchasesIP
						, c.CAHBrandPurchasedAtIP AS CAHBrandPurchasesIP	
						FROM Reports.[dbo].[ComplianceAllStores] AS c
						INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON c.PMID = pd.PMID
						LEFT OUTER JOIN(SELECT dd.GPI
										, MIN(a.APIPricePerUnit) AS APIPricePerUnit
										FROM ODSIntake.[dbo].[vwAPIPricing] AS a
										INNER JOIN SalesDDS.dbo.DrugDim AS dd ON a.NDC = dd.NDC
										INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
										WHERE dd.DrugKey = (dd.DrugKey + 0)
										GROUP BY dd.GPI 
										) AS agpi ON agpi.GPI = c.GPI						
						LEFT OUTER JOIN(SELECT dd.GPI
										,MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
										FROM CAHODS.dbo.CardinalComplete AS c
										INNER JOIN SalesDDS.dbo.DrugDim AS dd ON c.NDC = dd.NDC
										GROUP BY dd.GPI
										) AS cgpi ON cgpi.GPI = c.GPI		
						WHERE c.MonthDate BETWEEN @StartDate AND @EndDate
						AND c.PMID = (c.PMID + 0)
						AND pd.Territory = ISNULL(@TM,pd.Territory)	
				) AS dt	
				GROUP BY dt.PMID
			) AS a ON dt.PMID = a.PMID
	INNER JOIN(SELECT pd.PMID
			, (ISNULL(a.APISales,0.00) + ISNULL(c.CAHSales,0.00)) AS TotalSales
			FROM SalesDDS.dbo.PharmacyDim AS pd
			LEFT OUTER JOIN(SELECT pd.PMID
							, SUM([APIExtendedAmount]) AS APISales
							FROM SalesDDS.dbo.SalesFact_API AS f
							INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
							WHERE f.DateKey BETWEEN @StartDateKey AND @EndDateKey
							AND pd.Territory = ISNULL(@TM,pd.Territory)
							AND EXISTS(SELECT 1
										FROM SalesDDS.dbo.EventDimAPI AS e
										WHERE f.[APIEventKey] = e.EventKey
										AND f.DateKey = e.DateKey
										AND e.[IsCredit] = 0
										AND e.EventKey > 0
										AND e.DateKey > 0
										)
							GROUP BY pd.PMID
							) AS a ON pd.PMID = a.PMID
			LEFT OUTER JOIN(SELECT pd.PMID
							, SUM([CAHExtendedSales]) AS CAHSales
							FROM SalesDDS.[dbo].[SalesFact_CAH] AS f
							INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON f.PharmacyKey = pd.PharmacyKey
							WHERE f.DateKey BETWEEN @StartDateKey AND @EndDateKey
							AND pd.Territory = ISNULL(@TM,pd.Territory)		
							GROUP BY pd.PMID
							) AS c ON c.PMID = pd.PMID
			) AS b ON dt.PMID = b.PMID
ORDER BY dt.PMID ASC
	

END









GO
