USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_API_Load_Staging]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [Staging].[usp_API_Load_Staging]

	@DateKey INT
	

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @Date DATETIME
	

	SET @Date = CONVERT(datetime, convert(varchar(10), @DateKey))
	

	SELECT ISNULL(B.ID, A.ID) AS APISalesInvoiceID
	, ISNULL(A.InvNbr, B.InvNbr) AS InvNbr
	, ISNULL(A.OrderNbr, B.OrderNbr) AS OrderNbr
	, ISNULL(A.InvDate, B.InvDate) AS InvDate
	, ISNULL(LTRIM(RTRIM(A.WHAccountID)), LTRIM(RTRIM(B.[WHAccountID]))) AS [WHAccountID]
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
	, NULL AS PMID
	, B.APIHoldBackPercent
	, B.APIHoldBackAmount
	, B.[RebateAfterAPIHoldbackAmount]
    , B.[AffiliateHoldbackPercent]
    , B.[AffiliateHoldbackAmount]
    , B.[FinalRebateAmount]
	, CONVERT(VARBINARY(8), B.RowversionID) AS RowversionID
	FROM API.dbo.APISalesDetail AS B 
	LEFT OUTER JOIN API.dbo.APISalesInvoice AS A ON A.WHAccountID = B.WHAccountID
											AND A.InvNbr = B.InvNbr
											AND A.InvDate = B.InvDate																
	WHERE B.InvDate = @Date



END







	
















GO
