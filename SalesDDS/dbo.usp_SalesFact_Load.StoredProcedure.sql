USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_SalesFact_Load]

	@APIStartDateKey INT
	, @APIEndDateKey INT
	, @CAHStartDateKey INT
	, @CAHEndDateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT s.PharmacyKey
	, s.DateKey
	, s.DrugKey
	, s.APIEventKey
	, s.CAHEventKey
	, s.APIInvoiceQuantity
	, s.APIUnitAmount
	, s.APILineItemAmount
	, s.APIExtendedAmount
	, s.CAHOrderQuantity
	, s.CAHShipQuantity
	, s.CAHUnitAmount
	, s.CAHExtendedSales
	, s.CAH_AWP
	, s.CAH_WAC
	FROM [Staging].[SalesFact] AS s
	WHERE NOT EXISTS(SELECT 1
					FROM dbo.SalesFact AS sf
					WHERE s.PharmacyKey = sf.PharmacyKey
					AND s.DateKey = sf.DateKey
					AND s.DrugKey = sf.DrugKey
					AND s.APIEventKey = sf.APIEventKey
					AND s.CAHEventKey = sf.CAHEventKey	
					)
	ORDER BY s.PharmacyKey ASC
	, s.DateKey ASC
	, s.DrugKey ASC
	, s.APIEventKey ASC
	, s.CAHEventKey ASC

END


GO
