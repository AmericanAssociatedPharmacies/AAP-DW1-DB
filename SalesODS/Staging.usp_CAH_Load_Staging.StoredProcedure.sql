USE [SalesODS]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_Load_Staging]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_CAH_Load_Staging]

	@DateKey INT
	
AS

SET NOCOUNT ON;


BEGIN

	
	SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY ID ASC)) AS RowID
	 , ID, DC, CUSTOMER_NAME, CUSTOMER_NO, ITEM_NO, PMID, STORE, NDC, ITEM_TYPE, ITEM_DESCR, GENERIC_NAME, TRADE_NAME, INV_DATE, INVOICE_NO
	, TYPE, ORDER_QTY, SHIP_QTY, UNIT_COST, EXT_COST, CORP_AWP, WAC, VENDOR_NAME, UPC, CONTRACT_FLAG, BRAND, GENERIC_CODE, STRENGTH, SHORT_CODE
	, ENCODING, ContractNo, ContractDesc, MM_DD_YY_LOAD, OrderNo
	--, CONVERT(INT, ROW_NUMBER() OVER(PARTITION BY ISNULL([PMID],0), a.DateKey, [INVOICE_NO], NDC ORDER BY [PMID] ASC, a.DateKey ASC, [INVOICE_NO] ASC, NDC ASC)) AS InvoiceLineNumber
	, InvoiceLineNumber
	, CAST(CONVERT(VARCHAR(20), INV_DATE, 112) AS INT) AS DateKey
	, CONVERT(BIT,0) AS IsBackupSource
	, CONVERT(BIT,0) AS IsTenSource
	, CONVERT(BIT,0) AS [IsSourceWeekly]
	, CONVERT(BIT,0) AS [IsTopGenerics]
	, a.RowversionID_DB1
	, a.DEA
	FROM Staging.[CHPH_AAP] AS a
	WHERE a.DateKey = @Datekey
	ORDER BY ID ASC

END













GO
