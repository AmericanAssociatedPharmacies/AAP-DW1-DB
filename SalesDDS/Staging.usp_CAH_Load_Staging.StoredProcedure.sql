USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_Load_Staging]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Staging].[usp_CAH_Load_Staging]

	@DateKey INT
	

AS

SET NOCOUNT ON;


BEGIN	

	SELECT dt.RowID, dt.ID, dt.DC, dt.CUSTOMER_NAME, dt.CUSTOMER_NO, dt.ITEM_NO, dt.STORE, dt.NDC, dt.ITEM_TYPE, dt.ITEM_DESCR, dt.GENERIC_NAME, dt.TRADE_NAME, dt.INV_DATE, dt.INVOICE_NO
	, dt.TYPE, dt.ORDER_QTY, dt.SHIP_QTY, dt.UNIT_COST, dt.EXT_COST, dt.CORP_AWP, dt.WAC, dt.VENDOR_NAME, dt.UPC, dt.CONTRACT_FLAG, dt.BRAND, dt.GENERIC_CODE, dt.STRENGTH, dt.SHORT_CODE
	, dt.ENCODING, dt.ContractNo, dt.ContractDesc, dt.MM_DD_YY_LOAD, dt.OrderNo, dt.InvoiceLineNumber,  dt.DateKey, dt.IsBackupSource, dt.IsTenSource
	, dt.[IsSourceWeekly], dt.[IsTopGenerics], c.PMID
	FROM(SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY ID ASC)) AS RowID
		 , ID, DC, CUSTOMER_NAME, CUSTOMER_NO, ITEM_NO, STORE, NDC, ITEM_TYPE, ITEM_DESCR, GENERIC_NAME, TRADE_NAME, INV_DATE, INVOICE_NO
		, TYPE, ORDER_QTY, SHIP_QTY, UNIT_COST, EXT_COST, CORP_AWP, WAC, VENDOR_NAME, UPC, CONTRACT_FLAG, BRAND, GENERIC_CODE, STRENGTH, SHORT_CODE
		, ENCODING, ContractNo, ContractDesc, MM_DD_YY_LOAD, OrderNo
		, CONVERT(INT, ROW_NUMBER() OVER(PARTITION BY ISNULL([PMID],0), a.DateKey, [INVOICE_NO], NDC ORDER BY [PMID] ASC, a.DateKey ASC, [INVOICE_NO] ASC, NDC ASC)) AS InvoiceLineNumber
		, CAST(CONVERT(VARCHAR(20), INV_DATE, 112) AS INT) AS DateKey
		, ISNULL(f1.[IsBackupSource], 0) AS IsBackupSource
		, ISNULL(f1.[IsTenSource], 0) AS IsTenSource
		, ISNULL(f1.[IsSourceWeekly], 0) AS [IsSourceWeekly]
		, ISNULL(f1.[IsTopGenerics], 0) AS [IsTopGenerics]
		, a.RowversionID
		FROM Purchases.[dbo].[CHPH_AAP] AS a
		LEFT OUTER JOIN (SELECT [CorrectedNDCUPC]
							, DateKey
							, [IsBackupSource]
							, [IsTenSource]
							, [IsSourceWeekly]
							, [IsTopGenerics]
							FROM CAHODS.dbo.CAH_FormularyFile
							WHERE DateKey = @Datekey
							) AS f1 ON a.DateKey = f1.DateKey
										AND a.NDC = f1.CorrectedNDCUPC	
		WHERE a.DateKey = @Datekey
	  ) AS dt
	 LEFT OUTER JOIN DynamicsODS.[dbo].[vwCAHAccount] AS c ON dt.CUSTOMER_NO = c.CorrectedCAHAccountNo
															AND dt.DateKey BETWEEN c.AAPEffectiveDateKey AND c.AAPQuitDateKey	
	ORDER BY ID ASC

END









GO
