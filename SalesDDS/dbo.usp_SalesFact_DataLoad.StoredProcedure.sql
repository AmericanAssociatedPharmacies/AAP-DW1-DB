USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_DataLoad]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_SalesFact_DataLoad]

	@Date DATETIME

AS


SET NOCOUNT ON;

BEGIN


	SELECT dt.DrugKey
	, dt.PharmacyKey
	, dt.InvDateKey
	, dt.EventKey
	, dt.InvoiceLineNumber
	, dt.CAHOrderQuantity
	, dt.CAHShipQuantity
	, dt.CAHUnitAmount
	, dt.CAHExtendedSales
	, dt.CAH_AWP
	, dt.CAH_WAC	
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dd.DrugKey, pd.PharmacyKey, di.DateKey, ed.EventKey, cp.InvoiceLineNumber ORDER BY(SELECT NULL)) AS RN
	, dd.DrugKey
	, pd.PharmacyKey
	, di.DateKey AS InvDateKey
	, ed.EventKey
	, cp.InvoiceLineNumber
	, cp.[ORDER_QTY] AS CAHOrderQuantity
	, cp.[SHIP_QTY] AS CAHShipQuantity
	, cp.[UNIT_COST] AS CAHUnitAmount
	, cp.[EXT_COST] AS CAHExtendedSales
	, cp.[CORP_AWP] AS CAH_AWP
	, cp.[WAC] AS CAH_WAC	
	FROM [Staging].[CHPH_AAP] AS cp
	INNER JOIN SalesDDS.dbo.EventDim AS ed ON cp.NDC = ed.CAH_NDC
									AND cp.INV_DATE = ed.CAHInvoiceDate
									AND cp.PMID = ed.CAH_PMID
	INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON pd.PMID = ed.CAH_PMID
	INNER JOIN SalesDDS.dbo.DrugDim AS dd ON ed.CAH_NDC = dd.NDC
	INNER JOIN SalesDDS.dbo.DateDim AS di ON ed.CAHInvoiceDate = di.TheDate
	WHERE cp.INV_DATE = @Date
	) AS dt
	WHERE dt.RN = 1
	ORDER BY dt.PharmacyKey ASC
	, dt.InvDateKey ASC
	, dt.DrugKey ASC 
	, dt.EventKey ASC
	, dt.InvoiceLineNumber ASC 

END

GO
