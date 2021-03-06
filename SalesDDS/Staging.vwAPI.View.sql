USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwAPI]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [Staging].[vwAPI]

AS

	SELECT ISNULL(pd.PharmacyKey, 0) AS PharmacyKey
	, dt.APISalesInvoiceID
	, dt.InvNbr
	, dt.OrderNbr
	, dt.InvDate
	, dt.[WHAccountID]
	, dt.CustomerName
	, dt.CarrierCode
	, dt.CarrierDesc
	, dt.CustomerRef
	, dt.Whsnum
	, dt.OrdType
	, dt.DateLoaded
	, dt.APISalesDetailID
	, dt.InvLine
	, dt.APIItemNbr
	, dt.ItemDescription
	, dt.Qty
	, dt.UnitAmount
	, dt.ItemGrp
	, dt.AcctGrp
	, dt.Territory
	, dt.LineAmt
	, dt.ExtSales
	, dt.NDC_orig
	, dt.NDC
	, dt.Type
	, dt.WHNbr
	, dt.Rebate
	, dt.DateKey
	, dt.APIHoldBackPercent
	, dt.APIHoldBackAmount
	, dt.[RebateAfterAPIHoldbackAmount]
	, dt.[AffiliateHoldbackPercent]
	, dt.[AffiliateHoldbackAmount]
	, dt.[FinalRebateAmount]
	, dt.RowversionID
	, ISNULL(pd.PMID,0) AS PMID
	FROM(SELECT ISNULL(B.ID, A.ID) AS APISalesInvoiceID
		, ISNULL(A.InvNbr, B.InvNbr) AS InvNbr
		, ISNULL(A.OrderNbr, B.OrderNbr) AS OrderNbr
		, ISNULL(A.InvDate, B.InvDate) AS InvDate
		, ISNULL(A.WHAccountID, B.[WHAccountID]) AS [WHAccountID]
		, ISNULL(A.CustomerName, B.CustomerName) AS CustomerName
		, A.CarrierCode
		, A.CarrierDesc
		, NULLIF(A.CustomerRef,  ' ') AS CustomerRef
		, ISNULL(A.Whsnum, B.WHNbr) AS Whsnum
		, A.OrdType
		, A.DateLoaded
		, B.ID AS APISalesDetailID
		, B.InvLine
		, B.APIItemNbr
		, B.ItemDescription
		, IIF(B.ExtSales < 0.00 and B.Qty > 0, (-1 * B.Qty), B.Qty) AS Qty
		, B.UnitAmount
		, B.ItemGrp
		, B.AcctGrp
		, B.Territory
		, B.LineAmt
		, B.ExtSales
		, NULLIF(B.NDC_orig,  ' ') AS NDC_orig
		, NULLIF(B.NDC,  ' ') AS NDC
		, B.Type
		, A.[Whsnum] AS WHNbr
		, B.Rebate
		, CAST(CONVERT(VARCHAR(20), B.INVDATE, 112) AS INT) AS DateKey
		, B.APIHoldBackPercent
		, B.APIHoldBackAmount
		, B.[RebateAfterAPIHoldbackAmount]
		, B.[AffiliateHoldbackPercent]
		, B.[AffiliateHoldbackAmount]
		, B.[FinalRebateAmount]
		, CONVERT(VARBINARY(8), B.RowversionID) AS RowversionID
		, CAST(CONVERT(VARCHAR(20), DATEADD(DAY, 1, B.INVDATE), 112) AS INT) AS EndDateKey
		FROM API.dbo.APISalesDetail AS B 
		LEFT OUTER JOIN API.dbo.APISalesInvoice AS A ON A.WHAccountID = B.WHAccountID
												AND A.InvNbr = B.InvNbr
												AND A.InvDate = B.InvDate
		--WHERE B.InvDate = @Date
		) AS dt
	LEFT OUTER JOIN dbo.PharmacyDim AS pd ON dt.WHAccountID = pd.APINumber
												AND dt.DateKey BETWEEN pd.APIEffectiveDateKey AND pd.APIQuitDateKey



GO
