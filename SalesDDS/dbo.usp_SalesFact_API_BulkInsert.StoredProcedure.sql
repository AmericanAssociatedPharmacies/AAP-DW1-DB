USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_API_BulkInsert]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_SalesFact_API_BulkInsert]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT a.PharmacyKey, a.DateKey, a.DrugKey, a.APIEventKey, a.APIEventDateKey, a.APIInvoiceQuantity, a.APIUnitAmount, a.APILineItemAmount, a.APIExtendedAmount
	, a.[APIHoldBackPercent], a.[APIHoldBackAmount], a.[RebateAfterAPIHoldbackAmount], a.[AffiliateHoldbackPercent], a.[AffiliateHoldbackAmount]
	, a.[FinalRebateAmount], a.PurchaseAtIP, a.[GenericPurchaseAtIP], a.[BrandPurchaseAtIP], a.[PurchaseQty], a.[GenericPurchaseQty]
	, a.[BrandPurchaseQty], a.[InvoicePerDose], a.[GenericInvoicePerDose], a.[BrandInvoicePerDose], a.[Doses], a.[GenericDoses], a.[BrandDoses]
	, a.PricePerUnit, a.IsCredit, a.GPIKey
	FROM Staging.SalesFact_API AS a
	WHERE a.DateKey = @DateKey
	AND NOT EXISTS(SELECT 1
						FROM dbo.SalesFact_API AS s WITH(NOLOCK)
						WHERE a.[PharmacyKey] = s.[PharmacyKey]
						AND a.[DateKey] = s.DateKey
						AND a.[DrugKey] = s.DrugKey
						AND a.[APIEventKey] = s.[APIEventKey]
						AND a.[APIEventDateKey] = s.[APIEventDateKey]
						)

END




GO
