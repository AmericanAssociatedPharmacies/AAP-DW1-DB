USE [SalesDDS]
GO
/****** Object:  View [Staging].[vwEventDimCAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [Staging].[vwEventDimCAH]

AS

SELECT RowID
, DateKey 
, [INVOICE_NO] AS InvoiceNumber 
, [InvoiceLineNumber] AS[InvoiceLineNumber] 
, [INV_DATE] AS [InvoiceDate] 
, [PMID] 
, DC AS	[DistributionCenter] 
, [NDC] 
, CONVERT(VARCHAR(25), LEFT(ContractNo, 25)) AS [ContractNumber] 
, CONVERT(VARCHAR(250), CASE
	WHEN [ContractDesc] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LEFT([ContractDesc], 250)
	END
	)	AS [ContractDescription] 
, CONVERT(VARCHAR(25), LEFT([UPC], 25)) AS  [UPC]
, CONVERT(VARCHAR(25), LEFT([ITEM_NO], 25)) AS [ItemNumber] 
, [ITEM_DESCR] AS ItemDescription 
, [ITEM_TYPE] AS [ItemType] 
, [OrderNo] AS [OrderNumber] 
, [IsBackupSource] 
, [IsTenSource] 
, [IsSourceWeekly] 
, [IsTopGenerics] 
, [RowversionID] 
, ID AS [CHPH_AAP_ID]
, RowversionID_DB1
, LTRIM(RTRIM(LEFT([CUSTOMER_NO],25))) AS [CAHAccountNo]
, CONVERT(VARCHAR(1),LTRIM(RTRIM(Type))) AS [CAHType]
, CONVERT(VARCHAR(1),LTRIM(RTRIM(Brand))) AS Brand
, DEA
FROM Staging.CAH NOLOCK






GO
