USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_Detailed]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_Compliance_Detailed]

		@PMID INT
		, @StartDate DATETIME
		, @EndDate DATETIME
		, @IsGeneric BIT = NULL
		, @IsBrand BIT = NULL

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

	SELECT DISTINCT dd.GPI
	, dd.[Description]
	, PurchaseQty AS [Purchase Qty]
	, PurchaseIP AS [Purchases @ IP]
	, QtyDispensed AS [Dispense Qty]
	, DispensedIP AS [Dispense @ IP]
	, LeakageQty AS [Leakage Quantity]
	, LeakeageIP AS [Leakage @ IP]
	--PMID, GPIKey, QtyDispensed, PurchaseQty,PurchaseIP, DispensedIP, LeakageQty, LeakeageIP
	FROM Reports.[dbo].[tvfComplianceDetail] (@PMID, @StartDateKey, @EndDateKey, @IsGeneric, @IsBrand) AS t
	INNER JOIN DrugMaster.dbo.DrugDim AS dd ON t.GPIKey = dd.GPIKey
	WHERE (PurchaseQty > 0
			OR QtyDispensed > 0
			)
	ORDER BY dd.GPI ASC


END




GO
