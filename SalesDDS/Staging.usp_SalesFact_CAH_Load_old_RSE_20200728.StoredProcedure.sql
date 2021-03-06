USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_SalesFact_CAH_Load_old_RSE_20200728]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [Staging].[usp_SalesFact_CAH_Load_old_RSE_20200728]


	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	SELECT dt.PharmacyKey, dt.DateKey, dt.DrugKey, dt.CAHEventKey, dt.CAHEventDateKey, dt.CAHInvoiceQuantity, dt.CAHUnitAmount, dt.CAHExtendedSales, dt.CAH_AWP, dt.CAH_WAC, dt.TransactionCount
	, dt.PricePerUnit
	FROM(SELECT PharmacyKey, DateKey, DrugKey, CAHEventKey, CAHEventDateKey, CAHInvoiceQuantity, CAHUnitAmount, CAHExtendedSales, CAH_AWP, CAH_WAC, TransactionCount
		, CONVERT(DECIMAL(18,2),0) AS PricePerUnit			
		 FROM [Staging].[vwSalesFact_CAH] 
		 WHERE DateKey = @Datekey
		) AS dt
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.SalesFact_CAH AS c (NOLOCK)
						WHERE dt.CAHEventKey =  c.CAHEventKey
						AND dt.CAHEventDateKey = c.DateKey
						AND dt.DrugKey = c.DrugKey
						AND dt.PharmacyKey = c.PharmacyKey						
					)
	ORDER BY dt.PharmacyKey ASC
	, dt.DateKey ASC 
	, dt.DrugKey ASC
	, dt.CAHEventKey ASC
	, dt.CAHEventDateKey ASC

	


END









GO
