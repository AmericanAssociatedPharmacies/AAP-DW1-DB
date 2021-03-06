USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_RecreatePartitionedIndexes]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_API_RecreatePartitionedIndexes]

AS

BEGIN

--/************************************************************************************************************************

--												Drop Indexes

--**************************************************************************************************************************/



----DROP INDEX [NCC_EventDimAPI] ON [dbo].[EventDimAPI]
----GO

----DROP INDEX [NCI_EventDimAPI_RowversionID_2] ON [dbo].[EventDimAPI]
----GO

----DROP INDEX [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
----GO

----DROP INDEX [NCI_EventDim_RowversionID] ON [dbo].[EventDimAPI]
----GO

----DROP INDEX [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
----GO

----DROP INDEX [NCI_EventDimAPI_DateKey_APISalesDetailID] ON [dbo].[EventDimAPI]
----GO

----ALTER TABLE [dbo].[EventDimAPI] DROP CONSTRAINT [CPK_API_EventDim]
----GO

----DROP INDEX [NCI_SalesFactAPI_DateKey] ON [dbo].[SalesFact_API]
----GO

----DROP INDEX [NCI_SalesFact_API_DrugKey_PharmacyKey_DateKey] ON [dbo].[SalesFact_API]
----GO

----DROP INDEX [NCC_SalesFact_API] ON [dbo].[SalesFact_API]
----GO

----DROP INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [dbo].[SalesFact_API]
----GO

----DROP INDEX [NCI_SalesFact_API_DateKey] ON [dbo].[SalesFact_API]
----GO

----ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [CPK_SalesFact_API]
----GO

----ALTER TABLE [Staging].[API] DROP CONSTRAINT [CPK_Staging_API]
----GO

----DROP INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [Staging].[SalesFact_API]
----GO

----DROP INDEX [NCI_Staging_SalesFact_API_DateKey] ON [Staging].[SalesFact_API]
----GO

----ALTER TABLE [Staging].[SalesFact_API] DROP CONSTRAINT [CPK_Staging_SalesFact_API]
----GO

--/************************************************************************************************************************

--												End Drop Indexes

--**************************************************************************************************************************/





--	EXEC [dbo].[usp_PartitionMaitenance_RangeLeft]






/************************************************************************************************************************

												Create Indexes

**************************************************************************************************************************/

--dbo.EventDimAPI
ALTER TABLE [dbo].[EventDimAPI] ADD  CONSTRAINT [CPK_API_EventDim] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_EventDimAPI_RowversionID_2] ON [dbo].[EventDimAPI]
(
	[RowversionID] ASC
)
INCLUDE ( 	[EventKey],
	[PMID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
(
	[IsCredit] ASC,
	[IsOrderFee] ASC,
	[IsSourceDelete] ASC
)
INCLUDE ( 	[EventKey],
	[DateKey],
	[InvoiceDate],
	[Type]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_EventDim_RowversionID] ON [dbo].[EventDimAPI]
(
	[RowversionID] ASC,
	[DateKey] ASC
)
INCLUDE ( 	[EventKey],
	[PMID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
(
	[IsCredit] ASC,
	[Type] ASC,
	[IsOrderFee] ASC,
	[IsSourceDelete] ASC
)
INCLUDE ( 	[EventKey],
	[DateKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_EventDimAPI_DateKey_APISalesDetailID] ON [dbo].[EventDimAPI]
(
	[DateKey] ASC,
	[APISalesDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_EventDimAPI] ON [dbo].[EventDimAPI]
(
	[EventKey],
	[DateKey],
	[InvoiceNumber],
	[InvoiceLineNumber],
	[InvoiceDate],
	[TerritoryManagerNumber],
	[AccountNumber],
	[CustomerReference],
	[PMID],
	[WharehouseNumber],
	[ItemGroupNumber],
	[AccountGroupNumber],
	[NDCOriginal],
	[NDC],
	[ItemNumber],
	[RowversionID],
	[RowCreatedDate],
	[IsCredit],
	[Type],
	[IsOrderFee],
	[ItemDescription],
	[APISalesDetailID],
	[IsSourceDelete]
)WITH (DROP_EXISTING = OFF)
ON [psSalesFact_RangeLeft](DateKey)




DBCC SHRINKFILE(2,10)


--dbo.SalesFact_API
ALTER TABLE [dbo].[SalesFact_API] ADD  CONSTRAINT [CPK_SalesFact_API] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[APIEventKey] ASC,
	[APIEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_SalesFactAPI_DateKey] ON [dbo].[SalesFact_API]
(
	[DateKey] ASC
)
INCLUDE ( 	[PharmacyKey],
	[DrugKey],
	[PurchaseAtIP],
	[GenericPurchaseAtIP],
	[BrandPurchaseAtIP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DrugKey_PharmacyKey_DateKey] ON [dbo].[SalesFact_API]
(
	[DrugKey] ASC,
	[PharmacyKey] ASC,
	[DateKey] ASC
)
INCLUDE ( 	[PurchaseAtIP],
	[GenericPurchaseAtIP],
	[BrandPurchaseAtIP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_SalesFact_API] ON [dbo].[SalesFact_API]
(
	[PharmacyKey],
	[DateKey],
	[DrugKey],
	[APIEventKey],
	[APIEventDateKey],
	[APIInvoiceQuantity],
	[APIUnitAmount],
	[APILineItemAmount],
	[APIExtendedAmount],
	[TransactionCount],
	[APIHoldBackPercent],
	[APIHoldBackAmount],
	[RebateAfterAPIHoldbackAmount],
	[AffiliateHoldbackPercent],
	[AffiliateHoldbackAmount],
	[FinalRebateAmount],
	[PurchaseAtIP],
	[GenericPurchaseAtIP],
	[BrandPurchaseAtIP],
	[PurchaseQty],
	[GenericPurchaseQty],
	[BrandPurchaseQty],
	[InvoicePerDose],
	[GenericInvoicePerDose],
	[BrandInvoicePerDose],
	[Doses],
	[GenericDoses],
	[BrandDoses]
)WITH (DROP_EXISTING = OFF)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [dbo].[SalesFact_API]
(
	[DateKey] ASC,
	[APIEventKey] ASC,
	[APIEventDateKey] ASC
)
INCLUDE ( 	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey] ON [dbo].[SalesFact_API]
(
	[DateKey] ASC
)
INCLUDE ( 	[PharmacyKey],
	[DrugKey],
	[APIInvoiceQuantity],
	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


DBCC SHRINKFILE(2,10)


--Staging.API
ALTER TABLE [Staging].[API] ADD  CONSTRAINT [CPK_Staging_API] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


DBCC SHRINKFILE(2,10)


--Staging.SalesFact_API
ALTER TABLE [Staging].[SalesFact_API] ADD  CONSTRAINT [CPK_Staging_SalesFact_API] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[APIEventKey] ASC,
	[APIEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [Staging].[SalesFact_API]
(
	[DateKey] ASC,
	[APIEventKey] ASC,
	[APIEventDateKey] ASC
)
INCLUDE ( 	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED INDEX [NCI_Staging_SalesFact_API_DateKey] ON [Staging].[SalesFact_API]
(
	[DateKey] ASC
)
INCLUDE ( 	[PharmacyKey],
	[DrugKey],
	[APIInvoiceQuantity],
	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


DBCC SHRINKFILE(2,10)

ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_EventDimAPI] FOREIGN KEY([APIEventKey], [DateKey])
REFERENCES [dbo].[EventDimAPI] ([EventKey], [DateKey])


END
GO
