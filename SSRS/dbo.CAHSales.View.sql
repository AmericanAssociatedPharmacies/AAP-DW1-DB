USE [SSRS]
GO
/****** Object:  View [dbo].[CAHSales]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CAHSales]
AS
     SELECT [ID]
          , [DC]
          , [CUSTOMER_NAME]
          , [CUSTOMER_NO]
          , [ITEM_NO]
          , [PMID]
          , [STORE]
          , [NDC]
          , [ITEM_TYPE]
          , [ITEM_DESCR]
          , [GENERIC_NAME]
          , [TRADE_NAME]
          , [INV_DATE]
          , [INVOICE_NO]
          , [TYPE]
          , [ORDER_QTY]
          , [SHIP_QTY]
          , [UNIT_COST]
          , [EXT_COST]
          , [CORP_AWP]
          , [WAC]
          , [VENDOR_NAME]
          , [UPC]
          , [CONTRACT_FLAG]
          , [BRAND]
          , [GENERIC_CODE]
          , [STRENGTH]
          , [SHORT_CODE]
          , [ENCODING]
          , [ContractNo]
          , [ContractDesc]
          , [MM_DD_YY_LOAD]
          , [OrderNo]
          , [DateKey]
          , [RowversionID]
     FROM [Purchases].[dbo].[CHPH_AAP];
GO
