USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_CAH_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_SalesFact_CAH_Load]


	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	SELECT PharmacyKey, DateKey, DrugKey, CAHEventKey, CAHEventDateKey, CAHInvoiceQuantity, CAHUnitAmount, CAHExtendedSales, CAH_AWP, CAH_WAC, TransactionCount
	, [PurchaseAtIP], [GenericPurchaseAtIP],[BrandPurchaseAtIP], [PurchaseQty], [GenericPurchaseQty], [BrandPurchaseQty], [InvoicePerDose], [GenericInvoicePerDose], [BrandInvoicePerDose]
	, [Doses], [GenericDoses], [BrandDoses], PricePerUnit
	FROM [Staging].[SalesFact_CAH]
	WHERE DateKey = @Datekey
	ORDER BY PharmacyKey ASC
	, DateKey ASC 
	, DrugKey ASC
	, CAHEventKey ASC
	, CAHEventDateKey ASC
	
	


END





GO
